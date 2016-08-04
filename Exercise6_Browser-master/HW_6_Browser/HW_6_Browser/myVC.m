//
//  myVC.m
//  HW_6_Browser
//
//  Created by Uri Fuholichev on 5/27/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "myVC.h"

@implementation myVC{
    
    UISearchBar *webVSearchBar;
    NSString *filePath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    //создаем адрес на компе для последующей записи истории посещений
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = @"/FileWithArray.txt";
    filePath = [documentsDirectory stringByAppendingPathComponent:fileName];

    self.arrayWithURLs = [NSMutableArray arrayWithContentsOfFile:filePath];
    //////////////
    
    NSLog(@"At start array has %lu objects", (unsigned long)[self.arrayWithURLs count]);

    
#pragma mark - URLTextField with buttons
    
    _URLTextField = [[MyTF alloc] initWithFrame:CGRectMake(20, 30, self.view.frame.size.width-40, 30)];
    _URLTextField.backgroundColor = [UIColor whiteColor];
    _URLTextField.layer.cornerRadius = 5.;
    _URLTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //чтобы с маленькой буквы
    _URLTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:_URLTextField];
    
    /*
    В общем, тут такая запара: кнопка, положенная на текст филд становиться неактивной после того, как начинается ввод текста. Поэтому чтобы она оставалась активной ее можно кинуть либо на правый ViewMode, либо на левый. При этом две кнопки на один мод кинуть нельзя. При этом положение правого или левого можа можно кастомизировать, если унаследоваться от Текст Филда и переписать метод ,который задает положение левого или правого мода. ПРОБЛЕМА НЕ РЕШЕНА! НО!! в данном случае использован правый и левый моды, так что все чики-пуки.
    */
    UIButton    *clearTxtBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearTxtBtn addTarget:self action:@selector(clearTxtBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    clearTxtBtn.frame = CGRectMake(_URLTextField.bounds.size.width - 250, 2.5, 25, 25);
    [clearTxtBtn setBackgroundImage:[UIImage imageNamed:@"Delete25.png"] forState:UIControlStateNormal];
    [_URLTextField addSubview:clearTxtBtn]; //кидаем кнопку на правый мод
    _URLTextField.rightViewMode = UITextFieldViewModeAlways;
    _URLTextField.rightView = clearTxtBtn;

    
    UIButton    *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBtn addTarget:self action:@selector(goBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    goBtn.frame = CGRectMake(_URLTextField.bounds.size.width - 80, 2.5, 25, 25);
    [goBtn setBackgroundImage:[UIImage imageNamed:@"Play-25.png"] forState:UIControlStateNormal];
    [_URLTextField addSubview:goBtn]; //кидаем кнопку на левый мод
    _URLTextField.leftViewMode = UITextFieldViewModeAlways;
    _URLTextField.leftView = goBtn;
    
#pragma mark - Web Navigation Buttons.
//то ест кнопочки для обновления, вперед, назад по странице
    
    UIButton    *backward  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backward addTarget:self action:@selector(backwardPressed:) forControlEvents:UIControlEventTouchUpInside];
    backward.frame = CGRectMake(20, _URLTextField.frame.origin.y+40, 52, 52);
    [backward setBackgroundImage:[UIImage imageNamed:@"Backward-52.png"] forState:UIControlStateNormal];
    [self.view addSubview:backward];
    
    UIButton    *forward  = [UIButton buttonWithType:UIButtonTypeCustom];
    [forward addTarget:self action:@selector(forwardPressed:) forControlEvents:UIControlEventTouchUpInside];
    forward.frame = CGRectMake(20+backward.frame.size.width+20, _URLTextField.frame.origin.y+40, 52, 52);
    [forward setBackgroundImage:[UIImage imageNamed:@"Advance-52.png"] forState:UIControlStateNormal];
    [self.view addSubview:forward];
    
    UIButton    *refresh  = [UIButton buttonWithType:UIButtonTypeCustom];
    [refresh addTarget:self action:@selector(refreshPressed:) forControlEvents:UIControlEventTouchUpInside];
    refresh.frame = CGRectMake(20+backward.frame.size.width+20 +forward.frame.size.width+20, _URLTextField.frame.origin.y+40, 50, 50);
    [refresh setBackgroundImage:[UIImage imageNamed:@"Refresh-50.png"] forState:UIControlStateNormal];
    [self.view addSubview:refresh];
    
#pragma mark - WEBView
    
    self.myWebView = [[SearchWebView alloc] initWithFrame:CGRectMake (20, _URLTextField.frame.origin.y+40+52+10, self.view.frame.size.width-40, self.view.frame.size.height-75-30-30-10-51-10)];
    self.myWebView.layer.borderColor = [UIColor blackColor].CGColor;
    self.myWebView.layer.borderWidth = 3.0;
    self.myWebView.layer.cornerRadius = 3.0;
    
    [self.view addSubview:self.myWebView];

    
#pragma mark - WebView Search Bar
    
    webVSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20+backward.frame.size.width+20 +forward.frame.size.width+20+50+10, _URLTextField.frame.origin.y+55, 160, 30)];
    webVSearchBar.backgroundColor = [UIColor whiteColor];
    webVSearchBar.delegate = self;

    [self.view addSubview:webVSearchBar];
}


-(void)viewDidAppear:(BOOL)animated{
    
    //чтобы принимать выбранный на VC2 адрес используется UserDefaults
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString    *adress = [defaults objectForKey:@"goToAdress"];
    _URLTextField.text = adress;
    
    NSURL *nsurl=[NSURL URLWithString:adress];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.myWebView loadRequest:nsrequest];
    
    [defaults removeObjectForKey:@"goToAdress"];
    
    self.arrayWithURLs = [NSMutableArray arrayWithContentsOfFile:filePath];
    NSLog(@"Array has %lu objects", (unsigned long)[self.arrayWithURLs count]);

}

#pragma mark - search Bar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    // Делегат отслеживает все изменения в текстовом поле серч бара и если
    // введ хотя бы 1 символ, начинает выделять все совпадения в соответствии
    // с методами, которые мы ввели используя кусок кода с java Script
    
    if (searchText.length != 0)
        [self.myWebView highlightAllOccurencesOfString:searchText];
    if (searchText.length == 0)
        [self.myWebView removeAllHighlights];
}



#pragma mark - Methods For Selectors

-(void)backwardPressed: (UIButton *) sender{
    [self.myWebView goBack];
}

-(void)forwardPressed: (UIButton *) sender{
    [self.myWebView goForward];
}

-(void)refreshPressed: (UIButton * )sender{
    [self.myWebView reload];
}

-(void)clearTxtBtnPressed:(UIButton *)sender{
    _URLTextField.text = @"";
}

#pragma mark - GO_button

-(void)goBtnPressed: (UIButton *) sender{
    
    NSString *http = @"http://";
    NSString    *fromTextField = [[NSString alloc] initWithString:_URLTextField.text];
    NSString    *myAdress = [http stringByAppendingString:fromTextField];
    
    //добавили адрес в массив если адрес не пустой и его еще нет в массиве, если страница загрузилась
    
    //выполнили переход в адрес
    NSURL *nsurl=[NSURL URLWithString:myAdress];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.myWebView loadRequest:nsrequest];
    
    // добавляем заодно указанный адрес в массив с URL
    // даже если адрес недействителен (случайные симовлы), он будет добавлен в массив
    if (
        ![self.arrayWithURLs containsObject:myAdress]
        && (![myAdress isEqual:@"http://"])
        )
    {
        //эта проверка создает массив для URL, если его не сушествует еще
        if(!_arrayWithURLs)
        {
            _arrayWithURLs = [NSMutableArray new];
        }
        
        [_arrayWithURLs addObject: myAdress];
        NSLog(@"%@", filePath);
        [_arrayWithURLs writeToFile:filePath atomically:YES];
    }
    
    NSLog(@"After pressing button rray has %lu URL's", (unsigned long)[self.arrayWithURLs count]);
}



@end
