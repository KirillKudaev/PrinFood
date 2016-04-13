//
//  CheckInViewController.h
//  Prin Food
//
//  Created by Kirill Kudaev on 05.12.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "ProfilePictureButton.h"

@interface CheckInViewController : UIViewController

@property (nonatomic, strong) IBOutlet ProfilePictureButton *profilePictureButton;

- (IBAction)checkInDining:(id)sender;
- (IBAction)checkInPub:(id)sender;

@end