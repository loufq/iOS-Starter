//
//  NSString+Validate.m
//  CodansShareLibrary10
//
//  Created by 钟 平 on 11-10-12.
//  Copyright 2011年 codans. All rights reserved.
//

#import "NSString+Validate.h"
 
@implementation NSString (Validate)

- (BOOL) isValidPhoneNumber{
    if(!self.length){
        return false;
    }
    //规定以13，15，18开头的11位数字位有效手机号
    NSString *allRegex = @"^[1][358]{1}[0-9]{9}$";
    NSPredicate *testAllRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",allRegex];
    BOOL isMatch = [testAllRegex evaluateWithObject:self];
    if (!isMatch) {
        allRegex = @"^[0-9]\\d{3,4}-\\d{7,11}$";
        testAllRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",allRegex];
        isMatch = [testAllRegex evaluateWithObject:self];
    }
    return isMatch;
}

- (BOOL) isValidEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:self];
}

-(BOOL)isValidPassWord{
    
    NSString *passwordRegex = @"^[\\w\\W]{6,}$";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordPredicate evaluateWithObject:self];
}

- (BOOL) isValidWeiXinURL{
    
    return YES;
}
- (BOOL) isValidiTunesURL{
    return YES;
}

- (BOOL) isValidURL{
    return YES;
}

@end
