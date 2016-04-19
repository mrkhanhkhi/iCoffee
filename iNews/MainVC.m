//
//  MainVC.m
//  iNews
//
//  Created by Nguyen Duy Khanh on 3/31/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import "MainVC.h"
#import "CategoryCell.h"
#import "DetailScreenVC.h"
#import <HTHorizontalSelectionList/HTHorizontalSelectionList.h>
#import "TitleCell.h"
#import "ContentScreenVC.h"
#import "ParseData.h"
#import "Record.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "REFrostedViewController.h"
#import "SideMenuNavVC.h"
#import "SideMenuVC.h"
#import "MBProgressHUD.h"
#import "iOSRequest.h"

@interface MainVC () <UITableViewDataSource, UITableViewDelegate, HTHorizontalSelectionListDataSource,HTHorizontalSelectionListDelegate>
{
    NSArray *arrStringURL;
    NSArray *viewControllers;
    NSMutableArray *dataTable;
    BOOL ishowProGress;
    int numberSecondCheckInternet,timeInterNet;
}

@property (weak, nonatomic) IBOutlet HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSArray *titleList;
@property (weak,nonatomic) IBOutlet UITableView *tableView;
@property (weak,nonatomic) UIActivityIndicatorView *indicator;


@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"VNexpress";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //Horizontal list
    self.selectionList.delegate = self;
    self.selectionList.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.selectionList.selectionIndicatorAnimationMode = HTHorizontalSelectionIndicatorAnimationModeLightBounce;
    self.selectionList.showsEdgeFadeEffect = YES;
    
    self.selectionList.selectionIndicatorColor = [UIColor redColor];
    [self.selectionList setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.selectionList setTitleFont:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
    [self.selectionList setTitleFont:[UIFont boldSystemFontOfSize:13] forState:UIControlStateSelected];
    [self.selectionList setTitleFont:[UIFont boldSystemFontOfSize:13] forState:UIControlStateHighlighted];
    
    self.titleList = @[@"Tổng Hợp",
                      @"Thời Sự",
                      @"Thế Giới",
                      @"Kinh Doanh",
                      @"Giải Trí",
                      @"Thể Thao",
                      @"Pháp Luật",
                      @"Giáo Dục",
                      @"Du Lịch",
                      ];
    
    [self.view addSubview:self.selectionList];
    
    self.selectionList.snapToCenter = YES;
    
    arrStringURL = [[NSArray alloc] initWithObjects:
                    @"http://vnexpress.net/rss/tin-moi-nhat.rss",
                    @"http://vnexpress.net/rss/thoi-su.rss",
                    @"http://vnexpress.net/rss/the-gioi.rss",
                    @"http://vnexpress.net/rss/kinh-doanh.rss",
                    @"http://vnexpress.net/rss/giai-tri.rss",
                    @"http://vnexpress.net/rss/the-thao.rss",
                    @"http://vnexpress.net/rss/phap-luat.rss",
                    @"http://vnexpress.net/rss/giao-duc.rss",
                    @"http://vnexpress.net/rss/du-lich.rss",
                    nil];
    
    //Load data at Tong Hop section
    [self loadData:arrStringURL[0]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(SideMenuNavVC *)self.navigationController
                                                                            action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:159.0f/255 green:34.0f/255 blue:78.0f/255 alpha:0.0];
}



#pragma mark - Progress view

-(void)showMBProgess{
    if (!ishowProGress) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        ishowProGress = YES;
        numberSecondCheckInternet = 0;
        timeInterNet = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                                       selector:@selector(runTimerInternet)
                                                       userInfo:nil
                                                        repeats:YES];
    }
}
-(void)hidenMBProgress{
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        ishowProGress = NO;
        timeInterNet = nil;
        numberSecondCheckInternet = 0;
    });
}

-(void)runTimerInternet{
    numberSecondCheckInternet ++;
    if (numberSecondCheckInternet >= 10 ) {
//        [self showAlter:NSLocalizedString(@"Weak connection",nil)];
//        [timeInterNet invalidate];
        timeInterNet = nil;
        numberSecondCheckInternet = 0;
    }
}


#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.titleList.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.titleList[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    [self loadData:arrStringURL[index]];
    [self showMBProgess];
    [self hidenMBProgress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Load data with URL

-(void)loadDataWithURL:(NSString *)stringURl{
    [ParseData getListRecord:stringURl OnComplete:^(NSArray *items) {
        dataTable = [[NSMutableArray alloc] initWithArray:items];
        [self.tableView reloadData];
    } fail:^{
        NSLog(@"Parse error");
    }];
    
}



#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataTable.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    TitleCell *cell = (TitleCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TitleCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Record *record = [dataTable objectAtIndex:indexPath.row];
    cell.titleLabel.text = record.title;
    cell.detailLabel.text = record.descriptionR;
    [cell.titleImageView setImageWithURL:[NSURL URLWithString:record.url_image] placeholderImage:[UIImage imageNamed:@"newsicon.png"]];
    [cell layoutSubviews];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Record *record = [dataTable objectAtIndex:indexPath.row];
    ContentScreenVC *contentView = [[ContentScreenVC alloc]initWithNibName:@"ContentScreenVC" bundle:nil];
    if (record.url_detail) {
        contentView.stringURL_Detail = record.url_detail;
        [self.navigationController pushViewController:contentView animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void)loadData:(NSString*)stringURL
{
    [self loadDataWithURL:stringURL];
}
@end
