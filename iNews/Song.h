//
//  Song.h
//  ZingMp3
//
//  Created by Nguyen Duy Khanh on 4/11/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (nonatomic, copy) NSString *songTitle;
@property (nonatomic, copy) NSString *songUrl;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *artist;

@property NSMutableArray *object;

@end
