//
//  DetailVC.m
//  HW9CDTest3
//
//  Created by Uri Fuholichev on 7/20/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "DetailVC.h"
#import "AppDelegate.h"

@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
    
    self.detailTextField.text = self.storage.title;
    self.detailTextView.text = self.storage.text;
}

-(void)viewDidAppear{
    
    self.detailTextField.text = self.storage.title;
    self.detailTextView.text = self.storage.text;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.storage.title = self.detailTextField.text;
    self.storage.text = self.detailTextView.text;
    
    //следующий метод осуществляет передачу объекта назад
    [self.delegate addItemViewController:self didFinishEnteringItem:self.storage];
}

@end
