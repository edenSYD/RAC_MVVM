//
//  SYDBackGifView.m
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/8/14.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import "SYDBackGifView.h"

@implementation SYDBackGifView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self syd_setupViews];
    }
    return self;
}
-(void)syd_setupViews{
    YYImage *image = [YYImage imageNamed:@"backGif"];
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc]initWithImage:image];
    imageView.frame = self.frame;
    [self addSubview:imageView];
}
@end
