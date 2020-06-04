//
//  ODAPageViewController.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/22.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODAPageViewController.h"
#import "ODAnalysisHeader.h"
#import "UIColor+ODExtension.h"
#import "ODAPopView.h"
#import "ODAResultView.h"
#import "OdinAnalysisSDK.h"
#import "AppDelegate.h"

@interface ODAPageViewController ()
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIButton *actionBtn;
@property(nonatomic,strong)NSDate *appearTime;
@property(nonatomic,strong)NSDate *disAppearTime;
@property(nonatomic,assign) NSTimeInterval interval;
@property(nonatomic,strong)ODAPopView *popView;
@property(nonatomic,strong)ODAResultView *resultView;
@end

@implementation ODAPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor redColor];
    self.imgView = [[UIImageView alloc]initWithImage:self.img];
    self.imgView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.imgView];
    
    
    self.resultView = [[ODAResultView alloc] initWithFrame:CGRectMake(14 * PUBLICSCALE, 155, SCREEN_WIDTH - 14 * 2 * PUBLICSCALE,0.57 * SCREEN_HEIGHT)];
    __weak typeof(self) weakSelf = self;
    self.resultView.okActionBlock = ^{
        [weakSelf.popView popViewDismiss];
    };
    
    //触发按钮
    UIButton *actionBtn = [[UIButton alloc]init];
    _actionBtn = actionBtn;
    actionBtn.backgroundColor = [UIColor colorWithRed:4 withGreen:203 withBlue:148];
    [actionBtn setTitle:@"触发完成" forState:0];
    actionBtn.layer.cornerRadius = 4;
    actionBtn.layer.masksToBounds = YES;
    [actionBtn setTitleColor:[UIColor whiteColor] forState:0];
    actionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [actionBtn addTarget:self action:@selector(actionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionBtn];
    actionBtn.hidden = !self.pageIndex;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageDuringAction:) name:@"PageDuringNote" object:nil];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.imgView.frame = self.view.bounds;
    _actionBtn.frame = CGRectMake(SCREEN_WIDTH - (21 + 76) * PUBLICSCALE,self.imgView.frame.size.height - 11 - 37, 76 *PUBLICSCALE, 37);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [OdinAnalysisSDK pageStart:self.pageId];
    self.appearTime = [NSDate date];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [OdinAnalysisSDK pageEnd:self.pageId];
    self.disAppearTime = [NSDate date];
  
    NSTimeInterval interval =  [self.disAppearTime timeIntervalSinceDate:self.appearTime];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PageDuringNote" object:@{@"du":[NSNumber numberWithInteger:interval]}];
}

- (void)pageDuringAction:(NSNotification *)note{
    NSDictionary * dataDic = note.object;
    self.interval = [dataDic[@"du"] doubleValue];
}

- (void)actionAction:(UIButton *)sender{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *pageDic = @{
        @"eventName":@"page_view",
        @"data":@[
                @{@"name":@"事件code:",@"value":@"page_view"},
                @{@"name":@"活跃渠道:",@"value":appDelegate.channel},
                @{@"name":@"当前页:",@"value":@"PageB"},
                @{@"name":@"前一个页面:",@"value":@"PageA"},
                @{@"name":@"页面访问时长:",@"value":[NSString stringWithFormat:@"%.0f",self.interval]}
        ]
    };
    
    self.resultView.resultData = pageDic;
      [self.popView popView:self.resultView inRect:CGRectMake(14 * PUBLICSCALE, 155, SCREEN_WIDTH - 14 * 2 * PUBLICSCALE,0.57 * SCREEN_HEIGHT)];
}

- (ODAPopView *)popView{
    if (_popView == nil) {
        _popView = [[ODAPopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _popView;
}
@end
