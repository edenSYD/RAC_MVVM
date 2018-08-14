//
//  SYDInputValidator.m
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/8/14.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
// 验证码验证

#import "SYDInputValidator.h"

@implementation SYDInputValidator
/*用户名验证*/
-(BOOL)userNameValidatoInput:(NSString *)input{
    NSString *regex = @"^[0-9]{8}$";
    NSPredicate *predicater = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isLegal = [predicater evaluateWithObject:input];
    if (!isLegal) {
        self.errorMessage = @"学号输入有误";
    }
    return isLegal;
}
/*用户名验证*/
-(BOOL)vercodeValidatoInput:(NSString *)input{
    BOOL isLegal = input.length < 1 ? NO : YES;
    if (!isLegal) {
        self.errorMessage = @"验证码为空";
    }
    return isLegal;
}

-(BOOL)passwordValidatoInput:(NSString *)input{
    BOOL isLegal = input.length < 1 ? NO : YES;
    if (!isLegal) {
        self.errorMessage = @"密码为空";
    }
    return isLegal;
}
@end
