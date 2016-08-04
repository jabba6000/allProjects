//
//  SearchWebView.h
//  HW_6_Browser
//
//  Created by Uri Fuholichev on 5/28/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 Здесь у нас методы для поиска по страничке. Методы используют
 код java Script, который подключен в файле SearchWebView.js
 1) Метод выделяет все совпадения по запросу
 2) Метод снимает все выделения по запросу
 */

@interface SearchWebView : UIWebView

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str;

- (void)removeAllHighlights;

@end
