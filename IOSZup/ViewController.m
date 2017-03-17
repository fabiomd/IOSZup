//
//  ViewController.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/2/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <iCarouselDataSource, iCarouselDelegate,UITableViewDelegate , UITableViewDataSource, UIGestureRecognizerDelegate>
@property (strong, nonatomic) Connection * connection;
@end

@implementation ViewController

static NSInteger selectedIndex = 0;

-(void)awakeFromNib{
    [super awakeFromNib];
    _itens = [[NSMutableArray alloc] init];
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    Do any additional setup after loading the view, typically from a nib.
    
//    Set the caousel datasource and delegate
    _CarouselView.dataSource = self;
    _CarouselView.delegate = self;
    
//    The carousel type
    _CarouselView.type = iCarouselTypeCoverFlow2;
    _CarouselView.centerItemWhenSelected = true;
    
    _cell = [[Cell alloc] init];
    _connection = [[Connection alloc]init];
    _saveLoad = [[SaveLoad alloc] init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        _bottonCarouselConstraint.constant = 0;
        _topCarouselConstraint.constant = 0;
        _tableHeightConstraint.constant = 0;
        [_tableView setHidden:YES];
    }else{
        _topCarouselConstraint.constant =0;
        _bottonCarouselConstraint.constant = 200;
        _tableHeightConstraint.constant = 184;
        [_tableView setHidden:NO];
    }
    
//    Uncomment this line down here to clear the database
//    [_saveLoad ClearDataBase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    return 60;
}

//    if a cell was selected, will get a more detay version of the selected movie, and will call a view to show it
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //comando para quando clica no carousel
    [self CallDescription:indexPath.item];
    
}

//    create a cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    UIView * temp = [_cell GetView:[_itens objectAtIndex: indexPath.section]];
    
    MovieView * movieCell = (MovieView*)temp;
    
    //if theres not image, set a default one
    if(!movieCell.poster.image){
        movieCell.poster.image = [UIImage imageNamed:@"not_found.jpg"];
    }
    
    CGRect frame;
    frame = movieCell.frame;
    frame.size.height = cell.contentView.frame.size.height;
    frame.size.width = cell.contentView.frame.size.width;
    movieCell.frame = frame;
    
    [cell.contentView addSubview:movieCell];
    
    return cell;
}


-(void)addItens:(NSMutableArray*) i{
    for(Movie * tempM in i){
        [_itens addObject:tempM];
    }
    [self saveData];
    [_CarouselView reloadData];
    [_tableView reloadData];
}

-(void)addMovie:(Movie*) m{
    [_itens addObject:m];
    [self saveData];
    [_CarouselView reloadData];
    [_tableView reloadData];
}

    
-(CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 200;
}
    
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return [_itens count];
    //return the number of elements on the carousel
}

-(void)viewDidAppear:(BOOL)animated{
//    everytime the view appear it load the data and center the carousel
    [super viewDidAppear:animated];
    [self loadData];
    [_CarouselView scrollToItemAtIndex:[_itens count]/2 animated: YES];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
//    allocate a new Cell
    UIView * temp = [_cell GetViewSimplex:[_itens objectAtIndex:index]];
    MovieViewSimplex * tempView = (MovieViewSimplex*)temp;
    
    //if theres not image, set a default one
    if(!tempView.poster.image){
        tempView.poster.image = [UIImage imageNamed:@"not_found.jpg"];
    }
    return tempView;
}


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    //comando para quando clica no carousel
    [self CallDescription:index];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
    // Do the search...
    [self CallSearch];
}

-(void)CallSearch{
//    [self performSegueWithIdentifier:@"ResultsTableViewController" sender:self];
    [self performSegueWithIdentifier:@"ResultsTableViewController2" sender:self];
}

//    call the ViewController to show the movie with more detays
-(void)CallDescription:(NSInteger)index{
    selectedIndex = index;
    [self performSegueWithIdentifier:@"DescriptionViewController" sender:self];
}

//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ResultsTableViewController2"]) {
        ResultsTableViewController2 *temp = (ResultsTableViewController2 *) segue.destinationViewController;
        temp.itens = _searchResults;
        temp.searchWord = _searchBar.text;
        _searchBar.text = @"";
    }
    
    if ([segue.identifier isEqualToString:@"DescriptionViewController"]) {
        DescriptionViewController *temp = (DescriptionViewController *) segue.destinationViewController;
        temp.movie = [_itens objectAtIndex:selectedIndex];
    }
}

-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        _bottonCarouselConstraint.constant = 0;
        _topCarouselConstraint.constant = 0;
        _tableHeightConstraint.constant = 0;
        [_tableView setHidden:YES];
    }else{
        _topCarouselConstraint.constant =0;
        _bottonCarouselConstraint.constant = 200;
        _tableHeightConstraint.constant = 184;
        [_tableView setHidden:NO];
    }
}
    
-(void)loadData{
    [_saveLoad Load:^(NSMutableArray * contentLoaded){
        if(contentLoaded){
            _itens = contentLoaded;
            [_CarouselView reloadData];
            [_tableView reloadData];
        }
    }];
}

-(void)saveData{
    [_saveLoad Save:_itens];
}
@end
