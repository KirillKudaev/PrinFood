//
//  ViewController.m
//  PrinFood
//
//  Created by Kirill Kudaev on 08.10.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import "MealsViewController.h"
#import "TableCellMeal.h"
#import "TableViewControllerDish.h"
#import <Parse/Parse.h>

@interface MealsViewController ()

@end

@implementation MealsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Disables table from scrolling.
    tableView.scrollEnabled = NO;
    
    // Displays current date.
    _currentDateLabel.text = [self currentDate];
    
    // Array of meals.
    _MealArray = @[@"Breakfast",
                   @"Lunch",
                   @"Dinner"];
    
    // Populated from the database later in the program.
    _TimeArray = [NSMutableArray arrayWithObjects:
                  @"Couldn't download time",
                  @"Couldn't download time",
                  @"Couldn't download time", nil];
    
    // Populates array of times from the database.
    [self queryMealTimes];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_MealArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCellMeal *cell = [tableView dequeueReusableCellWithIdentifier:@"mealCell"];
    int row = [indexPath row];
    // Displays names of meals in the cells.
    cell.MealLabel.text = _MealArray[row];
    // Displays times of meals in the cells.
    cell.TimeLabel.text = _TimeArray[row];
    
    return cell;
}

// For cell to be deselected after it was selected (so that it isn't higlighted when user comes back to the menu).
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [[UIDevice currentDevice] platformString] // We can put condition for each iphone model so we return different row heights
    
    
    
    return (self.view.frame.size.height - 200) / 3;
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
    PFQuery *queryBreakfast = [PFQuery queryWithClassName:@"MealTimes"];
    [queryBreakfast whereKey:@"dayOfWeek" equalTo: dayOfWeek];
    [queryBreakfast whereKey:@"meal" equalTo: @"Breakfast"];
    [queryBreakfast findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // NSLog(@"Successfully retrieved %lu object(s).", (unsigned long)objects.count);  // Testing.
            for (PFObject *object in objects) {
                NSString *timeOfMeal = object[@"time"];
                [_TimeArray replaceObjectAtIndex:0 withObject: timeOfMeal];
                // Updates the table.
                [tableView reloadData];
            }
        } else {
            // Log details of the failure.
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *queryLunch = [PFQuery queryWithClassName:@"MealTimes"];
    [queryLunch whereKey:@"dayOfWeek" equalTo: dayOfWeek];
    [queryLunch whereKey:@"meal" equalTo: @"Lunch"];
    [queryLunch findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // NSLog(@"Successfully retrieved %lu object(s).", (unsigned long)objects.count);  // Testing.
            for (PFObject *object in objects) {
                NSString *timeOfMeal = object[@"time"];
                [_TimeArray replaceObjectAtIndex:1 withObject: timeOfMeal];
                // Updates the table.
                [tableView reloadData];
            }
        } else {
            // Log details of the failure.
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *queryDinner = [PFQuery queryWithClassName:@"MealTimes"];
    [queryDinner whereKey:@"dayOfWeek" equalTo: dayOfWeek];
    [queryDinner whereKey:@"meal" equalTo: @"Dinner"];
    [queryDinner findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // NSLog(@"Successfully retrieved %lu object(s).", (unsigned long)objects.count);  // Testing.
            for (PFObject *object in objects) {
                NSString *timeOfMeal = object[@"time"];
                [_TimeArray replaceObjectAtIndex:2 withObject: timeOfMeal];
                // Updates the table.
                [tableView reloadData];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)segmentButton:(id)sender {
    if (segmentController.selectedSegmentIndex == 0) {
        // Today was chosen.
        segmentController.backgroundColor = [UIColor colorWithRed:170.0/255.0f green:192.0/255.0f blue:222.0/255.0f alpha:1.0];
        _BehindDateImage.backgroundColor = [UIColor colorWithRed:170.0/255.0f green:192.0/255.0f blue:222.0/255.0f alpha:1.0];
        _currentDateLabel.text = [self currentDate];
        // Refresh the table.
        [self queryMealTimes];
    } else if (segmentController.selectedSegmentIndex == 1){
        // Tomorrow was chosen.
        segmentController.backgroundColor = [UIColor colorWithRed:170.0/255.0f green:210.0/255.0f blue:255.0/255.0f alpha:1.0];
        _BehindDateImage.backgroundColor = [UIColor colorWithRed:170.0/255.0f green:210.0/255.0f blue:255.0/255.0f alpha:1.0];
        _currentDateLabel.text = [self nextDate];
        // Refresh the table.
        [self queryMealTimes];
    }
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"ShowMenu"]){
    
        TableViewControllerDish *tableviewcontrollerdish = [segue destinationViewController];
        NSIndexPath *myIndexPath = [tableView indexPathForSelectedRow];
        int row = [myIndexPath row];
        
        // Either "Breakfast", "Lunch" or "Dinner". Depends which row was chosen in a view.
        tableviewcontrollerdish.MealChosen = _MealArray[row];
        
        if (segmentController.selectedSegmentIndex == 0) {
            // Today was chosen.
            tableviewcontrollerdish.DateChosen = [self currentDate];
        } else if (segmentController.selectedSegmentIndex == 1){
            // Tomorrow was chosen.
            tableviewcontrollerdish.DateChosen = [self nextDate];
        }
    }
}

@end














