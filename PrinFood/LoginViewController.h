//
//  SCLoginViewController.h
//  Prin Food
//
//  Created by Kirill Kudaev on 26.11.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController <FBSDKLoginButtonDelegate>

@property (nonatomic, strong) IBOutlet FBSDKLoginButton *loginButton_;
@property (nonatomic, strong) IBOutlet UIButton *continueButton_;

// YES if facebook icon on the main menu screen was pressed.
@property (nonatomic, assign) BOOL profileIconPressed;

@end
