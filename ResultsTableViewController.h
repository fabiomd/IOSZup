//
//  ResultsTableViewController.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/10/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SaveViewController.h"
#import "Cell.h"
#import "Connection.h"

@interface ResultsTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray * itens;
@property (strong, nonatomic) Cell * cell;

@end
