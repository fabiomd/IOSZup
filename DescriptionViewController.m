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
    [_myView addSubview:[tempCell GetViewComplex: _movie]];
    
    _saveLoad = [[SaveLoad alloc]init];
    //[self.view addSubview:[tempCell GetViewComplex: _movie]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
