//
//  RegularLabel.m
//  Ninety Nine
//
//  Created by Matthew Mascioni on 2/16/2014.
//  Copyright (c) 2014 Matthew Mascioni. All rights reserved.
//

#import "RegularLabel.h"

@implementation RegularLabel

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title andSize:(CGFloat)size andCustomColor:(MMColors)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:size];
        self.textAlignment = NSTextAlignmentCenter;
        
        switch (color) {
            case MMGreen:
                self.textColor = [UIColor colorWithHue:0.261111111f saturation:0.37f brightness:0.9f alpha:1];
                break;
            case MMRed:
                self.textColor = [UIColor colorWithHue:1.0f saturation:0.6f brightness:0.9f alpha:1.0];
            default:
                break;
        }
    
        self.numberOfLines = 1;
        self.text = title;
    }
    return self;
}

@end
