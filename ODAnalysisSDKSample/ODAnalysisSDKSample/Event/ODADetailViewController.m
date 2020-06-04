//
//  ODADetailViewController.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/20.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODADetailViewController.h"
#import "ODAEventDetailCell.h"
#import "UIColor+ODExtension.h"
#import "ODAnalysisHeader.h"
#import "ODARegisterViewController.h"
#import "ODAResultView.h"
#import "ODAPopView.h"
#import "ODALoginViewController.h"
#import "ODAContainerViewController.h"
#import "OdinAnalysisSDK.h"
#import "AppDelegate.h"


@interface ODADetailViewController ()
@property(nonatomic,strong)NSDictionary *headDic;
@property(nonatomic,strong)NSMutableArray *datraArrary;
@property(nonatomic,strong)UIView *sectionHeaderView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *namelbl;
@property(nonatomic,strong)UILabel *desclbl;
@property(nonatomic,strong)ODAPopView *popView;
@property(nonatomic,strong)ODAResultView *resultView;
@end

@implementation ODADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ODAEventDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ODAEventDetailCell class])];
    self.tableView.rowHeight = 44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
    [self relodDetail:self.detailData];
    
    self.resultView = [[ODAResultView alloc] initWithFrame:CGRectMake(14 * PUBLICSCALE, 155, SCREEN_WIDTH - 14 * 2 * PUBLICSCALE,0.57 * SCREEN_HEIGHT)];
    __weak typeof(self) weakSelf = self;
    self.resultView.okActionBlock = ^{
        [weakSelf.popView popViewDismiss];
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showResult:) name:@"EventResultNote" object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showResult:(NSNotification *)note{
    NSDictionary *data =  note.object;
    self.resultView.resultData = data;
    [self.popView popView:self.resultView inRect:CGRectMake(14 * PUBLICSCALE, 155, SCREEN_WIDTH - 14 * 2 * PUBLICSCALE,0.57 * SCREEN_HEIGHT)];
}


- (void)relodDetail:(NSDictionary *)dic{
    //刷新头部
    self.headDic = dic[@"head"];
    _desclbl.text = self.headDic[@"desc"];
    _namelbl.text = self.headDic[@"name"];
    
    
    //刷新tableView
    self.datraArrary = nil;
    [self.datraArrary addObjectsFromArray:dic[@"data"]];
    [self.tableView reloadData];
}

- (void)actionAction:(UIButton *)sender{
   
    switch (self.enventType) {
        case 0:
            [self.navigationController pushViewController:[ODARegisterViewController new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[ODALoginViewController new] animated:YES];
            break;
        case 2:
        {
            //获取验证码
            [OdinAnalysisSDK trackEvent:@"getCode" param:@{@"page_id":@"ODADetailViewController",@"eventId":@"getCode",@"event_name":@"获取验证码",@"service_type":@"注册"}];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *codeDic = @{
                @"eventName":@"getCode",
                @"data":@[
                        @{@"name":@"当前页id:",@"value":@"ODADetailViewController"},
                        @{@"name":@"事件id:",@"value":@"getCode"},
                        @{@"name":@"活跃渠道:",@"value":appDelegate.channel},
                        @{@"name":@"事件名称:",@"value":@"获取验证码"},
                        @{@"name":@"业务类型:",@"value":@"注册"},
                        
                ]
            };
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EventResultNote" object:codeDic];
        }
            break;
        case 3:
        {
            //支付事件
            
            [OdinAnalysisSDK trackEvent:@"payment" param:@{@"order_number":@"202006041031",@"payment_status":@"1",@"amount":@"128"}];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *payDic = @{
                @"eventName":@"payment",
                @"data":@[
                        @{@"name":@"订单编号:",@"value":@"202006041031"},
                        @{@"name":@"支付状态:",@"value":@"1"},
                        @{@"name":@"活跃渠道:",@"value":appDelegate.channel},
                        @{@"name":@"订单金额:",@"value":@"128"}
                ]
            };
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EventResultNote" object:payDic];
        }
            break;
        case 4:
        {
            //评论事件
            [OdinAnalysisSDK trackEvent:@"comment" param:@{@"page_id":@"ODADetailViewController",
                                                           @"eventId":@"comment",
                                                           @"event_name":@"评论",
                                                           @"content_id":@"内容id",
                                                           @"content_name":@"内容名称",
                                                           @"operation_type":@"1"
            }];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *commentDic = @{
                @"eventName":@"getCode",
                @"data":@[
                        @{@"name":@"当前页id:",@"value":@"ODADetailViewController"},
                        @{@"name":@"事件id:",@"value":@"comment"},
                        @{@"name":@"活跃渠道:",@"value":appDelegate.channel},
                        @{@"name":@"内容id:",@"value":@"内容id"},
                        @{@"name":@"内容名称:",@"value":@"内容名称"},
                        @{@"name":@"评论操作类型:",@"value":@"1"}
                ]
            };
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EventResultNote" object:commentDic];
        }
            break;
        case 5:
        {
            //分享事件
            [OdinAnalysisSDK trackEvent:@"share" param:@{@"page_id":@"ODADetailViewController",
                                                         @"eventId":@"share",
                                                         @"event_name":@"评论",
                                                         @"content_id":@"内容id",
                                                         @"content_name":@"内容名称",
                                                         @"way":@"微信好友"
            }];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *shareDic = @{
                @"eventName":@"share",
                @"data":@[
                        @{@"name":@"当前页id:",@"value":@"ODADetailViewController"},
                        @{@"name":@"事件id:",@"value":@"share"},
                        @{@"name":@"活跃渠道:",@"value":appDelegate.channel},
                        @{@"name":@"内容id:",@"value":@"内容id"},
                        @{@"name":@"内容名称:",@"value":@"内容名称"},
                        @{@"name":@"分享方式:",@"value":@"微信好友"}
                        
                ]
            };
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EventResultNote" object:shareDic];
        }
            break;
        case 6:
        {
            //分享事件
            [OdinAnalysisSDK trackEvent:@"read_info" param:@{@"page_id":@"ODADetailViewController",
                                                             @"content_id":@"内容id",
                                                             @"content_name":@"内容名称",
                                                             @"content_type":@"图片"
            }];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *shareDic = @{
                @"eventName":@"read_info",
                @"data":@[
                        @{@"name":@"当前页id:",@"value":@"ODADetailViewController"},
                        @{@"name":@"活跃渠道:",@"value":appDelegate.channel},
                        @{@"name":@"内容id:",@"value":@"内容id"},
                        @{@"name":@"内容名称:",@"value":@"内容名称"},
                        @{@"name":@"内容文件类型:",@"value":@"图片"}
                ]
            };
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EventResultNote" object:shareDic];
        }
            break;
            
        case 20:{
            [self.navigationController pushViewController:[ODAContainerViewController new] animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datraArrary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ODAEventDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ODAEventDetailCell class]) forIndexPath:indexPath];
   
    if (indexPath.row == 0) {
        cell.bgView.backgroundColor = [UIColor colorWithRed:246 withGreen:246 withBlue:247];
    }else{
         cell.bgView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor colorWithRed:245 withGreen:246 withBlue:250] : [UIColor whiteColor];
    }
    cell.dataDic = self.datraArrary[indexPath.row];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}


- (NSMutableArray *)datraArrary{
    if (_datraArrary == nil) {
        _datraArrary = [NSMutableArray arrayWithArray:@[
            @{
                @"name":@"属性名称",
                @"desc":@"属性描述",
                @"wirte":@"是否必填",
                @"dataType":@"数据类型"
            }
        ]];
    }
    return _datraArrary;
}

- (UIView *)sectionHeaderView{
    if (_sectionHeaderView == nil) {
        _sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH -12, 44)];
        _sectionHeaderView.backgroundColor = [UIColor whiteColor];
        UILabel *tiplbl = [[UILabel alloc]initWithFrame:CGRectMake(23, 0, CGRectGetWidth(_sectionHeaderView.frame), 44)];
        tiplbl.text = @"属性信息";
        tiplbl.textColor = [UIColor colorWithRed:79 withGreen:81 withBlue:90];
        tiplbl.font = [UIFont systemFontOfSize:12];
        [_sectionHeaderView addSubview:tiplbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(12, 43, CGRectGetWidth(_sectionHeaderView.frame) -12, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
        [_sectionHeaderView addSubview:lineView];
    }
    return _sectionHeaderView;
}

- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 166)];
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(21 * PUBLICSCALE, 11, SCREEN_WIDTH - 2 * 21 * PUBLICSCALE, 101)];
        [_headView addSubview:contentView];
        UILabel *namelbl = [[UILabel alloc]init];
        _namelbl = namelbl;
        namelbl.font = [UIFont systemFontOfSize:12];
        namelbl.textColor = [UIColor colorWithRed:79 withGreen:81 withBlue:90];
        namelbl.frame = CGRectMake(15 * PUBLICSCALE, 0, CGRectGetWidth(contentView.frame) - 2 * 15 * PUBLICSCALE, 101 / 2.0);
        [contentView addSubview:namelbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15 * PUBLICSCALE, 101 / 2.0, CGRectGetWidth(contentView.frame) - 2 * 15 * PUBLICSCALE, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
        [contentView addSubview:lineView];
        //contentView 加阴影
        contentView.layer.masksToBounds = NO;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.shadowColor = [UIColor colorWithRed:38 withGreen:71 withBlue:98 alpha:.2].CGColor;
        contentView.layer.shadowOffset = CGSizeMake(3,4);   //0,0围绕阴影四周  0,4向下有4个像素的偏移
        contentView.layer.shadowOpacity = .3;   //设置阴影透明度
        contentView.layer.shadowRadius = 5;      //设置阴影圆角
        contentView.layer.cornerRadius = 8;     //设置视图圆角
        
        
        
        UILabel *desclbl = [[UILabel alloc]init];
        _desclbl = desclbl;
        desclbl.font = [UIFont systemFontOfSize:12];
        desclbl.textColor = [UIColor colorWithRed:79 withGreen:81 withBlue:90];
        desclbl.frame = CGRectMake(15 * PUBLICSCALE, 101 / 2.0, CGRectGetWidth(contentView.frame) - 2 * 15 * PUBLICSCALE, 101 / 2.0);
        [contentView addSubview:desclbl];
        
        //触发按钮
        UIButton *actionBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - (21 + 76) * PUBLICSCALE, 11 + CGRectGetMaxY(contentView.frame), 76 *PUBLICSCALE, 37)];
        actionBtn.backgroundColor = [UIColor colorWithRed:4 withGreen:203 withBlue:148];
        actionBtn.layer.cornerRadius = 4;
        actionBtn.layer.masksToBounds = YES;
        [actionBtn setTitle:@"模拟触发" forState:0];
        [actionBtn setTitleColor:[UIColor whiteColor] forState:0];
        actionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [actionBtn addTarget:self action:@selector(actionAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:actionBtn];
        
    }
    return _headView;
}

- (ODAPopView *)popView{
    if (_popView == nil) {
        _popView = [[ODAPopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _popView;
}
@end
