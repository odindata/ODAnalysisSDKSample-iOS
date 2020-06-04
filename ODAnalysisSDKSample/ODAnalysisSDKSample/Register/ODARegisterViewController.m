//
//  ODARegisterViewController.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/20.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODARegisterViewController.h"
#import "ODADetailViewController.h"
#import "UIColor+ODExtension.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "OdinAnalysisSDK.h"

@interface ODARegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIView *nikeView;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextFiled;

@end

@implementation ODARegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    self.accountView.layer.borderColor = [UIColor colorWithRed:177 withGreen:177 withBlue:177].CGColor;
    self.accountView.layer.borderWidth = 1;
    self.accountView.layer.masksToBounds = YES;
    self.accountView.layer.cornerRadius = 4;
    
    self.nikeView.layer.borderColor = [UIColor colorWithRed:177 withGreen:177 withBlue:177].CGColor;
    self.nikeView.layer.borderWidth = 1;
    self.nikeView.layer.masksToBounds = YES;
    self.nikeView.layer.cornerRadius = 4;
    
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 4;
}

- (IBAction)registerAction:(id)sender {
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

    NSDictionary *registerParm = @{
        @"user_id":self.accountTextField.text,
        @"nick_name":self.nickNameTextFiled.text,
    };
    [[NSUserDefaults standardUserDefaults] setObject:self.accountTextField.text forKey:@"userAccount"];
    [[NSUserDefaults standardUserDefaults] setObject:self.nickNameTextFiled forKey:@"nickName"];
    
    [OdinAnalysisSDK trackEvent:@"user_register" param:registerParm];
    
    [self.navigationController popViewControllerAnimated:YES];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *userRigsterDic = @{
        @"eventName":@"user_register",
        @"data":@[
                @{@"name":@"用户账号:",@"value":self.accountTextField.text},
                @{@"name":@"事件code:",@"value":@"user_register"},
                @{@"name":@"活跃渠道:",@"value":appDelegate.channel},
                @{@"name":@"昵称:",@"value":self.nickNameTextFiled.text},
        ]
    };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EventResultNote" object:userRigsterDic];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
