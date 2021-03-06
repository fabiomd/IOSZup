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

//more movies available on server
static BOOL available;
//already made a request
static BOOL occupied;
//next page to be request
static int nextPage;

@implementation ResultsTableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    _connection = [[Connection alloc]init];
    available = YES;
    occupied = NO;
    nextPage = 0;
    _itens = [[NSMutableArray alloc] init];
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.label.text = @"Loading";
    [_connection requestByID:temp.imdbID: ^(Movie * movie){
        [hud hideAnimated:YES];
        selected = movie;
        [self performSegueWithIdentifier:@"DetailsViewController" sender:self];
    } error: ^(NSError* Error){
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self ConnectionError];
        });
//        [self ConnectionError];
    }];
    
}

//    create a cell 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor lightGrayColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    NSArray *viewsToRemove = [cell.contentView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    // Configure the cell...
    
    UIView * movieCell = [_cell GetView:[_itens objectAtIndex: indexPath.section]];
    
    CGRect frame;
    frame = movieCell.frame;
    frame.size.height = cell.contentView.frame.size.height;
    frame.size.width = cell.contentView.frame.size.width;
    movieCell.frame = frame;
    
    [cell.contentView addSubview:movieCell];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    
    CGFloat contentYoffset = scrollView.contentOffset.y;
    
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    
    if(_itens  && available && !occupied && distanceFromBottom < height){
        [self search:_searchWord];
    }
}

//    if serchBar was clicked, will clear the list and make another search
- (void)searchBarSearchButtonClicked:(UISearchBar *) searchBar
{
    _itens = [[NSMutableArray alloc] init];
    [_tableView reloadData];
    available = YES;
    nextPage = 0;
    [searchBar resignFirstResponder];
    // Do the search...
    _searchWord = searchBar.text;
    
    [self search:searchBar.text];
}

- (void)search:(NSString*)searchText{
    
    if(available){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.userInteractionEnabled = NO;
        hud.label.text = @"Buscando";
        nextPage++;
        occupied = YES;
        [_connection requestByName:searchText: nextPage itens: ^(NSMutableArray * movie){
            if([movie count] == 0 || !movie){
                available = NO;
                if(nextPage == 1){
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"Sem resultados!"preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                    {
                        UINavigationController * tempNav = [self navigationController];
                        [tempNav popToRootViewControllerAnimated:true];
                    }];
                    [alert addAction:okButton];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }else{
                [self addItens:movie];
            }
            [hud hideAnimated:YES];
            occupied = NO;
        } error: ^(NSError* Error){
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self ConnectionError];
            });
        }];
    }
}

-(void)ConnectionError{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"Não foi possivel se conectar ao servidor! \n Verifique sua conexão"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                               {
                                   UINavigationController * tempNav = [self navigationController];
                                   [tempNav popToRootViewControllerAnimated:true];
                               }];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)addItens:(NSMutableArray*) array{
    for(Movie * tempM in array){
        [_itens addObject:tempM];
    }
    [_tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailsViewController"]) {
        DetailsViewController *temp = (DetailsViewController *) segue.destinationViewController;
        temp.movie = selected;
    }
}

@end
