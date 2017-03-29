//
//  DetailsViewController.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/22/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController () <UIScrollViewDelegate>

@end
static BOOL available = YES;
static NSString* movieYTId=@"";
@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    available = YES;
    _saveLoad = [[SaveLoad alloc]init];
    
    Cell * tempCell = [[Cell alloc]init];
    if(!_movie.image){
        _movie.image = [UIImage imageNamed:@"not_found.jpg"];
    }
    _verticalVersion = [tempCell GetViewComplexVertical: _movie];
    _horizontalVersion = [tempCell GetViewComplexHorizontal: _movie];
    
    [_saveLoad Load:^(NSMutableArray * contentLoaded){
        _itens = contentLoaded;
        if(!_itens){
            _itens = [[NSMutableArray alloc] init];
        }
        if([self checkContains: _movie]){
            [((MovieViewComplex*)_horizontalVersion).starRating setUserInteractionEnabled:YES];
            [((MovieViewComplex*)_verticalVersion).starRating setUserInteractionEnabled:YES];
            [_button setBackgroundImage:[UIImage imageNamed:@"delete-icon.png"] forState:UIControlStateNormal];
        }else{
            [((MovieViewComplex*)_horizontalVersion).starRating setUserInteractionEnabled:NO];
            [((MovieViewComplex*)_verticalVersion).starRating setUserInteractionEnabled:NO];
            [_button setBackgroundImage:[UIImage imageNamed:@"save-icon.png"] forState:UIControlStateNormal];
        }
    }];
    
    ((MovieViewComplex*)(_verticalVersion)).scrollView.minimumZoomScale=1.0;
    ((MovieViewComplex*)(_verticalVersion)).scrollView.maximumZoomScale=6.0;
    [((MovieViewComplex*)(_verticalVersion)).scrollView setDelegate:self];
    
    ((MovieViewComplex*)(_horizontalVersion)).scrollView.minimumZoomScale=1.0;
    ((MovieViewComplex*)(_horizontalVersion)).scrollView.maximumZoomScale=6.0;
    [((MovieViewComplex*)(_horizontalVersion)).scrollView setDelegate:self];
    
    [((MovieViewComplex*)(_horizontalVersion)).TrailerButton addTarget:self action:@selector(playMovie:) forControlEvents:UIControlEventTouchDown];
    [((MovieViewComplex*)(_verticalVersion)).TrailerButton addTarget:self action:@selector(playMovie:) forControlEvents:UIControlEventTouchDown];
    
    [_horizontalVersion.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [_horizontalVersion.layer setBorderWidth:2.0];
    
    [_verticalVersion.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [_verticalVersion.layer setBorderWidth:2.0];
    
    [_displayView addSubview:_horizontalVersion];
    [_displayView addSubview:_verticalVersion];
    _verticalVersion.frame = [self getFrameSize:_verticalVersion];
    _horizontalVersion.frame = [self getFrameSize:_horizontalVersion];
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        [_verticalVersion setHidden:YES];
        [_horizontalVersion setHidden:NO];
    }else{
        [_horizontalVersion setHidden:YES];
        [_verticalVersion setHidden:NO];
    }
}

-(void)playMovie:(UIButton *)sender{
    if(available){
        available = NO;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.userInteractionEnabled = NO;
        hud.label.text = @"Conectando";
        SearchVideo * searchVideo = [[SearchVideo alloc] init];
        NSString * tempKey = @"";
        tempKey = [tempKey stringByAppendingString:_movie.title];
        tempKey = [tempKey stringByAppendingString:@" "];
        tempKey = [tempKey stringByAppendingString:_movie.year];
        
        [searchVideo requestByKeyword:tempKey :1 results:^(NSDictionary* results){
            movieYTId = [[[results valueForKey:@"items"] valueForKey:@"id"] valueForKey:@"videoId"];
            [hud hideAnimated:YES];
            available = YES;
            [self performSegueWithIdentifier:@"PlayerViewController" sender:self];
        } error:^(NSError* error){
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self ConnectionError];
            });
        }];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        return ((MovieViewComplex*)(_horizontalVersion)).poster;
    }else{
        return ((MovieViewComplex*)(_verticalVersion)).poster;
    }
}

-(void)setButtonBackgroundImage{
    if([self checkContains: _movie]){
        [_button setBackgroundImage:[UIImage imageNamed:@"delete-icon.png"] forState:UIControlStateNormal];
    }else{
        [_button setBackgroundImage:[UIImage imageNamed:@"save-icon.png"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGRect) getFrameSize:(UIView*) view{
    CGRect frame;
    frame = view.frame;
    frame.size.height = _displayView.frame.size.height;
    frame.size.width = _displayView.frame.size.width;
    return frame;
}

-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        [_verticalVersion setHidden:YES];
        [_horizontalVersion setHidden:NO];
        ((MovieViewComplex*)_horizontalVersion).starRating.rating = ((MovieViewComplex*)_verticalVersion).starRating.rating;
    }else{
        [_horizontalVersion setHidden:YES];
        [_verticalVersion setHidden:NO];
        ((MovieViewComplex*)_verticalVersion).starRating.rating = ((MovieViewComplex*)_horizontalVersion).starRating.rating;
    }
}

-(BOOL) checkContains:(Movie*) movie{
    for(Movie * temp in _itens){
        if([temp.imdbID isEqualToString: movie.imdbID]){
            return YES;
        }
    }
    return NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self updateRating];
    [super viewWillDisappear:animated];
}

-(void)updateRating{
    for(int i=0;i<[_itens count];i++){
        if( [[(Movie*)[_itens objectAtIndex:i] imdbID] isEqualToString:_movie.imdbID]){
            NSNumber *myRating;
            if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
                myRating = [NSNumber numberWithDouble:((MovieViewComplex*)_horizontalVersion).starRating.rating * 2];
            }else{
                myRating = [NSNumber numberWithDouble:((MovieViewComplex*)_verticalVersion).starRating.rating * 2];
            }
            if(![_movie.imdbRating isEqualToString:[myRating stringValue]]){
                ((Movie*)[_itens objectAtIndex:i]).imdbRating = [myRating stringValue];
                [_saveLoad Save:_itens];
            }
            break;
        }
    }
}

- (IBAction)ButtonWasPressed:(id)sender {
    
//    if the movie already exist in data base delete button shows up, otherwise save one
    if([self checkContains: _movie]){
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"" message:@"O FILME SERA REMOVIDO, \n DESEJA PROCESSEGUIR?"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"SIM" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            for(int i=0;i<[_itens count];i++){
                if( [[(Movie*)[_itens objectAtIndex:i] imdbID] isEqualToString:_movie.imdbID]){
                    [_itens removeObjectAtIndex:i];
                    break;
                }
            }
            [_saveLoad Save:_itens];
            
            UIAlertAction* OKButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                UINavigationController * tempNav = [self navigationController];
                [tempNav popViewControllerAnimated:true];
            }];
            
            [self POPUP:@"Filme removido!" button:OKButton];
        }];
        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"CANCELAR" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        }];
        [alert addAction:yesButton];
        [alert addAction:cancelButton];
        [alert setPreferredAction:cancelButton];
        [self presentViewController:alert animated:YES completion:nil];
    }else
    {
        UIAlertController * alert;
        alert=[UIAlertController alertControllerWithTitle:@"" message:@"Filme salvo!"preferredStyle:UIAlertControllerStyleAlert];
        int i=0;
        for(i=0;i<[_itens count];i++){
            if( [[(Movie*)[_itens objectAtIndex:i] title] compare:_movie.title] > 0){
                [_itens insertObject:_movie atIndex:i];
                break;
            }
        }
        if(i==[_itens count]){
            [_itens addObject:_movie];
        }
        [_saveLoad Save:_itens];
        UIAlertAction* OKButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       UINavigationController * tempNav = [self navigationController];
                                       [tempNav popViewControllerAnimated:true];
                                   }];
        [alert addAction:OKButton];
        [self presentViewController:alert animated:YES completion:nil];
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

-(void)POPUP:(NSString*)text button:(UIAlertAction*) button{
    UIAlertController * popup=[UIAlertController alertControllerWithTitle:@"" message:text preferredStyle:UIAlertControllerStyleAlert];
    [popup addAction:button];
    [self presentViewController:popup animated:YES completion:nil];
}

//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PlayerViewController"]) {
        PlayerViewController *temp = (PlayerViewController *) segue.destinationViewController;
        temp.movieID = movieYTId;
    }
}


@end
