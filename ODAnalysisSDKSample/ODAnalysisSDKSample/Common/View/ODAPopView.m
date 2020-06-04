//
//  ODAPopView.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/21.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODAPopView.h"

@interface ODAPopView ()
@property(nonatomic,strong)UIButton *coverBtn;
@property(nonatomic,strong)UIImageView  *containerView;
@end

@implementation ODAPopView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.coverBtn = [[UIButton alloc]initWithFrame:self.bounds];
    self.coverBtn.backgroundColor = [UIColor blackColor];
    self.coverBtn.alpha = .4;
    [self.coverBtn addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.coverBtn];
    
    self.containerView = [[UIImageView alloc]init];
    self.containerView.userInteractionEnabled = YES;
    self.containerView.layer.cornerRadius = 4;
    self.containerView.layer.masksToBounds = YES;
    [self addSubview:self.containerView];
}

- (void)popView:(UIView *)view inRect:(CGRect)rect{
    self.containerView.frame = rect;
    view.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    [self.containerView addSubview:view];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismissAction:(UIButton *)sender{
    [self removeFromSuperview];
}

- (void)popViewDismiss{
     [self removeFromSuperview];
}
@end
