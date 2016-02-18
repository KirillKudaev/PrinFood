//
//  FriendsCheckInTableViewController.m
//  Prin Food
//
//  Created by Kirill Kudaev on 06.12.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import "FriendsCheckInTableViewController.h"
#import "FriendsCheckInTableViewCell.h"
#import <Parse/Parse.h>

@interface FriendsCheckInTableViewController ()

@end

@implementation FriendsCheckInTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable:)
                                                 name:@"YourNotificationName"
                                               object:nil];
    
    _friendsArray = [NSMutableArray arrayWithObjects:
                    @"Couldn't upload friends", nil];
    _placesArray =[NSMutableArray arrayWithObjects:
                   @"", nil];

    _timesArray =[NSMutableArray arrayWithObjects:
                  @"", nil];
    _imagesArray = [NSMutableArray arrayWithObjects:
                  @"", nil];

    // NSLog([self currentAMorPM]);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self getFriendsInTable];
}

- (void)reloadTable:(NSNotification *)notif {
    [self getFriendsInTable];
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
    return _friendsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsCheckInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    int row = [indexPath row];
    cell.UserLabel.text = _friendsArray[row];
    cell.PlaceLabel.text = _placesArray[row];
    cell.TimeLabel.text = _timesArray[row];
    
//    if (_imagesArray != nil) {
//        cell.ProfileImage.image = _imagesArray[row];
//    }
    
    return cell;
}


- (void) getFriendsInTable{
    PFQuery *queryFriends = [PFQuery queryWithClassName:@"CheckIn"];
    [queryFriends whereKey:@"date" equalTo: [self currentDate]];
    // SORT BY TIMES IN THE FUTURE
    //[queryDishes orderByAscending:@"idTemp"];
    
    [queryFriends findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            // Remove "Couldn't upload" label
            [_friendsArray removeAllObjects];
            [_placesArray removeAllObjects];
            [_timesArray removeAllObjects];
            [self.tableView reloadData];
            // NSLog(@"Successfully retrieved %lu object(s).", (unsigned long)objects.count);  //for testing
            
            for (PFObject *object in objects) {
                
                NSString *time = object[@"time"];
                NSInteger hour = [[time substringWithRange:NSMakeRange(0,2)] intValue];
                NSString *AMorPM = [time substringWithRange:NSMakeRange(6,2)];
                
                // Display if user checked in in last ~2 hours // We have to change this part
                if ( ((hour == [self currentHour]) || (hour == [self currentHour] - 1)) && (AMorPM == [self currentAMorPM])) {
                    NSString *name = object[@"name"];
                    [_friendsArray addObject:name];
                    NSString *place = object[@"place"];
                    [_placesArray addObject:place];
                    [_timesArray addObject:time];
                    
                    PFFile *imageFile = object[@"profilePicture"];
                    
                    [_imagesArray addObject: imageFile];
                    
                    [self.tableView reloadData];


                }
            }
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
}



-(NSString *) currentDate {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:@"EEEE, MMMM d"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

-(NSInteger) currentHour {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:@"hh"];
    return [[dateFormatter stringFromDate:[NSDate date]] intValue];
}

-(NSString *) currentAMorPM {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:@"a"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UI
 *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
