//
//  Connection.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/6/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "Connection.h"

@implementation Connection

//   all this request are asynchronous

static NSString * const BaseURLString = @"http://www.omdbapi.com";

//    will request a movie to server based on the name passed, this will return a list of NSMutableArray

-(void)requestByName:(NSString *)name :(int)page itens: (void (^)(NSMutableArray *) )itens{
    
//    Creating manager for comunication with server
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    name = [self removeAccents:name];
//    This part will create the requested url, based on name
    NSString * tempURL = @"";
    tempURL = [tempURL stringByAppendingString:BaseURLString];
    tempURL = [tempURL stringByAppendingString:@"/?s="];
    NSArray * subStrings = [name componentsSeparatedByString:@" "];
    int i=0;
    for(i=0;i<[subStrings count] - 1;i++){
        tempURL = [tempURL stringByAppendingString:[subStrings objectAtIndex:i]];
        tempURL = [tempURL stringByAppendingString:@"+"];

    }
    tempURL = [tempURL stringByAppendingString:[subStrings objectAtIndex:i]];
    tempURL = [tempURL stringByAppendingString:@"&page="];
    tempURL = [tempURL stringByAppendingString:[NSString stringWithFormat:@"%d", page]];
    
    NSMutableArray * movies = [[NSMutableArray alloc]init];
    
    [manager GET:tempURL parameters:nil //o cara que tinha os json pra preencher
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
        NSLog(@"Error: %@", error);
    }];
}

//   will request a movie to server based on the id passed, will return a movie

-(void)requestByID:(NSString *)ID : (void (^)(Movie *) )iten{
    
//    Creating manager for comunication with server
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    ID = [self removeAccents:ID];
//    This part will create the requested url, based on name
    NSString * tempURL = @"";
    tempURL = [tempURL stringByAppendingString:BaseURLString];
    tempURL = [tempURL stringByAppendingString:@"/?i="];
    tempURL = [tempURL stringByAppendingString:ID];
    
    [manager GET:tempURL parameters:nil //o cara que tinha os json pra preencher
        progress:^(NSProgress * _Nonnull downloadProgress) {
            
        }success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSError *error = nil;
            Movie *movie = [MTLJSONAdapter modelOfClass:[Movie class] fromJSONDictionary:responseObject error:&error];
            [movie downloadImage];
            iten(movie);
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
}

-(NSString*)removeAccents:(NSString*) text{
    return [[NSString alloc] initWithData:[text dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding];
}

@end
