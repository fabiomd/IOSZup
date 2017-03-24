//
//  PlayerViewController.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/24/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "ViewController.h"
#import "YTPlayerView.h"

@interface PlayerViewController : UIViewController

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property(nonatomic,strong) NSString * movieTitle;

@end
