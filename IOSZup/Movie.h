//
//  Movie.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/6/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Movie : MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSString * actors;
@property (strong,nonatomic) NSString * awards;
@property (strong,nonatomic) NSString * country;
@property (strong,nonatomic) NSString * directory;
@property (strong,nonatomic) NSString * genre;
@property (strong,nonatomic) NSString * language;
@property (strong,nonatomic) NSString * metascore;
@property (strong,nonatomic) NSString * plot;
@property (strong,nonatomic) NSString * poster;
@property (strong,nonatomic) NSString * rated;
@property (strong,nonatomic) NSString * released;
@property (strong,nonatomic) NSString * runtime;
@property (strong,nonatomic) NSString * title;
@property (strong,nonatomic) NSString * type;
@property (strong,nonatomic) NSString * writer;
@property (strong,nonatomic) NSString * year;
@property (strong,nonatomic) NSString * imdbID;
@property (strong,nonatomic) NSString * imdbRating;
@property (strong,nonatomic) NSString * imdbVotes;
@property (strong,nonatomic) UIImage  * image;

+ (NSDictionary *)JSONKeyPathsByPropertyKey ;

-(id)initWithDictionary:(NSDictionary *)dictionary error:(NSError **)error;
-(void)downloadImage;
@end
