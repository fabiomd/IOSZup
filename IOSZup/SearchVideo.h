//
//  SearchVideo.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/27/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SearchVideo : NSObject

-(void)requestByKeyword:(NSString *)keyWord :(int)maxResult results: (void (^)(NSDictionary *) )item error: (void (^)(NSError*)) Error;
@end
