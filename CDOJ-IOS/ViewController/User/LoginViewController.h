//
//  LoginViewController.h
//  CDOJ-IOS
//
//  Created by GuessEver on 16/8/10.
//  Copyright © 2016年 UESTCACM QKTeam. All rights reserved.
//

#import "DefaultViewController.h"
#import "UserModel.h"

@interface LoginViewController : DefaultViewController <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView* avatar;
@property (nonatomic, strong) UITextField* usernameInput;
@property (nonatomic, strong) UITextField* passwordInput;
@property (nonatomic, strong) UIButton* loginBtn;
@property (nonatomic, strong) UIButton* registerBtn;

@property (nonatomic, strong) UserModel* user;

- (void)reloadAvatar;

@end
