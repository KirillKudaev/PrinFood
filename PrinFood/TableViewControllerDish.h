//
//  TableViewControllerDish.h
//  Prin Food
//
//  Created by Kirill Kudaev on 20.11.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewControllerDish : UITableViewController

// Array of dishes.
@property (nonatomic, strong)  NSMutableArray *DishArray;

// Either "Breakfast", "Lunch" or "Dinner". Depends which row was chosen in a previous view.
@property (strong, nonatomic) NSString *MealChosen;

// Date that was chosen by user.
@property (strong, nonatomic) NSString *DateChosen;

@end
