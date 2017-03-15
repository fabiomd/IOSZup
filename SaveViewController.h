//
//  SaveViewController.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/10/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "SaveLoad.h"
//#import "ViewController.h"
#import "Movie.h"
#import "Cell.h"

@interface SaveViewController : UIViewController

@property (strong,nonatomic) Movie * movie;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong,nonatomic) SaveLoad * saveLoad;
@property (weak, nonatomic) IBOutlet UIView *displayView;

@end
