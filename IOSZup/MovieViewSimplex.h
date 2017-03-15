//
//  MovieViewSimplex.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/15/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieViewSimplex : UIView

@property (strong, nonatomic) IBOutlet UIView *View;


@property (weak, nonatomic) IBOutlet UITextView *title;
@property (weak, nonatomic) IBOutlet UIImageView *poster;

-(void) fillWithMovie:(Movie *) movie;
@end
