//
//  ViewController.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/2/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <iCarouselDataSource, iCarouselDelegate, UIGestureRecognizerDelegate>
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
//    _CarouselView.clipsToBounds = YES;
    
//    The carousel type
    _CarouselView.type = iCarouselTypeCoverFlow2;
    _CarouselView.centerItemWhenSelected = true;
    
    _cell = [[Cell alloc] init];
    _connection = [[Connection alloc]init];
    _saveLoad = [[SaveLoad alloc] init];
    
//    Uncomment this line down here to clear the database
//    [_saveLoad ClearDataBase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void)addItens:(NSMutableArray*) i{
    for(Movie * tempM in i){
        [_itens addObject:tempM];
    }
    [self saveData];
    [self.CarouselView reloadData];
}

-(void)addMovie:(Movie*) m{
    [_itens addObject:m];
    [self saveData];
    [self.CarouselView reloadData];
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
    return [_cell GetViewSimplex:[_itens objectAtIndex:index]];
////    CGRect frame = view.frame;
////    frame.size.height = _CarouselView.frame.size.height*.5;
//////    frame.size.width = [_CarouselView itemWidth];
////    view.frame = frame;
//    return view;
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
    }else{
        _topCarouselConstraint.constant =0;
        _bottonCarouselConstraint.constant = 200;
    }
}
    
-(void)loadData{
    [_saveLoad Load:^(NSMutableArray * contentLoaded){
        if(contentLoaded){
            _itens = contentLoaded;
            [self.CarouselView reloadData];
        }
    }];
}

-(void)saveData{
    [_saveLoad Save:_itens];
}
@end
