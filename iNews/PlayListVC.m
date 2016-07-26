//
//  PlayListVC.m
//  iNews
//
//  Created by Nguyen Duy Khanh on 4/18/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import "PlayListVC.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "SideMenuNavVC.h"
#import "PlayBar.h"


@interface PlayListVC ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property NSMutableArray *object;

@end

@implementation PlayListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSong];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(SideMenuNavVC *)self.navigationController
                                                                            action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blueColor];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSong
{
    // 1 Download the webpage and put on a data
    NSURL *listUrl = [NSURL URLWithString:@"http://mp3.zing.vn/bang-xep-hang/bai-hat-Viet-Nam/IWZ9Z08I.html"];
    NSData *listURlData = [NSData dataWithContentsOfURL:listUrl];
    
    // 2 Create the parser with downloaded data
    TFHpple *listParser = [TFHpple hppleWithHTMLData:listURlData];
    
    // 3 Set up the Xpath query -> return an array of nodes (TFHPPLElement object)
    NSString *listXpathQueryString = @"//div[@class='e-item']";
    NSArray *playListNodes = [listParser searchWithXPathQuery:listXpathQueryString];
    
    // 4 Create an array to hold new tutorial objects
//    NSMutableArray *newSongs = [[NSMutableArray alloc] initWithCapacity:0];
//    for (TFHppleElement *element in playListNodes) {
//        // 5 Creat new tutorial object and add to array
//        Song *song = [[Song alloc] init];
//        [newSongs addObject:song];
//        
//        NSArray *a = [element searchWithXPathQuery:@"//a"];
//        NSLog(@"\n img:%@ \n href:%@ \n NameOfSong:%@ \n NameOfArtist:%@", [(TFHppleElement *)a[0] children][0][@"src"], a[0][@"href"], a[1][@"title"],[(TFHppleElement *)a[2] content]);
//        
//        // 6 Return the elements due to XpathQuery
//        song.artist = [(TFHppleElement *)a[2] content];
//        song.songTitle = a[1][@"title"];
//        song.imageUrl =[(TFHppleElement *)a[0] children][0][@"src"];
    
    }
    
    // 8 Add all the items to the object array
//    _object = newSongs;
//    [self.myTableView reloadData];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _object.count;
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [_object removeAllObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [[NSBundle mainBundle]loadNibNamed:@"MusicPlayerVC" owner:self options:nil];
    PlayBar *musicPlayer = [[PlayBar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 80, 320, 80)];
    musicPlayer.backgroundColor = [UIColor blackColor];
    [self.view addSubview:musicPlayer];
    
}

//- (NSString *)parseDeatilFromZingMp3:(NSString *)link{
////    link = @"http://mp3.zing.vn/bai-hat/Mua-Mua-Mua-By2/ZW6IWABU.html";
//    
//    // NSString *link = track.url_Detail;
//    
//    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:link]];
//    
//    // NSLog(@"data = %lu", (unsigned long)data.length);
//    NSString *stringtu = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
//    // parse dataXML
//    NSString *linkDataXML  = [stringtu substringFromIndex:[stringtu rangeOfString:@"data-xml=\""].location + 10] ;
//    linkDataXML = [linkDataXML substringToIndex:[linkDataXML rangeOfString:@"\""].location];
//    
//    NSData *dataXML = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:linkDataXML]];
//    NSString *stringXML = [[NSString alloc] initWithData:dataXML encoding:NSUTF8StringEncoding];
//    
//    // parse linkTrack
//    NSString *linkTrack =[self scanString:stringXML startTag:@"<source>" endTag:@"</source>"];
//    if (linkTrack) {
//        
//        linkTrack = [linkTrack substringFromIndex:[linkTrack rangeOfString:@"<![CDATA["].location + 9];
//        linkTrack = [linkTrack substringToIndex:[linkTrack rangeOfString:@"]]>"].location];
//        return linkTrack;
//    }
//    
//    return nil;
//}
//
//- (NSString *)scanString:(NSString *)string
//                startTag:(NSString *)startTag
//                  endTag:(NSString *)endTag
//{
//    
//    NSString* scanString = @"";
//    if (string.length > 0) {
//        NSScanner* scanner = [[NSScanner alloc] initWithString:string];
//        
//        @try {
//            [scanner scanUpToString:startTag intoString:nil];
//            scanner.scanLocation += [startTag length];
//            [scanner scanUpToString:endTag intoString:&scanString];
//        }
//        @catch (NSException *exception) {
//            return nil;
//        }
//        @finally {
//            return scanString;
//        }
//        
//    }
//    
//    return scanString;
//}
//
@end
