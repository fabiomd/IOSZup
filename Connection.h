//
//  Connection.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/6/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "Movie.h"
#import "ViewController.h"

@interface Connection : NSObject

-(void) requestByName:(NSString*) name :(int)page itens: (void (^)(NSMutableArray *) )itens error: (void (^)(NSError*)) Error;
-(void)requestByID:(NSString *)ID : (void (^)(Movie *) )iten error: (void (^)(NSError*)) Error;

@end
