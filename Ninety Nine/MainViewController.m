//
//  MainViewController.m
//  Ninety Nine
//
//  Created by Matthew Mascioni on 2/16/2014.
//  Copyright (c) 2014 Matthew Mascioni. All rights reserved.
//

#import "MainViewController.h"
#import "RegularLabel.h"
#import "MMUptimeRobot.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData:) name:@"UptimeMonitorDataReady" object:nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.25f alpha:1];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:22.0f], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.20f alpha:1];
    
    [self designSubviews];
    
    self.robot = [MMUptimeRobot connectionWithAPIKey:@"YOUR MONITOR-SPECIFIC API KEY HERE"];
    BOOL success = [self.robot fetchInformationAboutMonitor];
    
    if (!success) {
        NSLog(@"Woop. Someone killed the internet. Do UI things and make things blow up.");
    }
}

- (void)designSubviews {
    self.uptimeLabel = [[UptimeLabel alloc] initWithFrame:CGRectMake(52.5f, 131.5f, 215.0f, 112.0f)];
    [self.view addSubview:self.uptimeLabel];
    
    self.uptimeTitle = [[RegularLabel alloc] initWithFrame:CGRectOffset(self.uptimeLabel.frame, 0, -90) andTitle:@"UPTIME" andSize:18.0f andCustomColor:MMGreen];
    [self.view addSubview:self.uptimeTitle];
    
    self.downtimeTitle = [[RegularLabel alloc] initWithFrame:CGRectOffset(self.uptimeLabel.frame, 0, 99) andTitle:@"LAST RECORDED DOWNTIME" andSize:18.0f andCustomColor:MMRed];
    [self.view addSubview:self.downtimeTitle];
    
    self.downtimeDetail = [[RegularLabel alloc] initWithFrame:CGRectOffset(self.downtimeTitle.frame, 0, 30) andTitle:@"" andSize:15.0f andCustomColor:MMRed];
    [self.view addSubview:self.downtimeDetail];
    
    self.downtimeTime = [[RegularLabel alloc] initWithFrame:CGRectOffset(self.downtimeDetail.frame, 0, 30) andTitle:@"" andSize:15.0f andCustomColor:MMRed];
    [self.view addSubview:self.downtimeTime];
}

- (void)updateData:(NSNotification *)sender {
    NSLog(@"Got notification!");
    NSLog(@"%@", self.robot.uptimeAverage);
    self.uptimeLabel.text = [self.robot.uptimeAverage stringByAppendingString:@"%"];
    self.navigationItem.title = self.robot.monitorName;
    self.downtimeDetail.text = self.robot.lastDowntime;
    self.downtimeTime.text = self.robot.lastDowntimeTime;
}

@end
