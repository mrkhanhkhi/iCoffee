//
//  SongCell.h
//  iNews
//
//  Created by Nguyen Duy Khanh on 4/11/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *songTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *songImage;

@end
