//
//  MainViewController.h
//  Ninety Nine
//
//  Created by Matthew Mascioni on 2/16/2014.
//  Copyright (c) 2014 Matthew Mascioni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UptimeLabel.h"

@class RegularLabel;
@class MMUptimeRobot;

@interface MainViewController : UIViewController

@property (strong, nonatomic) UptimeLabel *uptimeLabel;
@property (strong, nonatomic) RegularLabel *uptimeTitle;
@property (strong, nonatomic) RegularLabel *downtimeTitle;
@property (strong, nonatomic) RegularLabel *downtimeDetail;
@property (strong, nonatomic) RegularLabel *downtimeTime;

@property (strong, nonatomic) MMUptimeRobot *robot;

@end
