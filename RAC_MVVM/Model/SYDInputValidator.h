    //
//  SYDInputValidator.h
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/8/14.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYDInputValidator : NSObject
@property(nonatomic,strong) NSString *errorMessage;//错误原因
/*用户名验证*/
-(BOOL)userNameValidatoInput:(NSString *)input;
/*用户名验证*/
-(BOOL)vercodeValidatoInput:(NSString *)input;

-(BOOL)passwordValidatoInput:(NSString *)input;
@end
