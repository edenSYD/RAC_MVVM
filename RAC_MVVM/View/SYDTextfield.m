//
//  SYDTextfield.m
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/8/14.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import "SYDTextfield.h"

@interface SYDTextfield()
@property(nonatomic,strong) SYDInputValidator *validator;
@property (nonatomic, strong) CAShapeLayer *waveLayer;
@property (nonatomic, strong) UITapGestureRecognizer *tapViewDown;
@end
@implementation SYDTextfield
#pragma mark - over load

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self wf_setUpViews];
        [self wf_commonSets];
    }
    return self;
    
}
-(void)placeholder:(NSString *)placeholder inputValidatror:(SYDInputValidator *)validator{
    self.placeholder = placeholder;
    self.validator = validator;
}
#pragma mark - 设置占位符和验证输入的策略
#pragma mark - 创建视图

- (void)wf_setUpViews {
    
    _waveLayer = [CAShapeLayer layer];
    
    UIBezierPath *origianal = [UIBezierPath bezierPath];
    [origianal moveToPoint:CGPointMake(0,self.bounds.size.height - 1)];
    [origianal addLineToPoint:CGPointMake(0,self.bounds.size.height - 1)];
    [origianal addLineToPoint:CGPointMake(self.bounds.size.width,self.bounds.size.height - 1)];
    
    _waveLayer.path        = origianal.CGPath;
    _waveLayer.strokeColor = [MainColor CGColor];
    _waveLayer.fillColor   = nil;
    _waveLayer.borderWidth = 1.0f;
    _waveLayer.lineCap     = kCALineCapRound;
    _waveLayer.lineJoin    = kCALineJoinRound;
    _waveLayer.borderColor =[UIColor blackColor].CGColor;
    [self.layer addSublayer:_waveLayer];
    
    _tapViewDown = [[UITapGestureRecognizer alloc] init];
    _tapViewDown.cancelsTouchesInView = NO;
    [[_tapViewDown rac_gestureSignal] subscribeNext:^(id x) {
        [self resignFirstResponder];
    }];
}

#pragma mark - 基础设置

- (void)wf_commonSets {
    
    self.backgroundColor = [UIColor colorWithRed:61/255.0
                                           green:137/255.0
                                            blue:222/255.0
                                           alpha:0.0];
    self.placeholder = @" ";
    self.textColor = MainColor;
    [self setValue:MainColor forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont boldSystemFontOfSize:18] forKeyPath:@"_placeholderLabel.font"];
    
    [[self rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(id x){
        [self.superview addGestureRecognizer:_tapViewDown];
        [self wf_waveAnimation];
    }];
    
    [[self rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(id x) {
        [self.superview removeGestureRecognizer:_tapViewDown];
        [self wf_validate];
    }];
    
}

#pragma mark - 波浪动画

- (void)wf_waveAnimation {
    CABasicAnimation *pathAppear = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAppear.duration          = 1.5;
    pathAppear.fromValue         = (__bridge id)_waveLayer.path;
    pathAppear.toValue           = (__bridge id)[self wf_wavePath].CGPath;
    
    [_waveLayer addAnimation:pathAppear forKey:@"make the layer wave"];
}

- (UIBezierPath *)wf_wavePath {
    
    UIBezierPath *startPath = [UIBezierPath bezierPath];
    [startPath moveToPoint:CGPointMake(0, self.bounds.size.height - 1)];
    [startPath addCurveToPoint:CGPointMake(self.bounds.size.width-25, self.bounds.size.height - 1) controlPoint1:CGPointMake(50, self.bounds.size.height)  controlPoint2:CGPointMake(self.bounds.size.width/2, 20)];
    return startPath;
}

- (void)wf_validate {
    BOOL isLegal = [self.validator userNameValidatoInput:self.text];
    if (!isLegal) {
        self.illegalMessage = self.validator.errorMessage;
        self.inputLegal = @"illegal";
    } else {
        self.inputLegal = @"legal";
    }
}

@end
