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

static NSString * const BaseURLString = @"https://www.youtube.com/results?search_query=";
//static NSString * const BaseURLString = @"GET https://www.googleapis.com/youtube/v3/videos/s=";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.playerView loadWithVideoId:@"http://www.imdb.com/title/tt1306980/"];
//    [self requestByName:_movieTitle itens:^(NSMutableArray * movie) {
//        [_playerView loadWithVideoId:_movieTitle];
//    }error:^(NSError * error){
//    }];
//    [self.playerView loadWithVideoId:@"M7lc1UVf-VE"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestByName:(NSString *)name itens: (void (^)(NSMutableArray *) )itens error: (void (^)(NSError*)) Error{
    
    //    Creating manager for comunication with server
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    This part will create the requested url, based on name
    NSString * tempURL = @"";
    tempURL = [tempURL stringByAppendingString:BaseURLString];
    NSArray * subStrings = [name componentsSeparatedByString:@" "];
    int i=0;
    for(i=0;i<[subStrings count] - 1;i++){
        tempURL = [tempURL stringByAppendingString:[subStrings objectAtIndex:i]];
        tempURL = [tempURL stringByAppendingString:@"+"];
        
    }
    tempURL = [tempURL stringByAppendingString:[subStrings objectAtIndex:i]];
    tempURL = [tempURL stringByAppendingString:@"+trailer"];
    NSMutableArray * movies = [[NSMutableArray alloc]init];
    
    [manager GET:tempURL parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
        }success:^(NSURLSessionDataTask *task, id responseObject) {
            
            //        Split the JSON response
            NSMutableArray *tempArray = [responseObject objectForKey:@"Search"];
            
            //        for each response create a movie and fill it
            for(NSDictionary * tempDic in tempArray){
                NSError *error = nil;
                Movie *tempMovie = [MTLJSONAdapter modelOfClass:[Movie class] fromJSONDictionary:tempDic error:&error];
                [tempMovie downloadImage];
                [movies addObject:tempMovie];
            }
            itens(movies);
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            Error(error);
        }];
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
