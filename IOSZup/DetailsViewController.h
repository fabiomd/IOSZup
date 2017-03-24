//
//  DetailsViewController.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/22/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "Movie.h"
#import "Cell.h"
#import "SaveLoad.h"
#import "PlayerViewController.h"

@interface DetailsViewController : UIViewController

@property (strong,nonatomic) Movie * movie;

@property (strong,nonatomic) NSMutableArray * itens;
@property (strong,nonatomic) SaveLoad * saveLoad;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *displayView;

@property (strong,nonatomic) UIView * verticalVersion;
@property (strong,nonatomic) UIView * horizontalVersion;

@end
