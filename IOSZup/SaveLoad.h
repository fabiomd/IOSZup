//
//  SaveLoad.h
//  IOSZup
//
//  Created by Fábio Moreira on 3/13/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface SaveLoad : NSObject

@property (strong,nonatomic) AppDelegate * app;
@property (strong,nonatomic) NSManagedObjectContext * context;
@property (strong,nonatomic) NSManagedObject * entity;

-(id) init;
-(void) Save:(NSMutableArray*) contentToSave;
-(void) Load:(void (^)(NSMutableArray *) )contentLoaded;
-(void) ClearDataBase;

@end
