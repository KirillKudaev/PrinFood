//
//  FriendsCheckInTableViewCell.h
//  Prin Food
//
//  Created by Kirill Kudaev on 06.12.15.
//  Copyright © 2015 Kirill Kudaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsCheckInTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *UserLabel;
@property (strong, nonatomic) IBOutlet UILabel *PlaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *TimeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ProfileImage;


@end
