//
//  ViewController.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/2/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "Cell.h"
#import "Movie.h"
#import "Connection.h"
#import "SaveViewController.h"
#import "ResultsTableViewController2.h"
#import "DescriptionViewController.h"
#import "SaveLoad.h"

@interface ViewController :UIViewController

@property (strong, nonatomic) NSMutableArray * itens;
@property (strong, nonatomic) NSMutableArray * searchResults;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet iCarousel *CarouselView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) Cell * cell;

@property (strong,nonatomic) SaveLoad * saveLoad;
    
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCarouselConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonCarouselConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
    
-(void)addItens:(NSMutableArray*) i;

-(void)addMovie:(Movie*)m;

@end

