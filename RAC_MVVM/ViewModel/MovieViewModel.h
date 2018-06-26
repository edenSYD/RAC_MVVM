//
//  MovieViewModel.h
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/6/26.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieModel.h"
@interface MovieViewModel : NSObject
//command 处理实际事务-网络请求
@property(nonatomic,strong,readonly) RACCommand *command;

@end
