//
//  SYDTextfield.h
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/8/14.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYDInputValidator.h"
@interface SYDTextfield : UITextField
@property(nonatomic,strong) NSString *illegalMessage;
@property(nonatomic,strong) NSString *inputLegal;

-(void)placeholder:(NSString *)placeholder inputValidatror:(SYDInputValidator *)validator;
@end
