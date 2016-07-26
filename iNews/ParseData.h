//
//  ParseData.h
//  iNews
//
//  Created by Nguyen Duy Khanh on 4/2/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseData : NSObject
+ (void) getListRecord:(NSString*) linkURl   OnComplete:(void(^)(NSArray *items))completedMethod fail:(void(^)())failMethod;
@end
