//
//  ContainerVC.m
//  hw3t1
//
//  Created by Uri Fuholichev on 7/30/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ContainerVC.h"
#import "CenterVC.h"

@implementation ContainerVC
{
    NSMutableArray *arrayForVC;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    CenterVC *centerVC = [CenterVC new];

    //ЭКРАНЫ ДЛЯ СВАЙПОВ
# pragma mark - экраны для свайпов

    CenterVC *rightVC = [CenterVC new];
    CenterVC *leftVC = [CenterVC new];
    CenterVC *topVC = [CenterVC new];
    CenterVC *bottomVC = [CenterVC new];

    centerVC.labelString = @"Center";
    rightVC.labelString = @"Right";
    leftVC.labelString = @"Left";
    topVC.labelString = @"Top";
    bottomVC.labelString = @"Bottom";
    
    rightVC.view.backgroundColor = [UIColor blackColor];
    leftVC.view.backgroundColor = [UIColor blackColor];
    topVC.view.backgroundColor = [UIColor blackColor];
    bottomVC.view.backgroundColor = [UIColor blackColor];

    [self addChildViewController:leftVC];
    [self addChildViewController:rightVC];
    [self addChildViewController: bottomVC];
    [self addChildViewController:topVC];
    [self addChildViewController:centerVC];
    
    [self.view addSubview: centerVC.view];
    
#pragma mark - экраны для горячих углов
    //ЭКРАНЫ ДЛЯ ГОРЯЧИХ УГЛОВ
    
    CenterVC *topRightVC = [CenterVC new];
    topRightVC.view.backgroundColor = [UIColor redColor];
    topRightVC.labelString = @"Top Right";
    topRightVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    CenterVC *topLeftVC = [CenterVC new];
    topLeftVC.view.backgroundColor = [UIColor greenColor];
    topLeftVC.labelString = @"Top Left";
    topLeftVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    CenterVC *bottomLeftVC = [CenterVC new];
    bottomLeftVC.view.backgroundColor = [UIColor yellowColor];
    bottomLeftVC.labelString = @"Bottom Left";
    bottomLeftVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    CenterVC *bottomRightVC = [CenterVC new];
    bottomRightVC.view.backgroundColor = [UIColor grayColor];
    bottomRightVC.labelString = @"Bottom Left";
    bottomRightVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    arrayForVC = [[NSArray alloc] initWithObjects:
                   self,
                   centerVC,
                   rightVC,
                   leftVC,
                   topVC,
                   bottomVC,
                   topRightVC,
                  topLeftVC,
                  bottomRightVC,
                  bottomLeftVC,
                  nil
                   ];
    
    NSAssert(([arrayForVC count] == 10 ), @"Array with VC is not wide enough");


    //СВАЙПЫ ДЛЯ ЦЕНТРАЛЬНОГО ЭКРАНА
    
    UISwipeGestureRecognizer *gestRecFromCenterToRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToRight:)];
    [gestRecFromCenterToRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [centerVC.view addGestureRecognizer:gestRecFromCenterToRight];
    
    UISwipeGestureRecognizer *gestRecFromCenterToLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToLeft:)];
    [gestRecFromCenterToLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [centerVC.view addGestureRecognizer:gestRecFromCenterToLeft];
    
    UISwipeGestureRecognizer *gestRecFromCenterToTop = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToTop:)];
    [gestRecFromCenterToTop setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [centerVC.view addGestureRecognizer:gestRecFromCenterToTop];
    
    UISwipeGestureRecognizer *gestRecFromCenterToBottom = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToBottom:)];
    [gestRecFromCenterToBottom setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [centerVC.view addGestureRecognizer:gestRecFromCenterToBottom];
    
    //ДОБАВЛЯЕМ СВАЙПЫ К CHILD VC
    
    UISwipeGestureRecognizer *gestRecFromRightToCenter = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromRightToCenter:)];
    [gestRecFromRightToCenter setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [rightVC.view addGestureRecognizer:gestRecFromRightToCenter];
    
    UISwipeGestureRecognizer *gestRecFromLeftToCenter = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromLeftToCenter:)];
    [gestRecFromLeftToCenter setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [leftVC.view addGestureRecognizer:gestRecFromLeftToCenter];
    
    UISwipeGestureRecognizer *gestRecFromTopToCenter = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromTopToCenter:)];
    [gestRecFromTopToCenter setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [topVC.view addGestureRecognizer:gestRecFromTopToCenter];
    
    UISwipeGestureRecognizer *gestRecFromBottomToCenter = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromBottomToCenter:)];
    [gestRecFromBottomToCenter setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [bottomVC.view addGestureRecognizer:gestRecFromBottomToCenter];
    
    ////ГОРЯЧИЕ УГЛЫ ДЛЯ ЦЕНТРАЛЬНОГО ЭКРАНА//////
    
    CGRect  hotCornerTL = CGRectMake(0, 0, 50, 50);
    UIView* hotCornerTopLeft = [[UIView alloc] initWithFrame:hotCornerTL];
    hotCornerTopLeft.backgroundColor = [UIColor greenColor];
    [centerVC.view addSubview: hotCornerTopLeft];
    
    UITapGestureRecognizer *tapHotCornerTL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapTopLeft:)];
    tapHotCornerTL.numberOfTapsRequired = 1;
    [hotCornerTopLeft addGestureRecognizer:tapHotCornerTL];
    
    
    CGRect  hotCornerTR = CGRectMake(364, 0, 50, 50);
    UIView* hotCornerTopRight = [[UIView alloc] initWithFrame:hotCornerTR];
    hotCornerTopRight.backgroundColor = [UIColor redColor];
    [centerVC.view addSubview: hotCornerTopRight];
    
    UITapGestureRecognizer *tapHotCornerTR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapTopRight:)];
    tapHotCornerTR.numberOfTapsRequired = 1;
    [hotCornerTopRight addGestureRecognizer:tapHotCornerTR];
    
    
    CGRect  hotCornerBL = CGRectMake(0, 686, 50, 50);
    UIView* hotCornerBottomLeft = [[UIView alloc] initWithFrame:hotCornerBL];
    hotCornerBottomLeft.backgroundColor = [UIColor yellowColor];
    [centerVC.view addSubview: hotCornerBottomLeft];
    
    UITapGestureRecognizer *tapHotCornerBL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapBottomLeft:)];
    tapHotCornerBL.numberOfTapsRequired = 1;
    [hotCornerBottomLeft addGestureRecognizer:tapHotCornerBL];
    
    
    CGRect  hotCornerBR = CGRectMake(364, 686, 50, 50);
    UIView* hotCornerBottomRight = [[UIView alloc] initWithFrame:hotCornerBR];
    hotCornerBottomRight.backgroundColor = [UIColor grayColor];
    [centerVC.view addSubview: hotCornerBottomRight];
    
    UITapGestureRecognizer *tapHotCornerBR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapBottomRight:)];
    tapHotCornerBR.numberOfTapsRequired = 1;
    [hotCornerBottomRight addGestureRecognizer:tapHotCornerBR];
    
    ///////ГОРЯЧИЕ УГЛЫ ДЛЯ ВСПЛЫВАЮЩИХ ЭКРАНОВ/////////
    
    CGRect  backFromBR = CGRectMake(0, 0, 50, 50);
    UIView* backFromBottomRight = [[UIView alloc] initWithFrame:backFromBR];
    backFromBottomRight.backgroundColor = [UIColor blueColor];
    [bottomRightVC.view addSubview: backFromBottomRight];
    
    UITapGestureRecognizer *tapHotCornerOnBR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapBackFromBR:)];
    tapHotCornerOnBR.numberOfTapsRequired = 1;
    [backFromBottomRight addGestureRecognizer:tapHotCornerOnBR];
    
    
    CGRect  backFromBL = CGRectMake(364, 0, 50, 50);
    UIView* backFromBottomLeft = [[UIView alloc] initWithFrame:backFromBL];
    backFromBottomLeft.backgroundColor = [UIColor blueColor];
    [bottomLeftVC.view addSubview: backFromBottomLeft];
    
    UITapGestureRecognizer *tapHotCornerOnBL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapBackFromBL:)];
    tapHotCornerOnBL.numberOfTapsRequired = 1;
    [backFromBottomLeft addGestureRecognizer:tapHotCornerOnBL];
    
    
    CGRect  backFromTR = CGRectMake(0, 686, 50, 50);
    UIView* backFromTopRight = [[UIView alloc] initWithFrame:backFromTR];
    backFromTopRight.backgroundColor = [UIColor blueColor];
    [topRightVC.view addSubview: backFromTopRight];
    
    UITapGestureRecognizer *tapHotCornerOnTR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapBackFromTR:)];
    tapHotCornerOnTR.numberOfTapsRequired = 1;
    [backFromTopRight addGestureRecognizer:tapHotCornerOnTR];
    
    
    CGRect  backFromTL = CGRectMake(364, 686, 50, 50);
    UIView* backFromTopLeft = [[UIView alloc] initWithFrame:backFromTL];
    backFromTopLeft.backgroundColor = [UIColor blueColor];
    [topLeftVC.view addSubview: backFromTopLeft];
    
    UITapGestureRecognizer *tapHotCornerOnTL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapBackFromTL:)];
    tapHotCornerOnTL.numberOfTapsRequired = 1;
    [backFromTopLeft addGestureRecognizer:tapHotCornerOnTL];
}

//СЕЛЕКТОРЫ ДЛЯ СВАЙПОВ ЦЕНТРАЛЬНОГО ЭКРАНА
#pragma mark - centralVC swipe selectors

-(void)swipeToRight: (UISwipeGestureRecognizer *) recognizer {
    [[arrayForVC objectAtIndex:0] transitionFromViewController:[arrayForVC objectAtIndex:1] toViewController:[arrayForVC objectAtIndex:2] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
}

-(void)swipeToLeft: (UISwipeGestureRecognizer *) recognizer {
    [[arrayForVC objectAtIndex:0] transitionFromViewController:[arrayForVC objectAtIndex:1] toViewController:[arrayForVC objectAtIndex:3] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

-(void)swipeToTop: (UISwipeGestureRecognizer *) recognizer{
    [[arrayForVC objectAtIndex:0] transitionFromViewController:[arrayForVC objectAtIndex:1] toViewController:[arrayForVC objectAtIndex:4] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:nil completion:nil];
}

-(void)swipeToBottom: (UISwipeGestureRecognizer *) recognizer{
    [[arrayForVC objectAtIndex:0] transitionFromViewController:[arrayForVC objectAtIndex:1] toViewController:[arrayForVC objectAtIndex:5] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
}

////ВТОРОСТЕПЕННЫЕ ЭКРАНЫ - СЕЛЕКТОРЫ ДЛЯ СВАЙПОВ
#pragma mark - secondaryVC swipe selectors

-(void)swipeFromRightToCenter: (UISwipeGestureRecognizer *) recognizer{
    [[arrayForVC objectAtIndex:0] transitionFromViewController:[arrayForVC objectAtIndex:2] toViewController:[arrayForVC objectAtIndex:1] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

-(void)swipeFromLeftToCenter: (UISwipeGestureRecognizer *) recognizer{
    [[arrayForVC objectAtIndex:0] transitionFromViewController:[arrayForVC objectAtIndex:3] toViewController:[arrayForVC objectAtIndex:1] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
}

-(void)swipeFromTopToCenter: (UISwipeGestureRecognizer *) recognizer{
    [[arrayForVC objectAtIndex:0] transitionFromViewController:[arrayForVC objectAtIndex:4] toViewController:[arrayForVC objectAtIndex:1] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
}

-(void)swipeFromBottomToCenter: (UISwipeGestureRecognizer *) recognizer{
    [[arrayForVC objectAtIndex:0] transitionFromViewController:[arrayForVC objectAtIndex:5] toViewController:[arrayForVC objectAtIndex:1] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:nil completion:nil];
}

#pragma mark - Hot Corner sel for centralVC

////ЦЕНТРАЛЬНЫЙ ЭКРАН - CЕЛЕКТОРЫ ДЛЯ ГОРЯЧИХ УГЛОВ

-(void)respondToTapTopLeft: (UITapGestureRecognizer *)recognizer{
    [[arrayForVC objectAtIndex:0] presentViewController:[arrayForVC objectAtIndex:7] animated:YES completion:nil];
}

-(void)respondToTapTopRight: (UITapGestureRecognizer *)recognizer{
    [[arrayForVC objectAtIndex:0] presentViewController:[arrayForVC objectAtIndex:6] animated:YES completion:nil];
}

-(void)respondToTapBottomLeft: (UITapGestureRecognizer *)recognizer{
    [[arrayForVC objectAtIndex:0] presentViewController:[arrayForVC objectAtIndex:9] animated:YES completion:nil];
}

-(void)respondToTapBottomRight: (UITapGestureRecognizer *)recognizer{
    [[arrayForVC objectAtIndex:0] presentViewController:[arrayForVC objectAtIndex:8] animated:YES completion:nil];
}

#pragma mark - Hot Corner sel for childrenVC
////ВСПЛЫВАЮЩИЕ ЭКРАНЫ - СЕЛЕКТОРЫ ДЛЯ ГОРЯЧИХ УГЛОВ (возвращение к центральному экрану)

-(void)respondToTapBackFromBR: (UITapGestureRecognizer *)recognizer{
    [[arrayForVC objectAtIndex:4] dismissViewControllerAnimated:YES completion:nil];
}

-(void)respondToTapBackFromBL: (UITapGestureRecognizer *)recognizer{
    [[arrayForVC objectAtIndex:3] dismissViewControllerAnimated:YES completion:nil];
}

-(void)respondToTapBackFromTR: (UITapGestureRecognizer *)recognizer{
    [[arrayForVC objectAtIndex:2] dismissViewControllerAnimated:YES completion:nil];
}

-(void)respondToTapBackFromTL: (UITapGestureRecognizer *)recognizer{
    [[arrayForVC objectAtIndex:1] dismissViewControllerAnimated:YES completion:nil];
}

@end
