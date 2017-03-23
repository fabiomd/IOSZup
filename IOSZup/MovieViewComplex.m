//
//  MovieViewComplex.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/10/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "MovieViewComplex.h"

@implementation MovieViewComplex

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

-(id)init{
    self = [super init];
    if(self){
        [self addSubview:self.View];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
}

    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) fillWithMovie:(Movie *) movie{
    if(![movie.title isEqualToString:@"N/A"]){
        _title.text = movie.title;
    }else{
        _title.text = @"";
    }
    if(![movie.year isEqualToString:@"N/A"]){
        NSString * temp = @"Release: ";
        temp = [temp stringByAppendingString:movie.year];
        _year.text = temp;
    }else{
        _year.text = @"";
    }
    if(![movie.type isEqualToString:@"N/A"]){
        _type.text = [movie.type uppercaseString];
    }else{
        _type.text = @"";
    }
    if(![movie.plot isEqualToString:@"N/A"]){
        _plot.text = movie.plot;
    }else{
        _plot.text = @"";
    }
    if(![movie.genre isEqualToString:@"N/A"]){
        NSString * temp = @"Genre: ";
        temp = [temp stringByAppendingString:movie.genre];
        _genre.text = temp;
    }else{
        _genre.text = @"";
    }
    if(![movie.language isEqualToString:@"N/A"]){
        NSString * temp = @"Language: ";
        temp = [temp stringByAppendingString:movie.language];
        _language.text = temp;
    }else{
        _language.text = @"";
    }
    if(![movie.runtime isEqualToString:@"N/A"]){
        NSString * temp = @"Runtime: ";
        temp = [temp stringByAppendingString:movie.runtime];
        _duration.text = temp;
    }else{
        _duration.text = @"";
    }
    if(![movie.actors isEqualToString:@"N/A"]){
        NSString * temp = @"Actors: ";
        temp = [temp stringByAppendingString:movie.actors];
        _actors.text = temp;
    }else{
        _actors.text = @"";
    }
    if(![movie.imdbRating isEqualToString:@"N/A"]){
        NSString * temp = @"Rating: ";
        temp = [temp stringByAppendingString:movie.imdbRating];
        _rating.text = temp;
    }else{
        _rating.text = @"";
    }
    
    _poster.image = movie.image;
    [_scrollView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [_scrollView.layer setBorderWidth:2.0];
}

@end
