//
//  ParseData.m
//  iNews
//
//  Created by Nguyen Duy Khanh on 4/2/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import "ParseData.h"
#import "XMLReader.h"
#import "Record.h"
#import "iOSRequest.h"

@implementation ParseData

+(void)getListRecord:(NSString *)linkURl OnComplete:(void (^)(NSArray * arrItems))completedMethod fail:(void (^)())failMethod{
        NSError * error;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:linkURl] options:NSDataReadingUncached  error:&error];
    if (!data) {
        failMethod();
    }
    //--- Tạo một NSdictinary chứa file XML
    NSDictionary *dict = [XMLReader dictionaryForXMLData:data
                                                 options:XMLReaderOptionsProcessNamespaces
                                                   error:&error];
    
    // Truy ván theo từng keyword trong từng mảng
    NSDictionary *rss = [dict objectForKey:@"rss"];
    NSDictionary *channel = [rss objectForKey:@"channel"];
    NSMutableArray *items = [channel objectForKey:@"item"];
    
    //Tạo array chứa đối tượng vừa được parse về
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *a in items) {
        Record *record = [[Record alloc] init];
        record.title = [[a objectForKey:@"title"] objectForKey:@"text"];
         NSString *stringDescription = [[a objectForKey:@"description"] objectForKey:@"text"];
         record.url_detail = [[a objectForKey:@"link"] objectForKey:@"text"];
        @try {
            NSString * url_Image = [stringDescription substringFromIndex:[ stringDescription rangeOfString:@"src=\""].location + 5];
            record.url_image =[url_Image substringToIndex:[url_Image rangeOfString:@"\""].location];
            record.descriptionR = [stringDescription substringFromIndex:[stringDescription rangeOfString:@"br>"].location + 3];
        }
        @catch (NSException *exception) {}
        @finally {}
        [arr addObject:record];
    }
    
    completedMethod(arr);
}

@end
