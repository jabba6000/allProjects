//
//  myVC.h
//  HW_6_Browser
//
//  Created by Uri Fuholichev on 5/27/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTF.h"
#import "SearchWebView.h"
#include <Foundation/Foundation.h>

//в проперти листе мы добавили разрешение на доступ, иначе переход по ссылке блокировался

//<UITextInputTraits> - чтобы далее ввод URL сделать с маленькой буквы и убрать автокоррекцию
//<SearchBarDelegate> - чтобы осуществлять поиск по странице с использованием Серч Бара

@interface myVC : UIViewController <UITextFieldDelegate, UIWebViewDelegate, UITextInputTraits, UISearchBarDelegate>

@property (strong, nonatomic) SearchWebView *myWebView;
@property (strong, nonatomic) NSMutableArray *arrayWithURLs;
@property(strong, nonatomic) MyTF *URLTextField;


@end
