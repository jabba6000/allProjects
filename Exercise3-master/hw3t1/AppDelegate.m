//
//  AppDelegate.m
//  hw3t1
//
//  Created by Uri Fuholichev on 4/14/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "AppDelegate.h"
#import "ContainerVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
/////СОЗДАЕМ ЭКРАНЫ/////////////////
    
    /*
    
    ContainerVC    *container  =   [ContainerVC new];
    
    
    UIViewController *centerVC = [UIViewController new];
    centerVC.view.backgroundColor = [UIColor blueColor];
    CGRect  myRect = CGRectMake(0, 0, 300, 100);
    UILabel *Label1 = [[UILabel alloc] initWithFrame:myRect];
    Label1.text = @"Center";
    Label1.textAlignment = NSTextAlignmentCenter;
    Label1.font = [UIFont fontWithName:@"Chalkduster" size:36];
    [Label1 setCenter:centerVC.view.center];
    [centerVC.view addSubview:Label1];
    
    UIViewController *topRightVC = [UIViewController new];
    topRightVC.view.backgroundColor = [UIColor redColor];
    UILabel *Label2 = [[UILabel alloc] initWithFrame:myRect];
    Label2.text = @"Top Right";
    Label2.textAlignment = NSTextAlignmentCenter;
    Label2.font = [UIFont fontWithName:@"Chalkduster" size:36];
    [Label2 setCenter:topRightVC.view.center];
    [topRightVC.view addSubview:Label2];
    topRightVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIViewController *topLeftVC = [UIViewController new];
    topLeftVC.view.backgroundColor = [UIColor greenColor];
    UILabel *Label3 = [[UILabel alloc] initWithFrame:myRect];
    Label3.text = @"Top Left";
    Label3.textAlignment = NSTextAlignmentCenter;
    Label3.font = [UIFont fontWithName:@"Chalkduster" size:36];
    [Label3 setCenter:topLeftVC.view.center];
    [topLeftVC.view addSubview:Label3];
    topLeftVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    
    UIViewController *bottomLeftVC = [UIViewController new];
    bottomLeftVC.view.backgroundColor = [UIColor yellowColor];
    UILabel *Label4 = [[UILabel alloc] initWithFrame:myRect];
    Label4.text = @"Bottom Left";
    Label4.textAlignment = NSTextAlignmentCenter;
    Label4.font = [UIFont fontWithName:@"Chalkduster" size:36];
    [Label4 setCenter:bottomLeftVC.view.center];
    [bottomLeftVC.view addSubview:Label4];
    bottomLeftVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    
    UIViewController   *bottomRightVC = [UIViewController new];
    bottomRightVC.view.backgroundColor = [UIColor grayColor];
    UILabel *Label5 = [[UILabel alloc] initWithFrame:myRect];
    Label5.text = @"Bottom Right";
    Label5.textAlignment = NSTextAlignmentCenter;
    Label5.font = [UIFont fontWithName:@"Chalkduster" size:36];
    [Label5 setCenter:bottomRightVC.view.center];
    [bottomRightVC.view addSubview:Label5];
    bottomRightVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
////VIEWCONTROLLER  ЭКРАНЫ ДЛЯ СВАЙПА/////////////
    
    UIViewController *RightVC = [UIViewController new];
    RightVC.view.backgroundColor = [UIColor blackColor];
    UILabel *Label6 = [[UILabel alloc] initWithFrame:myRect];
    Label6.text = @"Right";
    Label6.textAlignment = NSTextAlignmentCenter;
    Label6.font = [UIFont fontWithName:@"Chalkduster" size:36];
    Label6.textColor = [UIColor whiteColor];
    [Label6 setCenter:RightVC.view.center];
    [RightVC.view addSubview:Label6];
    
    
    UIViewController *LeftVC = [UIViewController new];
    LeftVC.view.backgroundColor = [UIColor blackColor];
    UILabel *Label7 = [[UILabel alloc] initWithFrame:myRect];
    Label7.text = @"Left";
    Label7.textAlignment = NSTextAlignmentCenter;
    Label7.font = [UIFont fontWithName:@"Chalkduster" size:36];
    Label7.textColor = [UIColor whiteColor];
    [Label7 setCenter:LeftVC.view.center];
    [LeftVC.view addSubview:Label7];
    
    
    UIViewController *TopVC = [UIViewController new];
    TopVC.view.backgroundColor = [UIColor blackColor];
    UILabel *Label8 = [[UILabel alloc] initWithFrame:myRect];
    Label8.text = @"Top";
    Label8.textAlignment = NSTextAlignmentCenter;
    Label8.font = [UIFont fontWithName:@"Chalkduster" size:36];
    Label8.textColor = [UIColor whiteColor];
    [Label8 setCenter:TopVC.view.center];
    [TopVC.view addSubview:Label8];
    
    
    UIViewController *BottomVC = [UIViewController new];
    BottomVC.view.backgroundColor = [UIColor blackColor];
    UILabel *Label9 = [[UILabel alloc] initWithFrame:myRect];
    Label9.text = @"Bottom";
    Label9.textAlignment = NSTextAlignmentCenter;
    Label9.font = [UIFont fontWithName:@"Chalkduster" size:36];
    Label9.textColor = [UIColor whiteColor];
    [Label9 setCenter:BottomVC.view.center];
    [BottomVC.view addSubview:Label9];
    
//////ПРИВЯЗЫВАЕМ CHILD VC К КОНТЕЙНЕР VC
    
    [container addChildViewController:LeftVC];
//    [container.view addSubview:LeftVC.view];
//    [LeftVC didMoveToParentViewController:container];
    
    [container addChildViewController:RightVC];
//    [container.view addSubview: RightVC.view];
//    [RightVC didMoveToParentViewController:container];

    [container addChildViewController: BottomVC];
//    [container.view addSubview: BottomVC.view];
//    [BottomVC didMoveToParentViewController:container];
    
    [container addChildViewController:TopVC];
//    [container.view addSubview:TopVC.view];
//    [TopVC didMoveToParentViewController:container];
    
    [container addChildViewController:centerVC];
    [container.view addSubview: centerVC.view];
//    [centerVC didMoveToParentViewController:container];
    
    
/////ДОБАВЛЯЕМ СВАЙПЫ К К ГЛАВНОМУ ВЬЮ КОНТРОЛЛЕРУ///////////
    
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
    
    
 
/////////ДОБАВЛЯЕМ СВАЙПЫ К CHILD VC
    
    UISwipeGestureRecognizer *gestRecFromRightToCenter = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromRightToCenter:)];
    [gestRecFromRightToCenter setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [RightVC.view addGestureRecognizer:gestRecFromRightToCenter];
    
    UISwipeGestureRecognizer *gestRecFromLeftToCenter = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromLeftToCenter:)];
    [gestRecFromLeftToCenter setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [LeftVC.view addGestureRecognizer:gestRecFromLeftToCenter];

    UISwipeGestureRecognizer *gestRecFromTopToCenter = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromTopToCenter:)];
    [gestRecFromTopToCenter setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [TopVC.view addGestureRecognizer:gestRecFromTopToCenter];
    
    UISwipeGestureRecognizer *gestRecFromBottomToCenter = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromBottomToCenter:)];
    [gestRecFromBottomToCenter setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [BottomVC.view addGestureRecognizer:gestRecFromBottomToCenter];

    
    
    
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

/////////ДОБАВЛЯЕМ ВЬЮ КОНТРОЛЛЕРЫ В МАССИВ////////////
    
    
    _arrayForVC = [[NSArray alloc] initWithObjects:
                           centerVC,
                           topLeftVC,
                           topRightVC,
                           bottomLeftVC,
                           bottomRightVC,
                           RightVC,
                           container,
                           LeftVC,
                           TopVC,
                           BottomVC,
                           nil
                           ];
    
    
    [self.window setRootViewController:[_arrayForVC objectAtIndex:6]];
    
    NSAssert(([_arrayForVC count] > 5 ), @"Array with VC is not wide enough");
   
     */
    
    [self.window setRootViewController:[ContainerVC new]];

    
    return YES;
}

/*


////ЦЕНТРАЛЬНЫЙ ЭКРАН - СЕЛЕКТОРЫ ДЛЯ СВАЙПОВ

-(void)swipeToRight: (UISwipeGestureRecognizer *) recognizer {
    [[_arrayForVC objectAtIndex:6] transitionFromViewController:[_arrayForVC objectAtIndex:0] toViewController:[_arrayForVC objectAtIndex:5] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
}

-(void)swipeToLeft: (UISwipeGestureRecognizer *) recognizer {
    [[_arrayForVC objectAtIndex:6] transitionFromViewController:[_arrayForVC objectAtIndex:0] toViewController:[_arrayForVC objectAtIndex:7] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

-(void)swipeToTop: (UISwipeGestureRecognizer *) recognizer{
    [[_arrayForVC objectAtIndex:6] transitionFromViewController:[_arrayForVC objectAtIndex:0] toViewController:[_arrayForVC objectAtIndex:8] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:nil completion:nil];
}

-(void)swipeToBottom: (UISwipeGestureRecognizer *) recognizer{
    [[_arrayForVC objectAtIndex:6] transitionFromViewController:[_arrayForVC objectAtIndex:0] toViewController:[_arrayForVC objectAtIndex:9] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
}

////ВТОРОСТЕПЕННЫЕ ЭКРАНЫ - СЕЛЕКТОРЫ ДЛЯ СВАЙПОВ

-(void)swipeFromRightToCenter: (UISwipeGestureRecognizer *) recognizer{
    [[_arrayForVC objectAtIndex:6] transitionFromViewController:[_arrayForVC objectAtIndex:5] toViewController:[_arrayForVC objectAtIndex:0] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

-(void)swipeFromLeftToCenter: (UISwipeGestureRecognizer *) recognizer{
    [[_arrayForVC objectAtIndex:6] transitionFromViewController:[_arrayForVC objectAtIndex:7] toViewController:[_arrayForVC objectAtIndex:0] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
}

-(void)swipeFromTopToCenter: (UISwipeGestureRecognizer *) recognizer{
    [[_arrayForVC objectAtIndex:6] transitionFromViewController:[_arrayForVC objectAtIndex:8] toViewController:[_arrayForVC objectAtIndex:0] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
}

-(void)swipeFromBottomToCenter: (UISwipeGestureRecognizer *) recognizer{
    [[_arrayForVC objectAtIndex:6] transitionFromViewController:[_arrayForVC objectAtIndex:9] toViewController:[_arrayForVC objectAtIndex:0] duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:nil completion:nil];
}


////ЦЕНТРАЛЬНЫЙ ЭКРАН - CЕЛЕКТОРЫ ДЛЯ ГОРЯЧИХ УГЛОВ

-(void)respondToTapTopLeft: (UITapGestureRecognizer *)recognizer{
    [[_arrayForVC objectAtIndex:0] presentViewController:[_arrayForVC objectAtIndex:1] animated:YES completion:nil];
}

-(void)respondToTapTopRight: (UITapGestureRecognizer *)recognizer{
    [[_arrayForVC objectAtIndex:0] presentViewController:[_arrayForVC objectAtIndex:2] animated:YES completion:nil];
}

-(void)respondToTapBottomLeft: (UITapGestureRecognizer *)recognizer{
    [[_arrayForVC objectAtIndex:0] presentViewController:[_arrayForVC objectAtIndex:3] animated:YES completion:nil];
}

-(void)respondToTapBottomRight: (UITapGestureRecognizer *)recognizer{
    [[_arrayForVC objectAtIndex:0] presentViewController:[_arrayForVC objectAtIndex:4] animated:YES completion:nil];
}


////ВСПЛЫВАЮЩИЕ ЭКРАНЫ - СЕЛЕКТОРЫ ДЛЯ ГОРЯЧИХ УГЛОВ (возвращение к центральному экрану)

-(void)respondToTapBackFromBR: (UITapGestureRecognizer *)recognizer{
    [[_arrayForVC objectAtIndex:4] dismissViewControllerAnimated:YES completion:nil];
}

-(void)respondToTapBackFromBL: (UITapGestureRecognizer *)recognizer{
    [[_arrayForVC objectAtIndex:3] dismissViewControllerAnimated:YES completion:nil];
}

-(void)respondToTapBackFromTR: (UITapGestureRecognizer *)recognizer{
    [[_arrayForVC objectAtIndex:2] dismissViewControllerAnimated:YES completion:nil];
}

-(void)respondToTapBackFromTL: (UITapGestureRecognizer *)recognizer{
    [[_arrayForVC objectAtIndex:1] dismissViewControllerAnimated:YES completion:nil];
}







*/




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
