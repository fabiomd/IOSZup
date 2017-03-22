//
//  MovieViewComplex.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/10/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieViewComplex : UIView

@property (strong, nonatomic) IBOutlet UIView *View;

@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UITextView *title;
@property (weak, nonatomic) IBOutlet UITextView *language;
@property (weak, nonatomic) IBOutlet UITextView *plot;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UITextView *actors;
@property (weak, nonatomic) IBOutlet UILabel *genre;
  

-(void) fillWithMovie:(Movie *) movie;
    

@end
