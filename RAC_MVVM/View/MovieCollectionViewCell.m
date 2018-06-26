//
//  MovieCollectionViewCell.m
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/6/26.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "MovieModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieCollectionViewCell()
@property(nonatomic,copy) UIImageView *imageView;
@property(nonatomic,copy) UILabel *labelTitle;
@property(nonatomic,copy) UILabel *labelpoint;
@end
@implementation MovieCollectionViewCell

/**
 数据源处理
 @param model 模型
 */
-(void)renderWithModel:(id)model{
    if ([model isKindOfClass:[MovieModel class]]) {
        MovieModel *movie = model;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:movie.images[@"medium"]?:nil]];
        self.labelTitle.text = movie.title?:@"";
        self.labelpoint.text = [NSString stringWithFormat:@"%@",movie.rating[@"average"]?:@(0)];
    }
}
+(NSString *)cellReuseIdentifier{
    return NSStringFromClass(self.class);
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.imageView.mas_width);
    }];
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.imageView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    [self.labelpoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(16);
        make.width.mas_lessThanOrEqualTo(40);
    }];
}
#pragma Lazy
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = 0;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
-(UILabel *)labelTitle{
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.textColor = UIColor.blackColor;
        _labelTitle.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_labelTitle];
    }
    return _labelTitle;
}
-(UILabel *)labelpoint{
    if (!_labelpoint) {
        _labelpoint = [[UILabel alloc]init];
        _labelpoint.textAlignment = NSTextAlignmentRight;
        _labelpoint.textColor = UIColor.blackColor;
        _labelpoint.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_labelpoint];
    }
    return _labelpoint;
}
@end
