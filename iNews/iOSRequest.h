//
//  IOSRequest.h
//  testLazyLoading
//
//  Created by CanDang on 12/18/15.
//  Copyright © 2015 CanDang. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef void(^RequestCompletionHandler)(NSData*,NSError*);

@interface iOSRequest : NSObject

+(void)requestPath:(NSString *)path
      onCompletion:(RequestCompletionHandler)complete;
@end
