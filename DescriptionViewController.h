//
//  DescriptionViewController.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/14/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

//#import "ViewController.h"
#import "Movie.h"
#import "Cell.h"
#import "SaveLoad.h"

@interface DescriptionViewController : UIViewController

@property (strong,nonatomic) Movie * movie;

@property (strong,nonatomic) SaveLoad * saveLoad;

@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
