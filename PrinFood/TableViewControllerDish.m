//
//  TableViewControllerDish.m
//  Prin Food
//
//  Created by Kirill Kudaev on 20.11.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import "TableViewControllerDish.h"
#import "TableCellDish.h"
#import <Parse/Parse.h>

@interface TableViewControllerDish ()

@end
  
@implementation TableViewControllerDish

- (void)viewDidLoad {
    [super viewDidLoad];

    // Populated from the database later in the program.
    _DishArray =  [NSMutableArray arrayWithObjects: @"Couldn't upload the menu", nil];
    
    // Diplays name of the meal in the navigation bar.
    self.navigationItem.title = _MealChosen;
    //NSLog(@"Date: %@", DateChosen); // Testing.
    
    PFQuery *queryDishes = [PFQuery queryWithClassName:@"Menu"];
    [queryDishes whereKey:@"date" equalTo: _DateChosen];
    [queryDishes whereKey:@"meal" equalTo: _MealChosen];
    // Sort by id. From lowest to highest.
    [queryDishes orderByAscending:@"idTemp"];
    
    [queryDishes findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            [_DishArray removeObjectAtIndex: 0];
            // NSLog(@"Successfully retrieved %lu object(s).", (unsigned long)objects.count);  //for testing
            
            for (PFObject *object in objects) {
                NSString *dish = object[@"dish"];
                [_DishArray addObject:dish];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self.tableView reloadData];
    }];
    // NSLog(@"Meal chosen: %@", _MealChosen);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_DishArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCellDish *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCellDish" forIndexPath:indexPath];
    long row = [indexPath row];
    cell.DishLabel.text = _DishArray[row];
    return cell;
}

@end
