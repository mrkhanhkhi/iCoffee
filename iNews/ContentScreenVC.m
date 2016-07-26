//
//  ContentScreenVC.m
//  iNews
//
//  Created by Nguyen Duy Khanh on 3/31/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import "ContentScreenVC.h"

@interface ContentScreenVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ContentScreenVC


- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:self.stringURL_Detail];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
}


@end