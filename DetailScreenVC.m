//
//  DetailScreenVC.m
//  iNews
//
//  Created by Nguyen Duy Khanh on 3/31/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import "DetailScreenVC.h"
#import "TitleCell.h"
#import "ContentScreenVC.h"
#import "ParseData.h"
#import "Record.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DetailScreenVC () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataTable;
}
@property (weak,nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    UINib *cellNib = [UINib nibWithNibName:@"TitleCell" bundle:nil];
    //    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"TitleCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadDataWithURL:self.stringURl];
}

-(void)loadDataWithURL:(NSString *)stringURl{
    [ParseData getListRecord:stringURl OnComplete:^(NSArray *items) {
        dataTable = [[NSMutableArray alloc] initWithArray:items];
        [self.tableView reloadData];
    } fail:^{
        NSLog(@"Parse error");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //    [cell.yyuf setImage:[UIImage imageNamed:@"newsicon"]];
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


@end
