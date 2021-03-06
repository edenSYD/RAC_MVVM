//
//  LoginViewController.m
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/8/14.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import "LoginViewController.h"
#import "SYDBackGifView.h"//背景
#import "SYDTextfield.h"
#import "SYDInputValidator.h"
#import "SYDLoginViewModel.h"
@interface LoginViewController ()
@property (nonatomic, strong) UIImageView *signView;
@property (nonatomic, strong) SYDTextfield *username;
@property (nonatomic, strong) SYDTextfield *password;
@property (nonatomic, strong) SYDTextfield *vercode;
@property (nonatomic, strong) UIButton    *loadButton;
@property (nonatomic, strong) UIButton    *imageButton;
@property (nonatomic, strong) SYDLoginViewModel *loginViewModel;
@end

@implementation LoginViewController
#pragma mark - over load

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self wf_setUpViews];
    [self wf_makeConstraints];
    [self wf_requestData];
    [self wf_makeAnimations];
}
#pragma mark - 创建视图

- (void)wf_setUpViews {
    
    SYDBackGifView *backGifView = [[SYDBackGifView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:backGifView];
    
    _signView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign"]];
    _signView.frame = CGRectMake(kWindowWidth/4, kWindowHeight/2 - kWindowWidth/4, kWindowWidth/2, kWindowWidth/2);
    [self.view addSubview:_signView];
    
    _username = [[SYDTextfield alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth - 100, 40)];
    [_username placeholder:@"学号" inputValidatror:[SYDInputValidator new]];
    _username.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview:_username];
    [[_username rac_valuesAndChangesForKeyPath:@"illegalMessage" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(id x) {
        NSString *temp = [x[1] valueForKey:NSKeyValueChangeNewKey];
        [SVProgressHUD showErrorWithStatus:temp];
    }];
    
    _password = [[SYDTextfield alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth - 100, 40)];
    [_password placeholder:@"密码" inputValidatror:[SYDInputValidator new]];
    _password.keyboardType      = UIKeyboardTypeASCIICapable;
    _password.secureTextEntry   = YES;
    [self.view addSubview:_password];
    [[_password rac_valuesAndChangesForKeyPath:@"illegalMessage" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(id x) {
        NSString *temp = [x[1] valueForKey:NSKeyValueChangeNewKey];
        [SVProgressHUD showErrorWithStatus:temp];
    }];
    
    _vercode = [[SYDTextfield alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth - 100, 40)];
    [_vercode placeholder:@"验证码" inputValidatror:[SYDInputValidator new]];
    [self.view addSubview:_vercode];
    [[_vercode rac_valuesAndChangesForKeyPath:@"illegalMessage" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(id x) {
        NSString *temp = [x[1] valueForKey:NSKeyValueChangeNewKey];
        [SVProgressHUD showErrorWithStatus:temp];
    }];
    
    _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageButton.frame = CGRectMake(0, 0, 80, 38);
    _imageButton.backgroundColor = [UIColor lightGrayColor];
    WEAKSELF(weakSelf)
    [[_imageButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [weakSelf.loginViewModel getVercode];
     }];
    [self.view addSubview:_imageButton];
    
    _loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loadButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loadButton setTitle:@"" forState:UIControlStateHighlighted];
    [_loadButton setTitle:@"请正确填写信息" forState:UIControlStateDisabled];
    _loadButton.backgroundColor = [UIColor colorWithRed:61/255.0
                                                  green:137/255.0
                                                   blue:222/255.0
                                                  alpha:0.5];
    _loadButton.frame = CGRectMake(0, 0, kWindowWidth - 100, 30);
    _loadButton.enabled = YES;
    [self.view addSubview:_loadButton];
    
    RAC(self.loadButton,enabled) = [RACSignal combineLatest:@[ RACObserve(self.username, inputLegal), RACObserve(self.password, inputLegal), RACObserve(self.vercode, inputLegal)]
                                                     reduce:^id(NSString* usernameLegal, NSString* passwordLegal, NSString* vercodeLegal ){
                                                         
                                                         return @([usernameLegal isEqualToString:@"legal"] && [passwordLegal isEqualToString:@"legal"] && [vercodeLegal isEqualToString:@"legal"]);
                                                     }];
}

#pragma mark - 构造约束

- (void)wf_makeConstraints {
    
    WEAKSELF(weakself)
    
    [_username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top).with.offset(kWindowWidth *3 / 8 + 20);
        make.left.equalTo(weakself.view.mas_left).with.offset(50);
        make.right.equalTo(weakself.view.mas_right).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(kWindowWidth - 100, 40));
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_username.mas_bottom).with.offset(5);
        make.left.equalTo(weakself.view.mas_left).with.offset(50);
        make.right.equalTo(weakself.view.mas_right).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(kWindowWidth - 100, 40));
    }];
    
    [_vercode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_password.mas_bottom).with.offset(5);
        make.left.equalTo(weakself.view.mas_left).with.offset(50);
        make.right.equalTo(weakself.view.mas_right).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(kWindowWidth - 100, 40));
    }];
    
    [_imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_vercode.mas_top).with.offset(1);
        make.right.equalTo(_vercode.mas_right).with.offset(-1);
        make.size.mas_equalTo(CGSizeMake(80, 38));
    }];
    
    [_loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_vercode.mas_bottom).with.offset(20);
        make.left.equalTo(weakself.view.mas_left).with.offset(50);
        make.right.equalTo(weakself.view.mas_right).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(kWindowWidth - 100, 30));
    }];
    
}

#pragma mark - 绑定VM

- (void)wf_requestData {
    _loginViewModel = [[SYDLoginViewModel alloc] init];
    
    [[_loginViewModel rac_valuesAndChangesForKeyPath:@"URLstring"
                                             options:NSKeyValueObservingOptionNew
                                            observer:self]
     subscribeNext:^(id x) {
         NSString *temp = [x[1] valueForKey:NSKeyValueChangeNewKey];
         NSData *imageData = [[NSData alloc] initWithBase64EncodedString:temp options:NSDataBase64DecodingIgnoreUnknownCharacters];
         dispatch_async(dispatch_get_main_queue(), ^{
             UIImage *image = [UIImage imageWithData:imageData];
             [_imageButton setBackgroundImage:image
                                     forState:UIControlStateNormal];
         });
     }];
    
    [[_loginViewModel rac_valuesAndChangesForKeyPath:@"getError"
                                             options:NSKeyValueObservingOptionNew
                                            observer:self]
     subscribeNext:^(id x) {
         NSString *temp = [x[1] valueForKey:NSKeyValueChangeNewKey];
         [SVProgressHUD showErrorWithStatus:temp];
     }];
    
    [_loginViewModel getVercode];
    
}

#pragma mark - 动画

- (void)wf_makeAnimations {
    
    [UIView animateWithDuration:1.0 animations:^{
        _signView.frame = CGRectMake(kWindowWidth*3.0/8.0 , kWindowWidth/8.0, kWindowWidth/4.0, kWindowWidth/4.0);
    } completion:^(BOOL finished) {
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
