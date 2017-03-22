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
    
//    Set carousel datasource and delegate
    _CarouselView.dataSource = self;
    _CarouselView.delegate = self;    
//    The carousel type
    _CarouselView.type = iCarouselTypeCoverFlow2;
    _CarouselView.centerItemWhenSelected = true;

//    iniciate global vars
    _cell = [[Cell alloc] init];
    _connection = [[Connection alloc]init];
    _saveLoad = [[SaveLoad alloc] init];
    
//    Set table datasource and delegate
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
//    when tap a view, close the keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
    
//    views resize if horizontal or vertical
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        _bottonCarouselConstraint.constant = 0;
        _topCarouselConstraint.constant = 0;
        _tableHeightConstraint.constant = 0;
        [_tableView setHidden:YES];
    }else{
        _topCarouselConstraint.constant =0;
        _bottonCarouselConstraint.constant = 200;
        _tableHeightConstraint.constant = 270;
        [_tableView setHidden:NO];
    }
    
//    Uncomment this line down here to clear the database
//    [_saveLoad ClearDataBase];
}

//  everytime the view appears, this function is called

-(void)viewDidAppear:(BOOL)animated{
    
//  closes the search keyboard
    [_searchBar resignFirstResponder];
//    everytime the view appear it load the data and center the carousel
    [super viewDidAppear:animated];
    [self loadData];
    [_CarouselView scrollToItemAtIndex:[_itens count]/2 animated: YES];
}


//  close the searchbar keyboard

-(void)dismissKeyboard{
    [_searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//  TABLE FUNCTIONS

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
    [_CarouselView scrollToItemAtIndex:indexPath.section animated: YES];
//    [self CallDescription:indexPath.section];   
}

//    create a cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *viewsToRemove = [cell.contentView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
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


// END TABLE FUNCTIONS

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

//  CAROUSEL FUNCTIONS

    
-(CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 200;
}
    
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return [_itens count];
    //return the number of elements on the carousel
}

-(void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:[_CarouselView currentItemIndex]];
    [_tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
//    allocate a new Cell
    UIView * temp = [_cell GetViewSimplex:[_itens objectAtIndex:index]];
    MovieViewSimplex * tempView = (MovieViewSimplex*)temp;
    
    //if theres not image, set a default one
    if(!tempView.poster.image){
//        [tempView.poster setHidden:YES];
        [tempView.title setHidden:NO];
        tempView.poster.image = [UIImage imageNamed:@"not_found.jpg"];
    }
    return tempView;
}


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    //comando para quando clica no carousel
   
    selectedIndex = index;
    [self performSegueWithIdentifier:@"DetailsViewController" sender:self];
}


//  END CAROUSEL FUNCTIONS


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

//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ResultsTableViewController2"]) {
        ResultsTableViewController2 *temp = (ResultsTableViewController2 *) segue.destinationViewController;
        temp.itens = _searchResults;
        temp.searchWord = _searchBar.text;
        _searchBar.text = @"";
    }
    
    if ([segue.identifier isEqualToString:@"DetailsViewController"]) {
        DetailsViewController *temp = (DetailsViewController *) segue.destinationViewController;
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
        _tableHeightConstraint.constant = 270;
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
