//
//  ResultsTableViewController2.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/14/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "ResultsTableViewController2.h"

@interface ResultsTableViewController2 () <UITableViewDelegate , UITableViewDataSource>
@property (strong, nonatomic) Connection * connection;
@end

static Movie* selected;

@implementation ResultsTableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    _connection = [[Connection alloc]init];
    
//    set table delegate and datasource
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _cell = [[Cell alloc] init];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self search:_searchWord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//    number of cells in table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_itens count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//    define the cell height 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//    if a cell was selected, will get a more detay version of the selected movie, and will call a view to show it
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Movie * temp = [_itens objectAtIndex:indexPath.section];
    [_connection requestByID:temp.imdbID: ^(Movie * movie){
        selected = movie;
        [self performSegueWithIdentifier:@"SaveViewController" sender:self];
    }];
    
}

//    create a cell 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    UIView * movieCell = [_cell GetView:[_itens objectAtIndex: indexPath.section]];
    [cell.contentView addSubview:movieCell];
    
    return cell;
}

//    if serchBar was clicked, will clear the list and make another search
- (void)searchBarSearchButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
    // Do the search...
    
    [self search:searchBar.text];
}

- (void)search:(NSString*)searchText{
    _itens = nil;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading";
    
    [_connection requestByName:searchText : ^(NSMutableArray * movie){
        _itens = movie;
        [hud hideAnimated:YES];
        [_tableView reloadData];
    }];
}
    

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"SaveViewController"]) {
        SaveViewController *temp = (SaveViewController *) segue.destinationViewController;
        temp.movie = selected;
    }
}

@end
