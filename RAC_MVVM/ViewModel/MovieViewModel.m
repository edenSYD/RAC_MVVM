//
//  MovieViewModel.m
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/6/26.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import "MovieViewModel.h"
#import <UIKit/UIKit.h>
#import <Motis/Motis.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
//豆瓣电影API
#define url @"https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=100&client=&udid="
@interface MovieViewModel()
//command处理实际事务  网络请求
@property (nonatomic,strong)RACCommand *command;
@end
@implementation MovieViewModel
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initViewModel];
        
    }
    return self;
}
//初始化命令
-(void)initViewModel{
    
    // RACSignal使用步骤：
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 - (void)sendNext:(id)value
    
    
    // RACSignal底层实现：
    // 1.创建信号，首先把didSubscribe保存到信号中，还不会触发。
    // 2.当信号被订阅，也就是调用signal的subscribeNext:nextBlock
    // 2.2 subscribeNext内部会创建订阅者subscriber，并且把nextBlock保存到subscriber中。
    // 2.1 subscribeNext内部会调用siganl的didSubscribe
    // 3.siganl的didSubscribe中调用[subscriber sendNext:@1];
    // 3.1 sendNext底层其实就是执行subscriber的nextBlock
    
    @weakify(self);
    self.command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        //1.创建信号
        NSLog(@"创建信号");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self getDoubanList:^(NSArray<MovieModel *> *array) {
                //3.发送信号
                NSLog(@"发送信号");
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}
/**
 网络请求
 
 @param successBlock 成功回调
 */
-(void)getDoubanList:(void(^)(NSArray<MovieModel *> *array))successBlock{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *array = [NSMutableArray array];
        MovieModelList *base = [[MovieModelList alloc]init];
        [base mts_setValuesForKeysWithDictionary:responseObject];
        //遍历数组取出 存入数组并回调出去
        [base.subjects enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MovieModel *model = [[MovieModel alloc]init];
            [model mts_setValuesForKeysWithDictionary:obj];
            [array addObject:model];
        }];
        if (successBlock) {
            successBlock(array);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }];
}
@end
