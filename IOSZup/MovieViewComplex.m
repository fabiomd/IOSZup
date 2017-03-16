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
    _title.text = movie.title;
    _year.text = movie.year;
    _type.text = movie.type;
    _plot.text = movie.plot;
    _language.text = movie.language;
    _poster.image = movie.image;
//    [_poster.layer setCornerRadius:5.0f];
//    [_poster.layer setBorderWidth:5.0f];
}

@end
