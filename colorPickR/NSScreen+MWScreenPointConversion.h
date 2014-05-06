//
//  NSScreen+MWScreenPointConversion.h
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 Max Weller. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSScreen (MWScreenPointConversion)
+ (NSScreen*) screenWithPoint: (NSPoint) p;
+ (NSScreen*) screenWithMenuBar;
+ (float) menuScreenHeight;
+ (CGPoint) carbonPointFrom: (NSPoint) cocoaPoint;
+ (NSPoint) cocoaPointFrom: (CGPoint) carbonPoint;

@end
