//
//  DescriptionViewController.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/14/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Cell * tempCell = [[Cell alloc]init];
    _verticalVersion = [tempCell GetViewComplex: _movie];
    _horizontalVersion = [tempCell GetViewComplex2: _movie];
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        [_verticalVersion setHidden:YES];
        [_horizontalVersion setHidden:NO];
    }else{
        [_horizontalVersion setHidden:YES];
        [_verticalVersion setHidden:NO];
    }
    CGRect frame;
    if(![_horizontalVersion isHidden]){
        frame = _horizontalVersion.frame;
    }else{
        frame = _verticalVersion.frame;
    }
    frame.size.height = _myView.frame.size.height;
    frame.size.width = _myView.frame.size.width;
    if(![_horizontalVersion isHidden]){
        _horizontalVersion.frame = frame;
    }else{
        _verticalVersion.frame = frame;
    }
    [_myView addSubview:_horizontalVersion];
    [_myView addSubview:_verticalVersion];
    _saveLoad = [[SaveLoad alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        [_verticalVersion setHidden:YES];
        [_horizontalVersion setHidden:NO];
    }else{
        [_horizontalVersion setHidden:YES];
        [_verticalVersion setHidden:NO];
    }
    CGRect frame;
    if(![_horizontalVersion isHidden]){
        frame = _horizontalVersion.frame;
    }else{
        frame = _verticalVersion.frame;
    }
    frame.size.height = _myView.frame.size.height;
    frame.size.width = _myView.frame.size.width;
    if(![_horizontalVersion isHidden]){
        _horizontalVersion.frame = frame;
    }else{
        _verticalVersion.frame = frame;
    }
}

- (IBAction)deleteButtonWasPressed:(id)sender {
    
    [_saveLoad Load:^(NSMutableArray * contentLoaded){
        NSMutableArray * itens = contentLoaded;
        if(!itens){
            itens = [[NSMutableArray alloc] init];
        }
        
        for(int i=0;i<[itens count];i++){
            if( [[(Movie*)[itens objectAtIndex:i] imdbID] isEqualToString:_movie.imdbID]){
                [itens removeObjectAtIndex:i];
                break;
            }
        }
        [_saveLoad Save:itens];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
