//
//  TitleCell.h
//  iNews
//
//  Created by Nguyen Duy Khanh on 3/31/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
