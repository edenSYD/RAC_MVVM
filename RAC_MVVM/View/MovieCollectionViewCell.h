//
//  MovieCollectionViewCell.h
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/6/26.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCollectionViewCell : UICollectionViewCell
//复用标识符
+(NSString *)cellReuseIdentifier;
//处理数据源
-(void)renderWithModel:(id)model;
@end
