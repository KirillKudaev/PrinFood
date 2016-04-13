// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  Modified by Kirill Kudaev on 26.11.15.

#import "LoginViewController.h"
#import "Settings.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@implementation LoginViewController
{
    BOOL _viewDidAppear;
    BOOL _viewIsVisible;
}

#pragma mark - Object lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//     if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
////         We wire up the FBSDKLoginButton using the interface builder
////         but we could have also explicitly wired its delegate here.
//     }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View Management

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Adding observers.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeProfileChange:) name:FBSDKProfileDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeTokenChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
    // Requesting additional read permissions.
    self.loginButton_.readPermissions = @[@"public_profile", @"user_friends"];
    self.continueButton_.layer.cornerRadius = 2;
    
    // If there's already a cached token, read the profile information.
    if ([FBSDKAccessToken currentAccessToken]) {
        [self observeProfileChange:nil];
    }
    
    // Changing continue button to display users Facebook name if the user had already logged in.
    if ([FBSDKProfile currentProfile]) {
        NSString *title = [NSString stringWithFormat:@"continue as %@", [FBSDKProfile currentProfile].firstName];
        [self.continueButton_ setTitle:title forState:UIControlStateNormal];
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    Settings *settings = [Settings defaultSettings];
    if (_viewDidAppear) {
        _viewIsVisible = YES;
        
        // reset
        settings.shouldSkipLogin = NO;
    } else {
        // performs segue to main menu
        if (!_profileIconPressed && (settings.shouldSkipLogin || [FBSDKAccessToken currentAccessToken]))
        {
            [self performSegueWithIdentifier:@"showMain" sender:nil];
        } else {
            _viewIsVisible = YES;
        }
        _viewDidAppear = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [Settings defaultSettings].shouldSkipLogin = YES;
    _viewIsVisible = NO;
}

//#pragma mark - Actions
//
//- (IBAction)showLogin:(UIStoryboardSegue *)segue
//{
//    // This method exists in order to create an unwind segue to this controller.
//}

//#pragma mark - FBSDKLoginButtonDelegate
//
//- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
//    if (error) {
//        NSLog(@"Unexpected login error: %@", error);
//        NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
//        NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
//        [[[UIAlertView alloc] initWithTitle:alertTitle
//                                    message:alertMessage
//                                   delegate:nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil] show];
//    } else {
//        if (_viewIsVisible) {
//            [self performSegueWithIdentifier:@"showMain" sender:self];
//        }
//    }
//}

//- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
//    if (_viewIsVisible) {
//        [self performSegueWithIdentifier:@"showMain" sender:self];
//    }
//}

#pragma mark - Observations

// Changing continue button to display users Facebook name if the user logged in.
- (void)observeProfileChange:(NSNotification *)notfication {
    if ([FBSDKProfile currentProfile]) {
        NSString *title = [NSString stringWithFormat:@"continue as %@", [FBSDKProfile currentProfile].firstName];
        [self.continueButton_ setTitle:title forState:UIControlStateNormal];
    }
}

// Changing continue button to display "or continue as a guest" if user logged out.
- (void)observeTokenChange:(NSNotification *)notfication {
    if (![FBSDKAccessToken currentAccessToken]) {
        [self.continueButton_ setTitle:@"or continue as a guest" forState:UIControlStateNormal];
    } else {
        [self observeProfileChange:nil];
    }
}

@end