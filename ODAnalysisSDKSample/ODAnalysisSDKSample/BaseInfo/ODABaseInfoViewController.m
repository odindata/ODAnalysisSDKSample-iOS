//
//  ODABaseInfoViewController.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/20.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODABaseInfoViewController.h"
#import "ODABaseInfoHeaderView.h"
#import "ODAnalysisHeader.h"
#import "UIColor+ODExtension.h"
#import "ODAResultCell.h"

@interface ODABaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *sectionHeaderView;
@end

@implementation ODABaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"基本信息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ODABaseInfoHeaderView *headerView = [[ODABaseInfoHeaderView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 210)];
    [headerView reloaHeaderView:@{@"sdkName":@"ODAnalysisSDKSample",@"sdkVersion":@"1.0.8",@"sdkUpdateTime":@"2020/02/02"}];
    
    [self.view addSubview:headerView];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource =  self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ODAResultCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ODAResultCell class])];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 19, 0,19);
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(21 * PUBLICSCALE, 20 + CGRectGetMaxY(headerView.frame), SCREEN_WIDTH - 2 * 21 *PUBLICSCALE, SCREEN_HEIGHT - (20 + CGRectGetMaxY(headerView.frame)) - 30);
    
    self.tableView.layer.masksToBounds = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.layer.shadowColor = [UIColor colorWithRed:38 withGreen:71 withBlue:98 alpha:.4].CGColor;
    self.tableView.layer.shadowOffset = CGSizeMake(0,4);   //0,0围绕阴影四周  0,4向下有4个像素的偏移
    self.tableView.layer.shadowOpacity = .3;   //设置阴影透明度
    self.tableView.layer.shadowRadius = 5;      //设置阴影圆角
    self.tableView.layer.cornerRadius = 8;     //设置视图圆角
    self.tableView.scrollEnabled = NO;
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ODAResultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ODAResultCell class])];
    cell.data = self.data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}



- (UIView *)sectionHeaderView{
    if (_sectionHeaderView == nil) {
        _sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(22 * PUBLICSCALE, 0, SCREEN_WIDTH - 2 * 22 * PUBLICSCALE, 44)];
        _sectionHeaderView.backgroundColor = [UIColor whiteColor];
        UILabel *tiplbl = [[UILabel alloc]initWithFrame:CGRectMake(23, 0, CGRectGetWidth(_sectionHeaderView.frame), 44)];
        tiplbl.text = @"硬件基础信息";
        tiplbl.textColor = [UIColor colorWithRed:79 withGreen:81 withBlue:90];
        tiplbl.font = [UIFont systemFontOfSize:12];
        [_sectionHeaderView addSubview:tiplbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(22 * PUBLICSCALE, 43, CGRectGetWidth(_sectionHeaderView.frame) - 2 * 22 * PUBLICSCALE, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
        [_sectionHeaderView addSubview:lineView];
    }
    return _sectionHeaderView;
}
@end
