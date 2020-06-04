//
//  ODALoginViewController.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/22.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODALoginViewController.h"
#import "UIColor+ODExtension.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "OdinAnalysisSDK.h"

@interface ODALoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@end

@implementation ODALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    self.accountView.layer.borderColor = [UIColor colorWithRed:177 withGreen:177 withBlue:177].CGColor;
    self.accountView.layer.borderWidth = 1;
    self.accountView.layer.masksToBounds = YES;
    self.accountView.layer.cornerRadius = 4;
    
    self.pwdView.layer.borderColor = [UIColor colorWithRed:177 withGreen:177 withBlue:177].CGColor;
    self.pwdView.layer.borderWidth = 1;
    self.pwdView.layer.masksToBounds = YES;
    self.pwdView.layer.cornerRadius = 4;
    
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 4;
}
- (IBAction)loginAction:(id)sender {
    if (self.accountTextField.text.length <= 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Set the text mode to show only text.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入用户账号";
        // Move to bottm center.
        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        
        [hud hideAnimated:YES afterDelay:2.f];
        return;
    }
    
    NSDictionary *loginParm = @{
        @"user_id":self.accountTextField.text,
        @"type":[NSNumber numberWithInt:1],
        @"status":[NSNumber numberWithInt:1],
        @"du":[NSNumber numberWithLong:2],
    };
    
    [OdinAnalysisSDK trackEvent:@"login" param:loginParm];
    
    [self.navigationController popViewControllerAnimated:YES];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *userRigsterDic = @{
        @"eventName":@"login",
        @"data":@[
                @{@"name":@"操作类型:",@"value":@"登录"},
                @{@"name":@"事件code:",@"value":@"login"},
                @{@"name":@"活跃渠道:",@"value":appDelegate.channel},
                @{@"name":@"用户ID:",@"value":self.accountTextField.text},
                @{@"name":@"状态:",@"value":@"成功"},
                @{@"name":@"登录时长:",@"value":@"2s"},
        ]
    };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EventResultNote" object:userRigsterDic];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
