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
    UILabel* lblTitle;
    UIView* vWrapper;
    UITextField* tfUserName;
    UITextField* tfPassword;
    UIButton* btnLogin;
    BOOL isShow;
}

@end

@implementation LoginVC


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
    UIImage* image =  skinImage(@"login/bg@2x.jpg");
    UIImageView* bgView =[UIImageView createWithImage:image];
    bgView.size = self.view.size;
    bgView.contentMode = UIViewContentModeScaleToFill;
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:bgView];
    
    vWrapper =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 88)];
    vWrapper.clipsToBounds = YES;
    vWrapper.backgroundColor =[UIColor whiteColor];
    vWrapper.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin
    |UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    vWrapper.center = self.view.center;
    vWrapper.top -=100;
    vWrapper.layer.cornerRadius = 5;
    //the colors for the gradient.  highColor is at the top, lowColor as at the bottom
    UIColor * highColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    UIColor * lowColor = [UIColor colorWithRed:0.851 green:0.859 blue:0.867 alpha:1.000];
    //The gradient, simply enough.  It is a rectangle
    CAGradientLayer * gradient = [CAGradientLayer layer];
    [gradient setFrame:[vWrapper bounds]];
    [gradient setColors:[NSArray arrayWithObjects:(id)[highColor CGColor], (id)[lowColor CGColor], nil]];
    //the rounded rect, with a corner radius of 6 points.
    //this *does* maskToBounds so that any sublayers are masked
    //this allows the gradient to appear to have rounded corners
    CALayer * roundRect = [CALayer layer];
    [roundRect setFrame:[vWrapper bounds]];
    [roundRect setCornerRadius:6.0f];
    [roundRect setMasksToBounds:YES];
    [roundRect addSublayer:gradient];
    //add the rounded rect layer underneath all other layers of the view
    [[vWrapper layer] insertSublayer:roundRect atIndex:0];
    //set the shadow on the view's layer
    [[vWrapper layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[vWrapper layer] setShadowOffset:CGSizeMake(0, 6)];
    [[vWrapper layer] setShadowOpacity:1.0];
    [[vWrapper layer] setShadowRadius:10.0];
    
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
    
    lblTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    lblTitle.numberOfLines= 2;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.centerX = self.view.width/2;
    lblTitle.bottom = vWrapper.top - 60;
    lblTitle.font =[UIFont fontWithName:@"Arial-BoldMT" size:44];
    lblTitle.text = @"济南市历下区智能停车综合管理系统\r\n停车场巡查终端工具";
    lblTitle.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin
    |UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:lblTitle];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
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
    if (!UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) return;

    [UIView animateWithDuration:0.3 animations:^{
        lblTitle.top =120;
        vWrapper.top =227;
        btnLogin.top =319;
    } completion:^(BOOL finished) {
        if (finished) {
            isShow = YES;
        }
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (!UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) return;

    [UIView animateWithDuration:0.3 animations:^{
        lblTitle.top =150;
        vWrapper.top =267;
         btnLogin.top =359;
    } completion:^(BOOL finished) {
       
    }];
    
    
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
