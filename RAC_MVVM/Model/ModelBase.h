//
//  ModelBase.h
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/6/26.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelBase : NSObject
//返回数量
@property (nonatomic,assign) NSInteger count;
//分页量
@property (nonatomic,assign) NSInteger start;
//数据库总数量
@property (nonatomic,assign) NSInteger total;
//返回数据相关信息
@property (nonatomic,copy)   NSString *title;
@end
