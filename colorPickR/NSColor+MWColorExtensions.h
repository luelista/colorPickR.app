//
//  NSObject+MWColorExtensions.h
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 Max Weller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSColor (MWColorExtensions)

- (NSString *)toHtmlColorString;
- (NSString *)toCssRgbString;

@end
