//
//  Cell.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/2/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "Cell.h"

@implementation Cell

//    this functions get a view and fill it, each one can be filled with a movie

-(UIView*)GetView:(Movie*) movie{
    MovieView * Movie = [[[NSBundle mainBundle] loadNibNamed:@"MovieView" owner:self options:nil]objectAtIndex:0];
    [Movie fillWithMovie:movie];
   return Movie;
}

-(UIView*)GetViewSimplex:(Movie*) movie{
    MovieViewSimplex * Movie = [[[NSBundle mainBundle] loadNibNamed:@"MovieViewSimplex" owner:self options:nil]objectAtIndex:0];
    [Movie fillWithMovie:movie];
    return Movie;
}

-(UIView*)GetViewComplexVertical:(Movie*) movie{
    MovieViewComplex * Movie = [[[NSBundle mainBundle] loadNibNamed:@"MovieViewComplex" owner:self options:nil]objectAtIndex:0];
    [Movie fillWithMovie:movie];
    return Movie;
}
    
-(UIView*)GetViewComplexHorizontal:(Movie*) movie{
    MovieViewComplex * Movie = [[[NSBundle mainBundle] loadNibNamed:@"MovieViewComplex2" owner:self options:nil]objectAtIndex:0];
    [Movie fillWithMovie:movie];
    return Movie;
}

@end
