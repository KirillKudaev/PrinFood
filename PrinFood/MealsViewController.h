//
//  ViewController.h
//  PrinFood
//
//  Created by Kirill Kudaev on 08.10.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UITableView *tableView;
    IBOutlet UISegmentedControl *segmentController;
}

- (IBAction)segmentButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *currentDateLabel;

// Array of meals. 3 elements: Breakfast, Lunch, Dinner.
@property (nonatomic, strong)  NSArray *MealArray;

// Array of times for each meal.
@property (nonatomic, strong)  NSMutableArray *TimeArray;

@end

