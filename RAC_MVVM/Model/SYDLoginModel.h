//
//  SYDLoginModel.h
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/8/14.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYDLoginModel : NSObject

@property(nonatomic,strong) NSDictionary *loginModel;
@property(nonatomic,strong) NSString *requestError;
-(void)requestVercode;
@end
