//
//  ODABaseInfoHeaderView.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/20.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODABaseInfoHeaderView.h"
#import "ODAnalysisHeader.h"
#import "UIColor+ODExtension.h"

@interface ODABaseInfoHeaderView ()

@property(nonatomic,strong)UILabel *titleLbl;
@property(nonatomic,strong)UIView *titleLine;

@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UILabel *sdkNameLbl;
@property(nonatomic,strong)UIView *sdkNameLine;
@property(nonatomic,strong)UILabel *sdkVersionLbl;
@property(nonatomic,strong)UIView *sdkVersionLine;
@property(nonatomic,strong)UILabel *updateTimeLbl;
@end

@implementation ODABaseInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    CGFloat leftPadding = 21 * PUBLICSCALE;
    CGFloat marging = 18;
    CGFloat lineH = 1;
    CGFloat singleH = 50;
    
    self.titleLbl = [[UILabel alloc]init];
    self.titleLbl.text = @"SDK基础信息";
    self.titleLbl.textColor = [UIColor colorWithRed:79 withGreen:81 withBlue:90];
    self.titleLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.titleLbl];
    
    self.titleLine = [[UIView alloc]init];
    self.titleLine.backgroundColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
    [self addSubview:self.titleLine];
    
    self.contentView = [[UIView alloc]init];
    [self addSubview:self.contentView];
    self.sdkNameLbl = [[UILabel alloc]init];
    self.sdkNameLbl.textColor = [UIColor colorWithRed:79 withGreen:81 withBlue:90];
    self.sdkNameLbl.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.sdkNameLbl];
    self.sdkNameLine = [[UIView alloc]init];
    self.sdkNameLine.backgroundColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
    [self.contentView addSubview:self.sdkNameLine];
    
    self.sdkVersionLbl = [[UILabel alloc]init];
    self.sdkVersionLbl.textColor = [UIColor colorWithRed:79 withGreen:81 withBlue:90];
    self.sdkVersionLbl.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.sdkVersionLbl];
    self.sdkVersionLine = [[UIView alloc]init];
    self.sdkVersionLine.backgroundColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
    [self.contentView addSubview:self.sdkVersionLine];
    
    self.updateTimeLbl = [[UILabel alloc]init];
    self.updateTimeLbl.textColor = [UIColor colorWithRed:79 withGreen:81 withBlue:90];
    self.updateTimeLbl.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.updateTimeLbl];
    
    self.titleLbl.frame = CGRectMake(36 * PUBLICSCALE, 20, SCREEN_WIDTH - 2 * leftPadding, 20);
    self.titleLine.frame = CGRectMake(leftPadding, 7 + CGRectGetMaxY(_titleLbl.frame), SCREEN_WIDTH - 2 * leftPadding, lineH);
    
    _contentView.frame = CGRectMake(leftPadding, 11 + CGRectGetMaxY(self.titleLine.frame), SCREEN_WIDTH - 2 * leftPadding, self.frame.size.height - (11 + CGRectGetMaxY(self.titleLine.frame)));
    _sdkNameLbl.frame = CGRectMake(marging, 0, CGRectGetWidth(_contentView.frame) - 2 * marging, singleH);
    _sdkVersionLbl.frame = CGRectMake(marging, singleH, CGRectGetWidth(_contentView.frame) - 2 * marging, singleH);
    _updateTimeLbl.frame = CGRectMake(marging, 2 * singleH, CGRectGetWidth(_contentView.frame) - 2 * marging, singleH);
    _sdkNameLine.frame = CGRectMake(marging, singleH, CGRectGetWidth(_contentView.frame) - 2 * marging, lineH);
    _sdkVersionLine.frame = CGRectMake(marging, 2 * singleH, CGRectGetWidth(_contentView.frame) - 2 * marging, lineH);
    
    
    //contentView 加阴影
    _contentView.layer.masksToBounds = NO;
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.shadowColor = [UIColor colorWithRed:38 withGreen:71 withBlue:98 alpha:.4].CGColor;
    _contentView.layer.shadowOffset = CGSizeMake(0,4);   //0,0围绕阴影四周  0,4向下有4个像素的偏移
    _contentView.layer.shadowOpacity = .3;   //设置阴影透明度
    _contentView.layer.shadowRadius = 5;      //设置阴影圆角
    _contentView.layer.cornerRadius = 8;     //设置视图圆角
    
}

- (void)reloaHeaderView:(NSDictionary *)dic{
    _sdkNameLbl.text = [NSString stringWithFormat:@"SDK名称： %@",dic[@"sdkName"]];
    _sdkVersionLbl.text = [NSString stringWithFormat:@"SDK版本： %@",dic[@"sdkVersion"]];
    _updateTimeLbl.text = [NSString stringWithFormat:@"更新日期： %@",dic[@"sdkUpdateTime"]];
}
@end
