//
//  RACDelegateViewController.m
//  RAC_MVVM
//
//  Created by 木槿科技 on 2018/6/26.
//  Copyright © 2018年 深圳市木槿科技有限公司. All rights reserved.
//

#import "RACDelegateViewController.h"
#import "ModelBase.h"
#import "MovieModel.h"
#import "MovieViewModel.h"
#import "MovieCollectionViewCell.h"


@interface RACDelegateViewController ()
//viewmodel
@property(nonatomic,strong) MovieViewModel *viewModel;
//列表
@property(nonatomic,strong) UICollectionView *collectionView;
//数据源
@property(nonatomic,strong) NSArray *listArray;
@end

@implementation RACDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"页面1" forState:UIControlStateNormal];
    //[self.view addSubview:btn];
    [self initUI];
    //绑定viewmodel
    [self bindViewModel];
}
-(void)initUI{
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    collectionView.backgroundColor = UIColor.whiteColor;
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    self.collectionView = collectionView;
    [self.collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:[MovieCollectionViewCell cellReuseIdentifier]];
    //collectionView dataSouce
    A2DynamicDelegate *dataSource = self.collectionView.bk_dynamicDataSource;
    //item个数
    [dataSource implementMethod:@selector(collectionView:numberOfItemsInSection:) withBlock:^NSInteger(UICollectionView *collectionView,NSInteger section){
        return self.listArray.count;
    }];
    //item配置
    [dataSource implementMethod:@selector(collectionView:cellForItemAtIndexPath:) withBlock:^UICollectionViewCell*(UICollectionView *collectionView,NSIndexPath *indexPath){
        id<MovieModelProtocol> cell = nil;
        Class cellClass = [MovieCollectionViewCell class];
        if (cellClass) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MovieCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
            if ([cell respondsToSelector:@selector(renderWithModel:)]) {
                [cell renderWithModel:self.listArray[indexPath.row]];
            }
        }
        return (UICollectionViewCell *)cell;
    }];
    self.collectionView.dataSource = (id)dataSource;
   //delegate
    A2DynamicDelegate *delegate = self.collectionView.bk_dynamicDelegate;
    //item Size
    [delegate implementMethod:@selector(collectionView:layout:sizeForItemAtIndexPath:) withBlock:^CGSize(UICollectionView *collectionView,UICollectionViewLayout *layout,NSIndexPath *indexPath){
        return CGSizeMake(scaledCellValue(115), scaledCellValue(135));
    }];
    //内边距
    [delegate implementMethod:@selector(collectionView:layout:insetForSectionAtIndex:) withBlock:^UIEdgeInsets(UICollectionView *collectionView ,UICollectionViewLayout *layout, NSInteger section) {
        return UIEdgeInsetsMake(0, 5, 0, 5);
    }];
    
    self.collectionView.delegate = (id)delegate;
}
//绑定viewmodel事件
-(void)bindViewModel{
    @weakify(self);
    //将命令执行后的数据交给controller
    [self.viewModel.command.executionSignals.switchToLatest subscribeNext:^(NSArray<MovieModel *> *array){
        @strongify(self);
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        self.listArray = array;
        [self.collectionView reloadData];
        [SVProgressHUD dismissWithDelay:1.5];
    }];
    
    //执行command
    [self.viewModel.command execute:nil];
    [SVProgressHUD showWithStatus:@"加载中..."];
}
- (MovieViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MovieViewModel alloc] init];
    }
    return _viewModel;
}
-(void)btnBack{

    //1.判断是否有代理信号
    if (self.delegateSubject) {
        //3.发出信号-通知执行
        [self.delegateSubject sendNext:nil];
    }
}
#pragma LAZY
-(RACSubject *)delegateSubject{
    if (!_delegateSubject) {
        //1.创建信号
        _delegateSubject = [RACSubject subject];
    }
    return _delegateSubject;
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
