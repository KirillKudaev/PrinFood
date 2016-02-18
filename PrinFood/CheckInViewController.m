//
//  CheckInViewController.m
//  Prin Food
//
//  Created by Kirill Kudaev on 05.12.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import "CheckInViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface CheckInViewController ()

@end

@implementation CheckInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profilePictureButton.profileID = @"me";
    
    self.saveProfilePictureToParse;
    
    PFQuery *query = [PFQuery queryWithClassName:@"CheckIn"];
    [query whereKey:@"name" equalTo:[self userName]];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object == nil) {
            // User doesn't exist
            // NSLog(@"User exists");
            
            
            PFObject *checkIn = [PFObject objectWithClassName:@"CheckIn"];
            checkIn[@"name"] = [self userName];
            [checkIn saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                                        object:nil];
                } else {
                    // There was a problem, check error.description
                }
            }];
    
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // pictureCropping: The cropping to use for the profile picture.
    self.profilePictureButton.pictureCropping = FBSDKProfilePictureModeSquare;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkInDining:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                        object:nil];
    
    // Work in progress: FB profile pictures
    // UIImage *img = [self.profilePictureButton imageForState:UIControlStateNormal];
    // UIImage *image = self.profilePictureButton.currentImage;
    //NSString *userFBID = [FBSDKProfile currentProfile].linkURL;
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"CheckIn"];
    [query whereKey:@"name" equalTo:[self userName]];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object != nil) {
            // User exists
            // NSLog(@"User exists");
            
            
            PFQuery *query = [PFQuery queryWithClassName:@"CheckIn"];
            [query whereKey:@"name" equalTo:[self userName]];
            [query getFirstObjectInBackgroundWithBlock:^(PFObject * checkIn, NSError *error) {
                if (!error) {
                    // Found UserStats
                    [checkIn setObject: @"Dining" forKey:@"place"];
                    [checkIn setObject: [self currentDate] forKey:@"date"];
                    [checkIn setObject: [self currentTime] forKey:@"time"];
                    
                    // Save
                    [checkIn saveInBackground];
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                                        object:nil];
                } else {
                    // Did not find any UserStats for the current user
                    NSLog(@"Error: %@", error);
                }
            }];
        }
        else
        {
            // User doesn`t exist
            // NSLog(@"User doesn`t exist");
            
            PFObject *checkIn = [PFObject objectWithClassName:@"CheckIn"];
            checkIn[@"place"] = @"Dining";
            checkIn[@"date"] = [self currentDate];
            checkIn[@"time"] = [self currentTime];
            checkIn[@"name"] = [self userName];
            [checkIn saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                                        object:nil];
                } else {
                    // There was a problem, check error.description
                }
            }];
            
        }
        
    }];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                        object:nil];
    }

- (IBAction)checkInPub:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                        object:nil];
    
    PFQuery *query = [PFQuery queryWithClassName:@"CheckIn"];
    [query whereKey:@"name" equalTo:[self userName]];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object != nil) {
            // User exists
            // NSLog(@"User exists");
            
            
            PFQuery *query = [PFQuery queryWithClassName:@"CheckIn"];
            [query whereKey:@"name" equalTo:[self userName]];
            [query getFirstObjectInBackgroundWithBlock:^(PFObject * checkIn, NSError *error) {
                if (!error) {
                    // Found UserStats
                    
                    [checkIn setObject: @"Pub" forKey:@"place"];
                    [checkIn setObject: [self currentDate] forKey:@"date"];
                    [checkIn setObject: [self currentTime] forKey:@"time"];
                    
                    
                    // Save
                    [checkIn saveInBackground];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                                        object:nil];
                } else {
                    // Did not find any UserStats for the current user
                    NSLog(@"Error: %@", error);
                }
                
            }];
            
            
        }
        else
        {
            // User doesn`t exist
            // NSLog(@"User doesn`t exist");
            
            PFObject *checkIn = [PFObject objectWithClassName:@"CheckIn"];
            checkIn[@"place"] = @"Pub";
            checkIn[@"date"] = [self currentDate];
            checkIn[@"time"] = [self currentTime];
            checkIn[@"name"] = [self userName];
            [checkIn saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                                        object:nil];
                } else {
                    // There was a problem, check error.description
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                                    object:nil];

            }];

        }
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                        object:nil];
}

-(NSString *) currentDate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:@"EEEE, MMMM d"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

-(NSString *) currentTime{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:@"hh:mm a"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *)userName{
    NSString *name = [FBSDKProfile currentProfile].name;
    if (name == nil) {
        name = @"";
    }
    return name;
}

- (void)saveProfilePictureToParse{
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:[NSString stringWithFormat:@"me/picture?type=large&redirect=false"]
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        if (!error){
            //NSLog([result objectForKey:@"data"]);
            NSDictionary *dictionary = (NSDictionary *)result;
            NSDictionary *data = [dictionary objectForKey:@"data"];
            NSString *photoUrl = (NSString *)[data objectForKey:@"url"];
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: photoUrl]];
            
            // Convert to JPEG with 50% quality
            //NSData* data = UIImageJPEGRepresentation(imageView.image, 0.5f);
            PFFile *imageFile = [PFFile fileWithName:@"ProfilePicture.jpg" data:imageData];
            
                    
                PFQuery *queryPicture = [PFQuery queryWithClassName:@"CheckIn"];
                [queryPicture whereKey:@"name" equalTo:[self userName]];
                [queryPicture getFirstObjectInBackgroundWithBlock:^(PFObject * checkIn, NSError *error) {
                    if (!error) {
                        // Found UserStats
                        [checkIn setObject: imageFile forKey:@"profilePicture"];
                        // Save
                        [checkIn saveInBackground];
                            
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                                                object:nil];
                    } else {
                            // Did not find any UserStats for the current user
                            NSLog(@"Error: %@", error);
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"YourNotificationName"
                                                                        object:nil];
                }];
    }
        
        else {
            NSLog(@"result: %@",[error description]);
        }
    }
    ];

}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showLogIn"]){
        // NSLog(@"Segue identifier for showLogIn worked"); // For Testing.
        LoginViewController *scloginviewcontroller = [segue destinationViewController];
        
        scloginviewcontroller.profileIconPressed = YES;
    }
}


@end
