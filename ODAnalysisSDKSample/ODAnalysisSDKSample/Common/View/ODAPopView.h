//
//  ODAPopView.h
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/21.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODAPopView : UIView
- (void)popView:(UIView *)view inRect:(CGRect)rect;
- (void)popViewDismiss;
@end

NS_ASSUME_NONNULL_END
