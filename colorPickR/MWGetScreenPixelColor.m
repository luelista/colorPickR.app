//
//  MWGetScreenPixelColor.m
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 Max Weller. All rights reserved.
//

#import "MWGetScreenPixelColor.h"
#include <Carbon/Carbon.h>

CGPoint ConvertToCarbonScreenPoint(NSPoint cocoaPoint) {
    NSScreen* foundScreen = nil;
    NSRect screenFrame;
    for (NSScreen* screen in [NSScreen screens]) {
        screenFrame = [screen frame];
        if (NSPointInRect(cocoaPoint, screenFrame)) {
            foundScreen = screen;
            break;
        }
    }
    if (! foundScreen) return CGPointMake(0.0, 0.0);
    return CGPointMake(cocoaPoint.x,
            screenFrame.origin.y + screenFrame.size.height - cocoaPoint.y);
}

NSColor *GetColorAtMouse() {
    // Grab the current mouse location.
    NSPoint mouseLoc = [NSEvent mouseLocation];
    
    //yippie: NSEvent calculates y position from bottom, CGRect from top :)
    NSRect screenRect = [[NSScreen mainScreen] frame];
    NSInteger height = screenRect.size.height;
    NSInteger yPos = height - mouseLoc.y;
    
    // Grab the display for said mouse location.
    uint32_t count = 0;
    CGDirectDisplayID displayForPoint;
    if (CGGetDisplaysWithPoint(NSPointToCGPoint(mouseLoc), 1, &displayForPoint, &count) != kCGErrorSuccess)
    {
        NSLog(@"Oops.");
        return 0;
    }
   // NSLog(@"Mouse pos: %f, %f, %d, %d", mouseLoc.x, mouseLoc.y, (int)mouseLoc.x, (int)mouseLoc.y);
    return GetColorAtScreenCoordinate(displayForPoint, mouseLoc.x, yPos);
}

NSColor *GetColorAtScreenCoordinate(CGDirectDisplayID displayID, NSInteger x, NSInteger y) {

    // Grab the color on said display at said mouse location.
    CGImageRef image = CGDisplayCreateImageForRect(displayID, CGRectMake(x, y, 1, 1));
    NSBitmapImageRep* bitmap = [[NSBitmapImageRep alloc] initWithCGImage:image];
    CGImageRelease(image);
    NSColor* color = [bitmap colorAtX:0 y:0];
    NSLog(@"%@", color);
    //[bitmap release];
    
    return color;
}

Boolean isPressed( unsigned short inKeyCode )
{
    unsigned char keyMap[16];
    GetKeys((BigEndianUInt32*) &keyMap);
    return (0 != ((keyMap[ inKeyCode >> 3] >> (inKeyCode & 7)) & 1));
}
