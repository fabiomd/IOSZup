//
//  SearchVideo.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/27/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "SearchVideo.h"

@implementation SearchVideo
//https://www.googleapis.com/youtube/v3/search?part=snippet&q=\jurassic+park+III+Official+trailer&key=AIzaSyCHOu-aYXXxmMfUli-HYHGwxqmwdqCj6sU
//static NSString * const myAPIKEY = @"AIzaSyCHOu-aYXXxmMfUli-HYHGwxqmwdqCj6sU";
static NSString * const myAPIKEY = @"AIzaSyCHOu-aYXXxmMfUli-HYHGwxqmwdqCj6sU";
static NSString * const BaseURLString = @"https://www.googleapis.com/youtube/v3/search?part=snippet&q=\\";

-(void)requestByKeyword:(NSString *)keyWord :(int)maxResult results: (void (^)(NSDictionary *) )item error: (void (^)(NSError*)) Error{
    

    NSString *tempURL = @"";
    NSArray * subStrings = [keyWord componentsSeparatedByString:@" "];
    tempURL = [tempURL stringByAppendingString:BaseURLString];
    int i=0;
    for(i=0;i<[subStrings count] - 1;i++){
        tempURL = [tempURL stringByAppendingString:[subStrings objectAtIndex:i]];
        tempURL = [tempURL stringByAppendingString:@"+"];
        
    }
    tempURL = [tempURL stringByAppendingString:[subStrings objectAtIndex:i]];
//    tempURL = [tempURL stringByAppendingString:@"+Official+Trailer+#"];
    tempURL = [tempURL stringByAppendingString:@"&type=video&videoSyndicated=true&chart=mostPopular&movieCategoryId=44&maxResults="];
    tempURL = [tempURL stringByAppendingString:[NSString stringWithFormat:@"%d", maxResult]];
    tempURL = [tempURL stringByAppendingString:@"&order=relevance&order=viewCount&regionCode=GB&key="];
    tempURL = [tempURL stringByAppendingString:myAPIKEY];
    tempURL = [tempURL stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    NSLog(@"%@",tempURL);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:tempURL parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
        }success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            item(responseObject);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            Error(error);
        }];
}

-(NSString*)removeAccents:(NSString*) text{
    return [[NSString alloc] initWithData:[text dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding];
}


@end
