//
//  RACDelegateViewController.h
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/6/26.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RACDelegateViewController : UIViewController
/**添加RACSubject,代替代理*/
@property(nonatomic,strong)RACSubject  *delegateSubject;
@end
