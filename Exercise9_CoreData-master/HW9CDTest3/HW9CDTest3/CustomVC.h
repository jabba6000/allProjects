//
//  CustomVC.h
//  HW9CDTest3
//
//  Created by Uri Fuholichev on 7/20/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Storage.h"
#import "DetailVC.h"

//помимо прочего подключим еще и протокол DetailVCdelegate - для обмена данными между двумя VC
@interface CustomVC : UIViewController <UITableViewDataSource, UITableViewDelegate, DetailVCDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(strong, nonatomic) NSMutableArray *arrayForCoreData;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property(strong, nonatomic) Storage *storage;

@end
