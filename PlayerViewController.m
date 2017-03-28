//
//  PlayerViewController.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/24/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

//static NSString * const myAPIKEY = @"AIzaSyCHOu-aYXXxmMfUli-HYHGwxqmwdqCj6sU";
//static NSString * const BaseURLString = @"https://www.googleapis.com/youtube/v3/search?part=snippet&q=\\";
//static NSString * const temp = @"http://gdata.youtube.com/feeds/api/videos?q=kung+fu+panda-trailer&start-index=1&max-results=1&v=2&alt=json&hd";
//static NSString * const BaseURLString = @"http://gdata.youtube.com/feeds/api/videos?q=";

- (void)viewDidLoad {
    [super viewDidLoad];
    [_playerView loadWithVideoId:_movieID];
    
//    NSString *tempURL = @"";
//    NSArray * subStrings = [_movieTitle componentsSeparatedByString:@" "];
//    tempURL = [tempURL stringByAppendingString:BaseURLString];
//    int i=0;
//    for(i=0;i<[subStrings count] - 1;i++){
//        tempURL = [tempURL stringByAppendingString:[subStrings objectAtIndex:i]];
//        tempURL = [tempURL stringByAppendingString:@"+"];
//
//    }
//    tempURL = [tempURL stringByAppendingString:[subStrings objectAtIndex:i]];
//    tempURL = [tempURL stringByAppendingString:@"+trailer"];
//    tempURL = [tempURL stringByAppendingString:@"&type=video&videoSyndicated=true&chart=mostPopular&maxResults=1&safeSearch=strict&order=relevance&order=viewCount&type=video&relevanceLanguage=en&regionCode=GB&key="];
//    tempURL = [tempURL stringByAppendingString:myAPIKEY];
//    tempURL = [tempURL stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
//   
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:tempURL parameters:nil
//        progress:^(NSProgress * _Nonnull downloadProgress) {
//        }success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSString * ID = [[[responseObject valueForKey:@"items"] valueForKey:@"id"] valueForKey:@"videoId"];
//            [_playerView loadWithVideoId:ID];
//        } failure:^(NSURLSessionTask *operation, NSError *error) {
//        }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
