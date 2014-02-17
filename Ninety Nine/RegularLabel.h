//
//  RegularLabel.h
//  Ninety Nine
//
//  Created by Matthew Mascioni on 2/16/2014.
//  Copyright (c) 2014 Matthew Mascioni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegularLabel : UILabel

typedef NS_ENUM(NSUInteger, MMColors) {
    MMGreen = 1,
    MMRed = 2
};

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title andSize:(CGFloat)size andCustomColor:(MMColors)color;

@end
