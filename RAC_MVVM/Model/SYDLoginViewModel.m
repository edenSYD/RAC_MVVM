//
//  SYDLoginViewModel.m
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/8/14.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import "SYDLoginViewModel.h"
#import "SYDLoginModel.h"

@interface SYDLoginViewModel()
@property(nonatomic,strong) SYDLoginModel *loginModel;
@end
@implementation SYDLoginViewModel
- (instancetype)init {
    
    self = [super init];
    if (self) {
        _loginModel = [[SYDLoginModel alloc] init];
        [[_loginModel rac_valuesAndChangesForKeyPath:@"loginModel"
                                             options:NSKeyValueObservingOptionNew
                                            observer:self] subscribeNext:^(id x) {
            NSDictionary *dictionary =  [x[1] valueForKey:NSKeyValueChangeNewKey];
            NSDictionary *result = dictionary[@"result"];
            NSString *string = result[@"verCode"];
            NSArray *strArray = [string componentsSeparatedByString:@","];
            if (strArray.count) {
                self.urlStr = strArray[1];
            }
        }];
        [[_loginModel rac_valuesAndChangesForKeyPath:@"requestError"
                                             options:NSKeyValueObservingOptionNew
                                            observer:self] subscribeNext:^(id x) {
            self.getError =  [x[1] valueForKey:NSKeyValueChangeNewKey];
        }];
    }
    return self;
    
}

- (void)getVercode {
    [_loginModel requestVercode];
}
@end
