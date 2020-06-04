# ODAnalysisSDKSample-iOS
奥丁AnalysisSDK示例demo
# OdinAnalysis
奥丁数据统计集成
### CocoaPods
[CocoaPods](http://cocoapods.org) 是向项目添加OdinAnalysis的推荐方法。

1. 将OdinAnalysis的pod条目添加到您的Podfile文件中

###### 集成
    pod 'OdinAnalysis'
    
2. 通过运行“pod Install”安装

3. 把OdinAnalysis放在你需要的地方`#import <OdinAnalysisSDK.h>`
# 使用
在项目工程的Info.plist 中增加OdinKey 和 OdinSecret 两个字段
填入平台获取的odinKey和odinSecret的值

在didFinishLaunchingWithOptions中设置各平台的key
```objective-c

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	 [OdinAnalysisSDK initSDKWithAPPKey:@"OdinKey" Channel:@"AppStore"];
}
```
###### 事件统计
```objective-c
 [OdinAnalysisSDK eventOperation:@"单击事件"];
```
 ###### 自定义事件
```objective-c
 [OdinAnalysisSDK eventCustom:@"自定义事件" attributes:@{@"自定义key":@"自定义value"}];
 ```
###### 支付事件
```objective-c
 [OdinAnalysisSDK eventPay:12 orderNumber:@"NO.2000001" amount:@"100"];
```
 ###### 注册
```objective-c
 [OdinAnalysisSDK eventRegister:@"userId"];
```
###### 登录
```objective-c
 [OdinAnalysisSDK eventLogin:@"userId" status:@"登录状态 0:失败 1:成功"];
```
###### 用户反馈
```objective-c
 [OdinAnalysisSDK eventErrorTitle:@"用户反馈" context:@"用户返回信息"];
```
###### 页面统计事件，默认已开启自动埋点，如果需要手动埋点，需如下调用
```objective-c
 - (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [OdinAnalysisSDK pageStart:@"页面标识"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [OdinAnalysisSDK pageEnd:@"页面标识"];
}
```
