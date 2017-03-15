//
//  SaveLoad.m
//  IOSZup
//
//  Created by Fábio Moreira on 3/13/17.
//  Copyright © 2017 Fábio Moreira. All rights reserved.
//

#import "SaveLoad.h"

@implementation SaveLoad

-(id) init{
    self = [super init];
    if(self){
        _app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        _context = [[_app persistentContainer] viewContext];
        NSError *error = nil;
        NSArray * entities = [_context executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"MovieData"] error:&error];
        if([entities count] > 0){
            _entity = [entities objectAtIndex:0];
        }else{
            _entity = [NSEntityDescription insertNewObjectForEntityForName:@"MovieData" inManagedObjectContext:_context];
        }
    }
    return self;
}

//    Save the movie NSMutableArray, first need to transform it in NSData to be place in a binary data value

-(void) Save:(NSMutableArray*) contentToSave{
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:contentToSave];
    [_entity setValue:arrayData forKey:@"movieArray"];
    NSError *error = nil;
    if([_context hasChanges] && ![_context save:&error]){
    }
    [_app saveContext];
}


//    Load a NSMutableArray from a binary data value
-(void) Load:(void (^)(NSMutableArray *) )contentLoaded{
    NSMutableArray * tempArray = [NSKeyedUnarchiver unarchiveObjectWithData:[_entity valueForKey:@"movieArray"]];
    contentLoaded(tempArray);
}

//    remove all entities of movie from coreData
-(void) ClearDataBase{
    NSFetchRequest * allMovies = [[NSFetchRequest alloc] init];
    [allMovies setEntity:[NSEntityDescription entityForName:@"MovieData" inManagedObjectContext:_context]];
    [allMovies setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * movies = [_context executeFetchRequest:allMovies error:&error];

    for (NSManagedObject * movie in movies) {
        [_context deleteObject:movie];
    }
    NSError *saveError = nil;
    [_context save:&saveError];
}

@end
