//
//  PubHoursViewController.m
//  Prin Food
//
//  Created by Kirill Kudaev on 02.12.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import "PubHoursViewController.h"
#import <Parse/Parse.h>

@interface PubHoursViewController ()

@end

@implementation PubHoursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _labelsArray = @[_breakfastGrill, _breakfastShake,
                     _lunchGrill, _lunchShake,
                     _dinnerGrill, _dinnerShake];
    
    for (UILabel *object in _labelsArray) {
        object.text = @"Couldn't upload time";
    }
    
    // Displays current date.
    _currentDateLabel.text = [self currentDate];
    
    [self queryMealTimes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) queryMealTimes{
    
    NSString *dayOfWeek = @"";
    // Sets day of week depending on user's choice.
    if (segmentController.selectedSegmentIndex == 0) {
        dayOfWeek = [self currentDayOfWeek];
    } else if (segmentController.selectedSegmentIndex == 1){
        dayOfWeek = [self nextDayOfWeek];
    }
    
    // Gets time for breakfast.
    PFQuery *queryBreakfast = [PFQuery queryWithClassName:@"PubTimes"];
    [queryBreakfast whereKey:@"dayOfWeek" equalTo: dayOfWeek];
    [queryBreakfast whereKey:@"meal" equalTo: @"Breakfast"];
    [queryBreakfast findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // NSLog(@"Successfully retrieved %lu object(s).", (unsigned long)objects.count);  // Testing.
            for (PFObject *object in objects) {
                NSString *timeGrill = object[@"timeGrill"];
                _breakfastGrill.text = timeGrill;
                NSString *timeShake = object[@"timeShake"];
                _breakfastShake.text = timeShake;
                
            }
        } else {
            // Log details of the failure.
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *queryLunch = [PFQuery queryWithClassName:@"PubTimes"];
    [queryLunch whereKey:@"dayOfWeek" equalTo: dayOfWeek];
    [queryLunch whereKey:@"meal" equalTo: @"Lunch"];
    [queryLunch findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // NSLog(@"Successfully retrieved %lu object(s).", (unsigned long)objects.count);  // Testing.
            for (PFObject *object in objects) {
                NSString *timeGrill = object[@"timeGrill"];
                _lunchGrill.text = timeGrill;
                NSString *timeShake = object[@"timeShake"];
                _lunchShake.text = timeShake;
                
            }
        } else {
            // Log details of the failure.
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *queryDinner = [PFQuery queryWithClassName:@"PubTimes"];
    [queryDinner whereKey:@"dayOfWeek" equalTo: dayOfWeek];
    [queryDinner whereKey:@"meal" equalTo: @"Dinner"];
    [queryDinner findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // NSLog(@"Successfully retrieved %lu object(s).", (unsigned long)objects.count);  // Testing.
            for (PFObject *object in objects) {
                NSString *timeGrill = object[@"timeGrill"];
                _dinnerGrill.text = timeGrill;
                NSString *timeShake = object[@"timeShake"];
                _dinnerShake.text = timeShake;
                
            }
        } else {
            // Log details of the failure.
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


-(NSString *) currentDate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMMM d"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

-(NSString *) nextDate{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMMM d"];
    
    return [dateFormatter stringFromDate: nextDate];
}

-(NSString *) currentDayOfWeek{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    return [dateFormatter stringFromDate: [NSDate date]];
}

-(NSString *) nextDayOfWeek{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDay = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    return [dateFormatter stringFromDate: nextDay];
}

- (IBAction)segmentButton:(id)sender {
    if (segmentController.selectedSegmentIndex == 0) {
        // Today was chosen.
        _currentDateLabel.text = [self currentDate];
        // Refresh the table.
        [self queryMealTimes];
    } else if (segmentController.selectedSegmentIndex == 1){
        // Tomorrow was chosen.
        _currentDateLabel.text = [self nextDate];
        // Refresh the table.
        [self queryMealTimes];
    }
}

@end
