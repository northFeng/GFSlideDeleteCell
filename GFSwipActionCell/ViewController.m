//
//  ViewController.m
//  GFSwipActionCell
//
//  Created by XinKun on 2018/1/16.
//  Copyright © 2018年 North_feng. All rights reserved.
//

#import "ViewController.h"

#import "Masonry.h"

#import "CustomTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,GFSlideDeleteCellDelegate>

///
@property (nonatomic,strong) UITableView *tableView;

///数据源
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _dataArray = [NSMutableArray arrayWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16"]];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20) style:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //必须添加自定义cell的代理
    ((CustomTableViewCell *)cell).delegate = self;
    //必须给cell赋值cell的位置 indexPath
    ((CustomTableViewCell *)cell).cellIndexPath = indexPath;
    
    //赋值
    [((CustomTableViewCell *)cell) setDataModel:_dataArray[indexPath.section]];
    
    //这个设置不是cell的背景颜色，而是cell滑动按钮底部颜色
    //cell.backgroundColor = [UIColor redColor];
    
    //这个是设置cell的背景颜色
    ((CustomTableViewCell *)cell).cellScroller.backgroundColor = [UIColor greenColor];
    
    return cell;
}

///高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    switch (indexPath.section%3) {
        case 0:
            return 80;
            break;
        case 1:
            return 110;
            break;
        case 2:
            return 120;
            break;
            
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


//二：要想添加滑动按钮，必须实现此代理方法
#pragma mark - 自定义代理设置滑动删除按钮
- (NSArray *)gfSlideDeleteCell:(GFSlideDeleteCell *)slideDeleteCell trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *btnArray;
    
    switch (indexPath.section%3) {
        case 0:
            //创建文字按钮
            btnArray = [self setTextActionWithIndexPath:indexPath];
            break;
        case 1:
            //创建图片按钮
            btnArray = [self setImageActionWithIndexPath:indexPath];
            break;
        case 2:
            //创建自定义按钮
            btnArray = [self setCustomActionWithIndexPath:indexPath];
            break;
            
        default:
            break;
    }
    
    return btnArray;
}

//三：必须监听这个代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GFTableViewSlideNotice object:nil];
    
}

#pragma mark - 文字按钮
- (NSArray *)setTextActionWithIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    GFSwipeActionBtn *btn = [GFSwipeActionBtn rowActionWithStyle:GFSwipeActionStyleDefaule title:@"删除" image:nil actionWidth:100 backgroundColor:nil handler:^(NSIndexPath *indexPath) {
        NSLog(@"删除按钮------>这是第：%ld行",indexPath.section);
        [weakSelf deleteCell:indexPath];
    }];
    [btn setTitleColor:[UIColor redColor] forState:0];
    btn.backgroundColor = [UIColor lightGrayColor];
    
    GFSwipeActionBtn *btnTwo = [GFSwipeActionBtn rowActionWithStyle:GFSwipeActionStyleDefaule title:@"添加" image:nil actionWidth:100 backgroundColor:nil handler:^(NSIndexPath *indexPath) {
        NSLog(@"添加按钮------>这是第：%ld行",indexPath.section);
        [weakSelf addCell:indexPath];
    }];
    [btnTwo setTitleColor:[UIColor blueColor] forState:0];
    btnTwo.backgroundColor = [UIColor magentaColor];
    
    return @[btn,btnTwo];
}

///删除cell
- (void)deleteCell:(NSIndexPath *)indexPath{
    
    [_dataArray removeObjectAtIndex:indexPath.section];
    
    [self.tableView reloadData];
    
}

- (void)addCell:(NSIndexPath *)indexPath{
    NSString *string = [NSString stringWithFormat:@"%ld+%ld",indexPath.section,indexPath.row];
    [_dataArray addObject:string];
    
    [_tableView reloadData];
}

#pragma mark - 图片按钮
- (NSArray *)setImageActionWithIndexPath:(NSIndexPath *)indexPath{
    
    GFSwipeActionBtn *btn = [GFSwipeActionBtn rowActionWithStyle:GFSwipeActionStyleImage title:nil image:[UIImage imageNamed:@"ic_3_1@2x.png"] actionWidth:100 backgroundColor:nil handler:^(NSIndexPath *indexPath) {
        NSLog(@"左一按钮------>这是第：%ld行",indexPath.section);
    }];
    [btn setTitleColor:[UIColor redColor] forState:0];
    btn.backgroundColor = [UIColor lightGrayColor];
    
    GFSwipeActionBtn *btnTwo = [GFSwipeActionBtn rowActionWithStyle:GFSwipeActionStyleImage title:nil image:[UIImage imageNamed:@"ic_1_1@3x.png"] actionWidth:100 backgroundColor:nil handler:^(NSIndexPath *indexPath) {
        NSLog(@"左二按钮------>这是第：%ld行",indexPath.section);
    }];
    [btnTwo setTitleColor:[UIColor blueColor] forState:0];
    btnTwo.backgroundColor = [UIColor magentaColor];
    
    return @[btn,btnTwo];
}

#pragma mark - 自定义按钮
- (NSArray *)setCustomActionWithIndexPath:(NSIndexPath *)indexPath{
    
    GFSwipeActionBtn *btn = [GFSwipeActionBtn rowActionWithStyle:GFSwipeActionStyleCustom title:nil image:nil actionWidth:100 backgroundColor:nil handler:^(NSIndexPath *indexPath) {
        NSLog(@"左一自定义按钮------>这是第：%ld行",indexPath.section);
    }];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"ic_3_1@2x.png"];
    [btn addSubview:imgView];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"自定义一";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    [btn addSubview:label];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.centerY.equalTo(btn).offset(-10);
        make.height.and.width.mas_equalTo(30);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.centerY.equalTo(btn).offset(25/2.);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(70);
    }];
    
    
    GFSwipeActionBtn *btnTwo = [GFSwipeActionBtn rowActionWithStyle:GFSwipeActionStyleCustom title:nil image:[UIImage imageNamed:@"ic_1_1@3x.png"] actionWidth:100 backgroundColor:nil handler:^(NSIndexPath *indexPath) {
        NSLog(@"左二自定义按钮------>这是第：%ld行",indexPath.section);
    }];
    
    UIImageView *imgViewTwo = [[UIImageView alloc] init];
    imgViewTwo.image = [UIImage imageNamed:@"ic_1_1@3x.png"];
    [btnTwo addSubview:imgViewTwo];
    UILabel *labelTwo = [[UILabel alloc] init];
    labelTwo.text = @"自定义二";
    labelTwo.textAlignment = NSTextAlignmentCenter;
    labelTwo.font = [UIFont systemFontOfSize:15];
    [btnTwo addSubview:labelTwo];
    [imgViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btnTwo);
        make.centerY.equalTo(btnTwo).offset(-10);
        make.height.and.width.mas_equalTo(30);
    }];
    [labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btnTwo);
        make.centerY.equalTo(btnTwo).offset(25/2.);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(70);
    }];
    
    return @[btn,btnTwo];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
