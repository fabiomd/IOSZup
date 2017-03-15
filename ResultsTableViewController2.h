//
//  ResultsTableViewController2.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/14/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "ViewController.h"

@interface ResultsTableViewController2 : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString * searchWord;
@property (strong, nonatomic) NSMutableArray * itens;
@property (strong, nonatomic) Cell * cell;

@end
