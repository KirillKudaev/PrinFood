//
//  PubHoursViewController.h
//  Prin Food
//
//  Created by Kirill Kudaev on 02.12.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PubHoursViewController : UIViewController {
    
    IBOutlet UISegmentedControl *segmentController;

}

- (IBAction)segmentButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *currentDateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *BehindDateImage;

@property (strong, nonatomic) IBOutlet UILabel *breakfastGrill;
@property (strong, nonatomic) IBOutlet UILabel *breakfastShake;
@property (strong, nonatomic) IBOutlet UILabel *lunchGrill;
@property (strong, nonatomic) IBOutlet UILabel *lunchShake;
@property (strong, nonatomic) IBOutlet UILabel *dinnerGrill;
@property (strong, nonatomic) IBOutlet UILabel *dinnerShake;

@property (nonatomic, strong)  NSArray *labelsArray;

@end