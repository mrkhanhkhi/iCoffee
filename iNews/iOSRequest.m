//
//  IOSRequest.m
//  testLazyLoading
//
//  Created by CanDang on 12/18/15.
//  Copyright © 2015 CanDang. All rights reserved.
//


#import "iOSRequest.h"
@implementation iOSRequest
+(void)requestPath:(NSString *)path onCompletion:(RequestCompletionHandler)complete
{
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:[NSURL URLWithString:path]
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    if (complete) complete(data, error);
                    
                }] resume];
}
@end
