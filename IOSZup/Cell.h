//
//  Cell.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/2/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "MovieView.h"
#import "MovieViewComplex.h"
#import "MovieViewSimplex.h"

@interface Cell : UIView


-(UIView*)GetView:(Movie*) movie;
-(UIView*)GetViewSimplex:(Movie*) movie;
-(UIView*)GetViewComplexVertical:(Movie*) movie;
-(UIView*)GetViewComplexHorizontal:(Movie*) movie;
    
@end
