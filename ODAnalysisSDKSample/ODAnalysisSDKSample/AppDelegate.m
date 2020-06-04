//
//  AppDelegate.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/20.
//  Copyright © 2020 odin. All rights reserved.
//

#import "AppDelegate.h"
#import "OdinAnalysisSDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.channel = @"AppStore";
    [OdinAnalysisSDK initSDKWithAPPKey:@"985459861c2c4e7b8f4f2c7245e56448" Channel:self.channel];
    [OdinAnalysisSDK setEnableLog:YES];
    return YES;
}


@end
