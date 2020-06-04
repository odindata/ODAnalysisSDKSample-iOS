//
//  ODAResultView.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/21.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODAResultView.h"
#import "ODAnalysisHeader.h"
#import "UIColor+ODExtension.h"
#import "ODAResultCell.h"

@interface ODAResultView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,copy)NSString *eventName;
@end

@implementation ODAResultView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *tipView = [UIView new];
    tipView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 40);
    tipView.backgroundColor = [UIColor colorWithRed:245 withGreen:247 withBlue:249];
    [self addSubview:tipView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compete"]];
    imgView.frame = CGRectMake(19 *PUBLICSCALE, 14, 34 / 2.0, 25 /2.0);
    [tipView addSubview:imgView];
    
    UILabel *tiplbl = [[UILabel alloc]init];
    tiplbl.text = @"操作成功";
    tiplbl.font = [UIFont systemFontOfSize:13];
    tiplbl.textColor = [UIColor colorWithRed:49 withGreen:51 withBlue:62];
    tiplbl.frame = CGRectMake(4 * PUBLICSCALE + CGRectGetMaxX(imgView.frame), 0, 60, 40);
 
    [tipView addSubview:tiplbl];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, CGRectGetWidth(self.frame) , 1)];
    lineView.backgroundColor = [UIColor colorWithRed:231 withGreen:231 withBlue:231];
    [tipView addSubview:lineView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 40 - 66) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ODAResultCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ODAResultCell class])];
    [self addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 19, 0,19);
    
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - (17 + 76)* PUBLICSCALE, 5 + CGRectGetMaxY( self.tableView.frame), 76 * PUBLICSCALE, 37)];
    okBtn.backgroundColor = [UIColor colorWithRed:4 withGreen:203 withBlue:148];
    [okBtn setTitle:@"确定" forState:0];
    okBtn.layer.cornerRadius = 4;
    okBtn.layer.masksToBounds = YES;
    [okBtn setTitleColor:[UIColor whiteColor] forState:0];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [okBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:okBtn];
}

- (void)setResultData:(NSDictionary *)resultData{
    _resultData = resultData;
    self.eventName = resultData[@"eventName"];
    self.data = resultData[@"data"];
    [self.tableView reloadData];
}

- (void)okAction:(UIButton *)sender{
    if (self.okActionBlock) {
        self.okActionBlock();
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ODAResultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ODAResultCell class])];
    cell.data = self.data[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
      return [NSString stringWithFormat:@"触发%@事件，采集结果如下",self.eventName];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor colorWithRed:79 withGreen:81 withBlue:90];
    header.textLabel.font = [UIFont systemFontOfSize:11];
    header.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [header viewWithTag:10086];
    if (lineView == nil) {
        lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
        [header addSubview:lineView];
    }
}
@end
