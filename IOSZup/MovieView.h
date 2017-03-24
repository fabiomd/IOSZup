//
//  MovieView.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/3/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cosmos/Cosmos-Swift.h>
#import "Movie.h"

@interface MovieView : UIView

@property (strong,nonatomic) NSString * imdbID;
@property (strong, nonatomic) IBOutlet UIView *View;

@property (strong, nonatomic) IBOutlet UIImageView *poster;
@property (strong, nonatomic) IBOutlet UITextView *titleTextField;
@property (weak, nonatomic) IBOutlet CosmosView *starRating;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *starRatingWidthConstraint;

-(void) fillWithMovie:(Movie *) movie;
@end
