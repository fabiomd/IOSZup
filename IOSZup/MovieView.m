//
//  MovieView.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/3/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "MovieView.h"

@implementation MovieView

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


-(void) fillWithMovie:(Movie *) movie{
    _titleTextField.text = movie.title;
    _poster.image = movie.image;
}
@end
