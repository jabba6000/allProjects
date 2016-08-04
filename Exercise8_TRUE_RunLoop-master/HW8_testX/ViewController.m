//
//  ViewController.m
//  HW8_testX
//
//  Created by Uri Fuholichev on 8/1/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextView *logTextView;

//Это словарь для самих потоков
@property (strong, atomic) NSMutableDictionary *dictonaryWithThreads;
@property (strong, atomic) MyThread *thread;

// Это словарь для словарей с режимами соответствующих потоков
@property (strong, atomic) NSMutableDictionary *dictonaryForDictWithModes;
// Это и есть словарь с режимами. Такой есть у каждого потока
@property (strong, atomic) NSMutableDictionary *dictionaryWithModes;
@property (strong, atomic) MyMode *mode;

//Это свойство для удерживания объекта MyThreadController
@property(strong, atomic) MyThreadController *threadControl;

@end

@implementation ViewController
{
    NSTimer *myTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Удерживаем объект MyThreadController
    MyThreadController *controller = [MyThreadController new];
    _threadControl = controller;
    
    _dictonaryWithThreads = [NSMutableDictionary new];
    _dictonaryForDictWithModes = [NSMutableDictionary new];
    
    _threadControl.delegate = self;
    
}

- (IBAction)newThreadButton:(UIButton *)sender {
    //здесь должна выполняться проверка на имя, есть ли такой поток в словаре, если нет, то стартуем
    if (![_dictonaryWithThreads objectForKey:_threadTField.text])
    {
        //здесь создается наш поток из кастомного контроллера потоков MyThreadController
        _thread=[_threadControl startThreadWithName:_threadTField.text];
        
        //после чего созданный и работающий поток добавляется в словарь для потоков
        [_dictonaryWithThreads setObject:_thread forKey:_thread.name];
        
        //заодно сразу же запускаем второй словарь для словаря с модами
        _dictionaryWithModes = [NSMutableDictionary new];
        [_dictonaryForDictWithModes setObject:_dictionaryWithModes forKey:_threadTField.text];
    }
    else
    {
        NSString *str = @"Thread is already exists\n";
        NSLog(str);
        _logTextView.text = [_logTextView.text stringByAppendingString: str];
    }
}

- (IBAction)stopThreadButton:(UIButton *)sender {
    if ([_dictonaryWithThreads objectForKey:_threadTField.text])
    {
        [self performSelector:@selector(removeThread) onThread:[_dictonaryWithThreads objectForKey:_threadTField.text] withObject:nil waitUntilDone:NO]; //останавливаем поток
        
        //удаляем поток из второго словаря (со словарями режимов)
        [_dictonaryForDictWithModes removeObjectForKey:_threadTField.text];
        //удаялем поток из словаря с потоками
        [_dictonaryWithThreads removeObjectForKey:_threadTField.text];
    }
    else
    {
        NSString *str = @"No such thread\n";
        NSLog(str);
        _logTextView.text = [_logTextView.text stringByAppendingString: str];
    }
}

-(void)removeThread{
    /*
     Данный метод селктора отменяет все текущие режимы Ранлупа текущего
     потока, переводя их флаг в положение NO, а также главный режим. После этого отменяет сам поток
     Удаление потока из словаря потоков происходит в методе выше
     */
    for (MyMode *mode in [_dictonaryForDictWithModes objectForKey:_threadTField.text])
        [mode setModeIsRunning:NO];
    
    _thread.threadIsAlive = NO;
    [_thread cancel];
    
    NSString *str = @"All modes were terminated\n";
    NSLog(str);
    dispatch_async (dispatch_get_main_queue(), ^{
        _logTextView.text = [_logTextView.text stringByAppendingString: str];
    });
}

- (IBAction)startModeButton:(UIButton *)sender {
    //проверка, есть ли такой поток вообще
    if([_dictonaryWithThreads objectForKey:_threadTField.text])
    {
        //проверка, запущен ли такой режим уже
        if(![[_dictonaryForDictWithModes objectForKey:_threadTField.text] objectForKey:_modeTField.text])
        {
            [self performSelector:@selector(runNewMode) onThread:[_dictonaryWithThreads objectForKey:_threadTField.text] withObject:nil waitUntilDone:NO];
        }
        else
        {
            NSString *str = @"Such mode is already running\n";
            NSLog(str);
            _logTextView.text = [_logTextView.text stringByAppendingString: str];
        }
    }
    else
    {
        NSString *str = @"No such thread to start mode on it\n";
        NSLog(str);
        _logTextView.text = [_logTextView.text stringByAppendingString: str];
    }
}

-(void)runNewMode{
    
    _mode = [MyMode new];
    _mode.modeIsRunning = YES;
    _mode.modeName = _modeTField.text;
    
    CFStringRef modeName = (__bridge CFStringRef)_mode.modeName;
    
    CFRunLoopAddCommonMode( [[NSRunLoop currentRunLoop] getCFRunLoop], modeName );
    [[NSMachPort port] scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:_mode.modeName];
    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:_mode.modeName];
    
    [[_dictonaryForDictWithModes objectForKey:_threadTField.text] setObject:_mode forKey:_mode.modeName];
    
    NSString *str1 = [NSString stringWithFormat:@"Mode %@ on thread %@ was started\n", _mode.modeName, [[NSThread currentThread] name]];
    NSLog(str1);
    dispatch_async (dispatch_get_main_queue(), ^{
        _logTextView.text = [_logTextView.text stringByAppendingString: str1];
    });
    
    while (_mode.modeIsRunning == YES)
    {
        [[NSRunLoop currentRunLoop]runMode:_mode.modeName beforeDate:[NSDate distantFuture]];
    }
    
    NSString *str2 = [NSString stringWithFormat:@"Mode %@ on thread %@ was finished\n", _modeTField.text, [[NSThread currentThread] name]];
    NSLog(str2);
    dispatch_async (dispatch_get_main_queue(), ^{
        _logTextView.text = [_logTextView.text stringByAppendingString: str2];
    });
}

- (IBAction)stopModeButton:(id)sender {
    //проверка сначала, есть ли такой поток вообще
    if([_dictonaryWithThreads objectForKey:_threadTField.text])
    {
        //проверка, запущен ли такой режим уже у этого потока
        if([[_dictonaryForDictWithModes objectForKey:_threadTField.text] objectForKey:_modeTField.text])
        {
            [self performSelector:@selector(deleteMode) onThread:[_dictonaryWithThreads objectForKey:_threadTField.text] withObject:nil waitUntilDone:YES];
            //теперь удалим режим еще и из словаря
            [[_dictonaryForDictWithModes objectForKey:_threadTField.text] removeObjectForKey:_modeTField.text];
        }
        else
        {
            NSString *str1 = @"No such mode on this thread to delete it\n";
            NSLog(str1);
            _logTextView.text = [_logTextView.text stringByAppendingString: str1];
        }
    }
    else
    {
        NSString *str2 = @"No such thread to delete mode on it\n";
        NSLog(str2);
        _logTextView.text = [_logTextView.text stringByAppendingString: str2];
    }
}

// Метод для удаления одиночного конкретного режима
-(void)deleteMode{
    [(MyMode *)[[_dictonaryForDictWithModes objectForKey:_threadTField.text] objectForKey:_modeTField.text] setModeIsRunning:NO];
}

- (IBAction)startTimerButton:(UIButton *)sender {
    //проверяет, есть ли такой поток, чтобы в нем запустить таймер
    if([_dictonaryWithThreads objectForKey:_threadTField.text]){
        //проверяет, есть ли такой режим, чтобы в нем запустить таймер
        if([[_dictonaryForDictWithModes objectForKey:_threadTField.text] objectForKey:_modeTField.text])
        {
            [self performSelector:@selector(startTimer) onThread:[_dictonaryWithThreads objectForKey:_threadTField.text] withObject:nil waitUntilDone:NO];
        }
        else
        {
            NSString *str1 = @"No such mode on this thread to start timer\n";
            NSLog(str1);
            _logTextView.text = [_logTextView.text stringByAppendingString: str1];
        }
    }
    else
    {
        NSString *str2 = @"No such thread to start timer on it\n";
        NSLog(str2);
        _logTextView.text = [_logTextView.text stringByAppendingString: str2];
    }
}

-(void)startTimer {
    
    NSString *str = [NSString stringWithFormat:@"Timer on thread %@ with mode %@ was started\n", [[NSThread currentThread] name], [[NSRunLoop currentRunLoop] currentMode]];
    NSLog(str);
    dispatch_async (dispatch_get_main_queue(), ^{
        _logTextView.text = [_logTextView.text stringByAppendingString: str];
    });
    
    //создаем Таймер и добавляем его в указанный режим
    myTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector: @selector(fireTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:myTimer forMode:_modeTField.text];
}

-(void)fireTimer {
    NSString *str = [NSString stringWithFormat:@"Timer fire on thread %@ on mode %@ after 5 seconds\n", [[NSThread currentThread] name], [[NSRunLoop currentRunLoop] currentMode]];
    NSLog(str);
    dispatch_async (dispatch_get_main_queue(), ^{
        _logTextView.text = [_logTextView.text stringByAppendingString: str];
    });
}

- (IBAction)stopTimerButton:(UIButton *)sender {
    if (myTimer != nil){
        [myTimer invalidate];
        myTimer = nil;
        
        NSString *str = @"Timer was stopped\n";
        NSLog(str);
        _logTextView.text = [_logTextView.text stringByAppendingString: str];
    }
}

- (IBAction)pingButton:(UIButton *)sender {
    if([_dictonaryWithThreads objectForKey:_threadTField.text]){
        if([[_dictonaryForDictWithModes objectForKey:_threadTField.text] objectForKey:_modeTField.text])
        {
            NSArray *arrayWithModes = [[_dictonaryForDictWithModes objectForKey:_threadTField.text] allKeys];
            //Метод пинг выполняется на Бэкграудном потоке
            [self performSelector:@selector(ping) onThread:[_dictonaryWithThreads objectForKey:_threadTField.text] withObject:nil waitUntilDone:NO modes:arrayWithModes];
        }
        else
        {
            NSString *str = @"No such mode on this thread to ping to\n";
            NSLog(str);
            _logTextView.text = [_logTextView.text stringByAppendingString: str];
        }
    }
    else
    {
        NSString *str = @"No such thread to send ping to\n";
        NSLog(str);
        _logTextView.text = [_logTextView.text stringByAppendingString: str];
    }
}

-(void)ping{
    NSString *str = [NSString stringWithFormat:@"Now running %@ thread with mode %@\n", [[NSThread currentThread] name], [[NSRunLoop currentRunLoop] currentMode]];
    NSLog(str);
    dispatch_async (dispatch_get_main_queue(), ^{
        _logTextView.text = [_logTextView.text stringByAppendingString: str];
    });
    
    // сначала мы выводим в лог какой поток в каком режиме нас послал сюда, а затем вызываем
    // пинг в главном потоке
    [self performSelectorOnMainThread:@selector(sendPong) withObject:nil waitUntilDone:NO];
}

-(void)sendPong{
    NSString *str = @"Pong from main thread\n";
    NSLog(str);
    _logTextView.text = [_logTextView.text stringByAppendingString: str];
}

- (void)addItemModule:(MyThreadController *)controller didFinishEnteringItem:(NSString *)item
{
    dispatch_async (dispatch_get_main_queue(), ^{
        _logTextView.text = [_logTextView.text stringByAppendingString: item];
    });
}

@end
