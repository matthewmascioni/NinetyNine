//
//  MMUptimeRobot.h
//  Ninety Nine
//
//  Created by Matthew Mascioni on 2/16/2014.
//  Copyright (c) 2014 Matthew Mascioni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMUptimeRobot : NSObject

- (id)initWithMonitorAPIKey:(NSString *)key;

+ (instancetype)connectionWithAPIKey:(NSString *)key;

- (BOOL)fetchInformationAboutMonitor;

@property (strong, nonatomic) NSString *monitorKey;
@property (strong, nonatomic) NSString *monitorName;
@property (strong, nonatomic) NSString *uptimeAverage;
@property (strong, nonatomic) NSString *lastDowntime;
@property (strong, nonatomic) NSString *lastDowntimeTime;

@end
