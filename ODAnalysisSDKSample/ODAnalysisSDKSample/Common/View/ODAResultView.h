//
//  ODAResultView.h
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/21.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODAResultView : UIView
@property(nonatomic,strong)NSDictionary *resultData;
@property(nonatomic,copy) void (^okActionBlock)(void);
@end

NS_ASSUME_NONNULL_END
