//
//  NSObject+MWColorExtensions.m
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 Max Weller. All rights reserved.
//

#import "NSColor+MWColorExtensions.h"

@implementation NSColor (MWColorExtensions)

- (NSString *)toHtmlColorString
{
    CGFloat red, green, blue;
    [[self colorUsingColorSpaceName: NSCalibratedRGBColorSpace]
     getRed: &red green: &green blue: &blue alpha: nil];
    
    return [NSString stringWithFormat: @"%02X%02X%02X", (unsigned)(red*255),
            (unsigned)(green*255), (unsigned)(blue*255)];
}


- (NSString *)toCssRgbString
{
    CGFloat red, green, blue;
    [[self colorUsingColorSpaceName: NSCalibratedRGBColorSpace]
     getRed: &red green: &green blue: &blue alpha: nil];
    
    return [NSString stringWithFormat: @"rgb(%d, %d, %d)", (unsigned)(red*255),
            (unsigned)(green*255), (unsigned)(blue*255)];
}

@end
