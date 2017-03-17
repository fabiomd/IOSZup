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
    _verticalVersion = [tempCell GetViewComplexVertical: _movie];
    _horizontalVersion = [tempCell GetViewComplexHorizontal: _movie];
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
    _saveLoad = [[SaveLoad alloc]init];
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
    }else{
        [_horizontalVersion setHidden:YES];
        [_verticalVersion setHidden:NO];
    }
}

- (IBAction)deleteButtonWasPressed:(id)sender {
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"" message:@"O FILME SERA REMOVIDO, \n DESEJA PROCESSEGUIR?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"SIM" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
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
                                    
                                    [self POPUP:@"Filme removido!"];
                                }];
    UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"CANCELAR" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                               {
                                   [self POPUP:@"Operacao abortada!"];
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:cancelButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)POPUP:(NSString*)text{
    UIAlertController * popup=[UIAlertController alertControllerWithTitle:@"" message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* OKButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                               }];
    [popup addAction:OKButton];
    [self presentViewController:popup animated:YES completion:nil];
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
