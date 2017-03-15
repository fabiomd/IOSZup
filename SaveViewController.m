//
//  SaveViewController.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/10/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "SaveViewController.h"

@interface SaveViewController ()

@end

@implementation SaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Cell * tempCell = [[Cell alloc]init];
    [_displayView addSubview:[tempCell GetViewComplex: _movie]];
    
    _saveLoad = [[SaveLoad alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//    if save button was pressed, will load the data and add the movie, then will save it back to coreData entity
- (IBAction)saveButtonWasPressed:(id)sender {
    
    [_saveLoad Load:^(NSMutableArray * contentLoaded){
        NSMutableArray * itens = contentLoaded;
        if(!itens){
            itens = [[NSMutableArray alloc] init];
        }
        
        int i=0;
        for(i=0;i<[itens count];i++){
            if( [[(Movie*)[itens objectAtIndex:i] imdbID] isEqualToString:_movie.imdbID]){
                [itens removeObjectAtIndex:i];
                break;
            }
        }
        if(i==[itens count]){
            [_saveLoad Save:itens];
        }
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
