//
//  DetailVC.h
//  HW9CDTest3
//
//  Created by Uri Fuholichev on 7/20/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Storage.h"

/*
http://stackoverflow.com/questions/5210535/passing-data-between-view-controllers
*/

//////// для возможности передачи объектов между VC во втором VC реализован протокол
@class DetailVC;

@protocol DetailVCDelegate <NSObject>
- (void)addItemViewController:(DetailVC *)controller didFinishEnteringItem:(Storage *)item;
@end
////////

    
@interface DetailVC : UIViewController

//////// ...и создано специальное свойство
@property (nonatomic, weak) id <DetailVCDelegate> delegate;
////////
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) IBOutlet UITextField *detailTextField;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;

@property(strong, nonatomic)Storage *storage;

@end
