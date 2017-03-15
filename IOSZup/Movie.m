//
//  Movie.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/6/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"actors" : @"Actors",
             @"awards" : @"Awards",
             @"country" : @"Country",
             @"directory" : @"Directory",
             @"genre" : @"Genre",
             @"language" : @"Language",
             @"metascore" : @"Metascore",
             @"plot" : @"Plot",
             @"poster" : @"Poster",
             @"rated" : @"Rated",
             @"released" : @"Released",
             @"runtime" : @"Runtime",
             @"title" : @"Title",
             @"type" : @"Type",
             @"writer" : @"Writer",
             @"year" : @"Year",
             @"imdbID" : @"imdbID",
             @"imdbRating" : @"imdbRating",
             @"imdbVotes" : @"imdbVotes",
             };
}

-(id)initWithDictionary:(NSDictionary *)dictionary error:(NSError **)error {
    self = [super initWithDictionary:dictionary error:error];
    if(self){
    }
    return self;
}

-(void)downloadImage{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_poster]];
    _image = [UIImage imageWithData:imageData];
    if(!_image){
        _image = [UIImage imageNamed:@"not_found.jpg"];
    }
}

@end
