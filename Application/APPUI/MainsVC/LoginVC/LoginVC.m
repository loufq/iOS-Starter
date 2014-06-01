//
//  LoginVC.m
//  TollCollector
//
//  Created by loufq on 14-3-23.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "LoginVC.h"
#import "API.h"

@interface LoginVC ()<UITextFieldDelegate>{
    UIView* vWrapper;
    UITextField* tfUserName;
    UITextField* tfPassword;
    UIButton* btnLogin;
}

@end

@implementation LoginVC
#define kMessage_APP_LoginInfo @"kMessage_APP_LoginInfo"
+(BOOL)isLogin{
    return true;
}

- (void)viewWillLayoutSubviews{
    
}

- (void)viewDidLayoutSubviews{
    
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    vWrapper =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 88)];
    vWrapper.clipsToBounds = YES;
    vWrapper.backgroundColor =[UIColor whiteColor];
    vWrapper.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin
    |UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    vWrapper.center = self.view.center;
    vWrapper.top -=100;
    
    
    [self.view addSubview:vWrapper];
    
    UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    UIView *paddingPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    CGSize size = CGSizeMake(vWrapper.width, vWrapper.height/2);
    tfUserName =[UITextField createWithSize:size];
    tfUserName.keyboardType = UIKeyboardTypeAlphabet;
    tfUserName.placeholder = @"帐号";
    tfUserName.borderStyle = UITextBorderStyleNone;
    tfUserName.leftView = paddingUserName;
    tfUserName.leftViewMode = UITextFieldViewModeAlways;
    tfUserName.returnKeyType = UIReturnKeyNext;
    tfUserName.delegate = self;
    [tfUserName addTarget:self
                   action:@selector(textFieldFinished:)
         forControlEvents:UIControlEventEditingDidEndOnExit];
    
    tfPassword =[UITextField createWithSize:size];
    tfPassword.secureTextEntry = YES;
    tfPassword.borderStyle = UITextBorderStyleNone;
    tfPassword.placeholder = @"密码";
    tfPassword.leftView = paddingPassword;
    tfPassword.leftViewMode = UITextFieldViewModeAlways;
    tfPassword.returnKeyType = UIReturnKeyDone;
    tfPassword.delegate = self;
    tfPassword.bottom = vWrapper.height;
    [tfPassword addTarget:self
                   action:@selector(textFieldFinished:)
         forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [vWrapper addSubview:tfUserName];
    [vWrapper addSubview:tfPassword];
    
    UILabel* lblSplit =[UILabel UnderLine];
    lblSplit.backgroundColor =[UIColor grayColor];
    lblSplit.top = vWrapper.height/2;
    [vWrapper addSubview:lblSplit];
    
    lblSplit =[UILabel UnderLine];
    lblSplit.backgroundColor =[UIColor grayColor];
    lblSplit.top = vWrapper.height-1;
    [vWrapper addSubview:lblSplit];
    
    int iTop = vWrapper.bottom + 30;
    BButton* btn1 =[[BButton alloc] initWithFrame:CGRectMake(0, iTop, 300, 44) type:BButtonTypeSuccess style:BButtonStyleBootstrapV3];
    btnLogin = btn1;
    btn1.width = vWrapper.width;
    btn1.centerX = vWrapper.centerX;
    btn1.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin
    |UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    [btn1 setTitle:@"登录" forState:UIControlStateNormal];
    [btn1 setTitle:@"登录" forState:UIControlStateHighlighted];
    btn1.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:22];
    
    [btn1 addTarget:self action:@selector(btn1Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    [self bk_performBlock:^(id obj) {
        [tfUserName becomeFirstResponder];
    } afterDelay:0.1];
    
    [self.view bk_whenTapped:^{
        [tfUserName becomeFirstResponder];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)btn1Login:(id)sender
{
    [self doLoginProcess];
}

//UIKeyboard
- (void)textFieldFinished:(id)sender
{
    if (sender==tfUserName) {
        [tfPassword becomeFirstResponder];
    }else if (sender==tfPassword) {
        [self doLoginProcess];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//
-(void)doLoginProcess{
    NSString* userName = tfUserName.text.trimWhiteSpace;
    NSString* pwd = tfPassword.text.trimWhiteSpace;
    if (!userName.length) {
        [tfUserName becomeFirstResponder];
        return;
    }
    if (!pwd.length) {
        [tfPassword becomeFirstResponder];
        return;
    }
    [tfUserName resignFirstResponder];
    [tfPassword resignFirstResponder];
    btnLogin.enabled = NO;
    MBProgressHUD* hud =[MBProgressHUD showHUDAddedTo:vWrapper animated:YES];
    [API login:userName pwd:pwd success:^(id obj) {
        
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        self.normalBlock(obj);
    } failture:^(NSError *error) {
        btnLogin.enabled = YES;
        [hud hide:YES];
        UIAlertView* av =[UIAlertView bk_alertViewWithTitle:@"提醒" message:error.localizedDescription];
        [av bk_setCancelButtonWithTitle:@"确定" handler:^{
            tfPassword.text = @"";
            tfUserName.text=@"";
            [tfUserName becomeFirstResponder];
        }];
        [av show];
    }];
    
}

@end
