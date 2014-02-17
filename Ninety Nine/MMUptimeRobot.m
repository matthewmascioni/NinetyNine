//
//  MMUptimeRobot.m
//  Ninety Nine
//
//  Created by Matthew Mascioni on 2/16/2014.
//  Copyright (c) 2014 Matthew Mascioni. All rights reserved.
//

#import "MMUptimeRobot.h"

@implementation MMUptimeRobot

- (id)initWithMonitorAPIKey:(NSString *)key {
    self = [super init];
    
    if (self) {
        self.monitorKey = key;
    }
    
    return self;
}

+ (instancetype)connectionWithAPIKey:(NSString *)key {
    MMUptimeRobot *robot = [[MMUptimeRobot alloc] initWithMonitorAPIKey:key];
    return robot;
}

- (BOOL)fetchInformationAboutMonitor {
    NSURLSession *session = [NSURLSession sharedSession];
    
    __block NSInteger code;
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.uptimerobot.com/getMonitors?apiKey=%@&format=json&logs=1", self.monitorKey]] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *responseCode = (NSHTTPURLResponse *)response;
        code = [responseCode statusCode];
        
        if (code == 200) {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[self cleanGarbageAndReturnValidJSONFromBadJSON:location] options:NSJSONReadingAllowFragments error:&error];
            
            self.uptimeAverage = [self getInfoWithName:@"alltimeuptimeratio" fromSource:dataDictionary];
            self.monitorName = [self getInfoWithName:@"friendlyname" fromSource:dataDictionary];
            
            NSDateFormatter *initialFormatter = [[NSDateFormatter alloc] init];
            [initialFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
            
            NSDate *backUp = [initialFormatter dateFromString: [self getLogAtIndex:0 fromSource:dataDictionary]];
            NSDate *wasDown = [initialFormatter dateFromString:[self getLogAtIndex:1 fromSource:dataDictionary]];
        
            self.lastDowntime = [self formatPrettyDateFromUglyOne:wasDown];
            self.lastDowntimeTime = [self computeMinutesBetweenDates:backUp andEndDate:wasDown];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (code == 200) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UptimeMonitorDataReady" object:nil];
            }
        });
    }];
    
    [task resume];
    
    if (code != 200) {
        return false;
    }
    
    return true;
}

#pragma mark - Internal Convenience Methods WARNING UGLY CODE AHEAD DO NOT WANT

- (NSData *)cleanGarbageAndReturnValidJSONFromBadJSON:(NSURL *)badJSON {
    NSError *error;
    
    NSString *badString = [NSString stringWithContentsOfURL:badJSON encoding:NSUTF8StringEncoding error:&error];
    NSString *removeFirstGarbage = [badString stringByReplacingOccurrencesOfString:@"jsonUptimeRobotApi(" withString:@""];
    NSString *removeSecondGarbage = [removeFirstGarbage stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    return [removeSecondGarbage dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSArray *)monitorDetailArrayFromSource:(NSDictionary *)sourceDictionary {
    return [[sourceDictionary objectForKey:@"monitors"] objectForKey:@"monitor"];
}

- (NSString *)getLogAtIndex:(NSUInteger)index fromSource:(NSDictionary *)sourceDictionary {
    return [[[[[self monitorDetailArrayFromSource:sourceDictionary] valueForKey:@"log"] objectAtIndex:0] valueForKey:@"datetime"] objectAtIndex:index];
}

- (NSString *)getInfoWithName:(NSString *)name fromSource:(NSDictionary *)sourceDictionary {
    return [[[self monitorDetailArrayFromSource:sourceDictionary] valueForKey:name] objectAtIndex:0];
}

- (NSString *)formatPrettyDateFromUglyOne:(NSDate *)uglyDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm:ss a"];
    return [dateFormatter stringFromDate:uglyDate];
}

- (NSString *)computeMinutesBetweenDates:(NSDate *)startDate andEndDate:(NSDate *)endDate {
    NSTimeInterval between = [startDate timeIntervalSinceDate:endDate];
    NSInteger timeBetween = between / 60;
    
    return [NSString stringWithFormat:@"For %ld minutes", (long)timeBetween];
}


@end
