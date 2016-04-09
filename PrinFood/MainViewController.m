//
//  MainViewController.m
//  Prin Food
//
//  Created by Kirill Kudaev on 26.11.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
//  #import <Parse/Parse.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // profileID: The Facebook ID of the user, place or object for which a picture should be fetched and displayed.
    self.profilePictureButton.profileID = @"me";
   
//    Testig Push Notifications
//    PFQuery *pushQuery = [PFInstallation query];
//    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
//    
//    // Send push notification to query
//    [PFPush sendPushMessageToQueryInBackground:pushQuery
//                                   withMessage:@"Hello World!"];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // pictureCropping: The cropping to use for the profile picture.
    self.profilePictureButton.pictureCropping = FBSDKProfilePictureModeSquare;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showLogIn"]){
        // NSLog(@"Segue identifier for showLogIn worked"); // For Testing.
        LoginViewController *scloginviewcontroller = [segue destinationViewController];
        
        scloginviewcontroller.profileIconPressed = YES;
    }else if ([[segue identifier] isEqualToString:@"checkIn"]){
        NSString *name = [FBSDKProfile currentProfile].name;
        if (name == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:@"Please log in with Facebook"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
            [self performSegueWithIdentifier:@"showLogIn" sender:self];
        }
    }
}

@end
