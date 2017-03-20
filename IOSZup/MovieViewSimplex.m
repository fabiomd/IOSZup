//
//  MovieViewSimplex.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/15/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "MovieViewSimplex.h"

@implementation MovieViewSimplex

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
    _poster.image = movie.image;
}

@end
