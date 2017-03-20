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
        _year.text = movie.year;
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
    if(![movie.language isEqualToString:@"N/A"]){
        _language.text = movie.language;
    }else{
        _language.text = @"";
    }
    
    _poster.image = movie.image;
    [_poster.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [_poster.layer setBorderWidth:2.0];
}

@end
