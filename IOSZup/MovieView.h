//
//  MovieView.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/3/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieView : UIView

@property (strong, nonatomic) IBOutlet UIView *View;

@property (strong, nonatomic) IBOutlet UIImageView *poster;
@property (strong, nonatomic) IBOutlet UITextView *titleTextField;

-(void) fillWithMovie:(Movie *) movie;
@end
