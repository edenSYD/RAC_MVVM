//
//  SYDLoginModel.m
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/8/14.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import "SYDLoginModel.h"

@implementation SYDLoginModel
- (void)requestVercode {
    
    NSString *URL = @"http://scoreapi.xiyoumobile.com/users/verCode";
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    [sessionManager POST:URL
              parameters:nil
                progress:^(NSProgress * _Nonnull uploadProgress) {}
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     self.loginModel = responseObject;
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     self.requestError = @"请求验证码出错";
                     
                 }];
    
}
@end
