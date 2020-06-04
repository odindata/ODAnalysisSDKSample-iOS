//
//  ViewController.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/20.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ViewController.h"
#import "ODARegisterViewController.h"
#import "ODABaseInfoViewController.h"
#import "ODADetailViewController.h"
#import "UIColor+ODExtension.h"
#import "ODALoginViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"eventCell"];
    self.tableView.tableFooterView = [UIView new];
}

- (IBAction)baseInfoAction:(id)sender {
    AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAccount"];
    NSString *nick = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    NSArray *data =  @[
            @{@"name":@"用户账号:",@"value":account == nil ? @"无":account},
            @{@"name":@"活跃渠道:",@"value":de.channel},
            @{@"name":@"昵称:",@"value":nick == nil ? @"无":nick},
    ];
    ODABaseInfoViewController *baseVc = [ODABaseInfoViewController new];
    baseVc.data = data;
    [self.navigationController pushViewController:baseVc animated:YES];
}

- (void)eventDetail{
    [self.navigationController pushViewController:[ODADetailViewController new] animated:YES];
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ODAEvent.plist" ofType:nil]]];
    }
    return _dataArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *eventsDic = self.dataArray[section];
    NSArray *events = eventsDic[@"events"];
    return events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    NSDictionary *eventsDic = self.dataArray[indexPath.section];
    NSArray *events = eventsDic[@"events"];
    NSDictionary *event = events[indexPath.row];
    cell.textLabel.text = event[@"eventName"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:49 withGreen:51 withBlue:62];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *eventsDic = self.dataArray[section];
    return eventsDic[@"eventType"];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;

    header.textLabel.textColor = [UIColor colorWithRed:87 withGreen:89 withBlue:98];
    header.textLabel.font = [UIFont systemFontOfSize:13];
    header.contentView.backgroundColor = [UIColor colorWithRed:238 withGreen:238 withBlue:238];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger eventType = indexPath.row;
    if (indexPath.section == 1) {
        eventType = 20;
    }
    NSDictionary *eventsDic = self.dataArray[indexPath.section];
    NSArray *events = eventsDic[@"events"];
    NSDictionary *event = events[indexPath.row];
    NSString *eventName = event[@"eventName"];
    ODADetailViewController *detailVc = [ODADetailViewController new];
    detailVc.enventType = eventType;
    detailVc.title = [NSString stringWithFormat:@"%@详情",eventName];
    detailVc.detailData = event[@"property"];
    [self.navigationController pushViewController:detailVc animated:YES];
}



@end
