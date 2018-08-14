//
//  ViewController.m
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/6/25.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "RACDelegateViewController.h"//代理
#import "LoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view, typically from a nib.
    //1.RACSiganl 信号类，一般表示将来有数据传递，只要有数据改变，信号内部接收到数据，就会马上发出数据
    //2.RACSubscriber 订阅者 ，用于发送信号 ，这是一个协议，只有遵守这个协议，并且实现方法才能成为订阅者。通过create创建的信号，都有一个订阅者，帮助他发送数据。
    //3.RACDisposable 用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。也可以主动取消订阅信号
    //4.RACSubjec 信号提供者，通俗地说，本身就是信号源，也是发送信号的人。一般传递数据，或者要去处理事情，直接调用他就好了
    //5.RACCommand RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。我一般是用做数据请求的类，把数据请求放到这里
    //6.RACMulticastConnection用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用这个类处理。通俗地说，就是为了避免重复调用，多次请求
    //7.RACScheduler RAC中的队列，用GCD封装的
    
    self.title = @"RACDELEGATE";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"页面1" forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

/**
 点击调转到页面2
 */
-(void)btnClick{
//    RACDelegateViewController *delegateVC = [[RACDelegateViewController alloc]init];
//    //2.订阅信号
//    [delegateVC.delegateSubject subscribeNext:^(id x) {
//        //block调用时刻:信号发出新值就会调用
//        NSLog(@"订阅了");
//        NSLog(@"页面2按钮被点击了");
//    }];
//    [self.navigationController pushViewController:delegateVC animated:YES];
    
    LoginViewController *loginVc = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
