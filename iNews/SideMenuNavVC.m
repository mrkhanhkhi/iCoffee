//
//  SideMenuNavVC.m
//  iNews
//
//  Created by Nguyen Duy Khanh on 4/7/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//


#import "SideMenuNavVC.h"
#import "SideMenuVC.h"
#import "UIViewController+REFrostedViewController.h"

@interface SideMenuNavVC ()

@property (strong, readwrite, nonatomic) SideMenuNavVC *menuViewController;

@end

@implementation SideMenuNavVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}

@end
