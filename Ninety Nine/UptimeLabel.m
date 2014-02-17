//
//  UptimeLabel.m
//  Ninety Nine
//
//  Created by Matthew Mascioni on 2/16/2014.
//  Copyright (c) 2014 Matthew Mascioni. All rights reserved.
//

#import "UptimeLabel.h"

@implementation UptimeLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:48.0f];
        self.contentScaleFactor = 0.6;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor colorWithHue:0.261111111f saturation:0.37f brightness:0.9f alpha:1];
        self.adjustsFontSizeToFitWidth = YES;
        self.numberOfLines = 1;
        [[self layer] setBorderWidth:7.5f];
        [[self layer] setBorderColor:[UIColor colorWithHue:0.333333333f saturation:0.4f brightness:0.6f alpha:1].CGColor];
        [[self layer] setCornerRadius:8.0f];

        
    }
    return self;
}

@end
