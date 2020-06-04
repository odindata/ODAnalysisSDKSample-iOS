//
//  ODADetailViewController.h
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/20.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODADetailViewController : UITableViewController
@property(nonatomic,assign) NSInteger enventType;
@property(nonatomic,strong)NSDictionary *detailData;
@property(nonatomic,strong)NSDictionary *resultData;
@end

NS_ASSUME_NONNULL_END
