//
//  ODAPageViewController.h
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/22.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODAPageViewController : UIViewController
@property(nonatomic,strong)UIImage *img;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,copy)NSString *pageId;
@end

NS_ASSUME_NONNULL_END
