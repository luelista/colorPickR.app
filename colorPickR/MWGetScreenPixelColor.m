//
//  MWGetScreenPixelColor.m
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 Max Weller. All rights reserved.
//

#import "MWGetScreenPixelColor.h"
#import "NSScreen+MWScreenPointConversion.h"
#include <Carbon/Carbon.h>

CGPoint GetMouseLocation() {
    // Grab the current mouse location.
    NSPoint ns_mouseLoc = [NSEvent mouseLocation];
    
    //yippie: NSEvent calculates y position from bottom, CGRect from top :)
    CGPoint mouseLoc = [NSScreen carbonPointFrom:ns_mouseLoc];
    
    return mouseLoc;
}

bool GetDisplayMouseLocation(CGDirectDisplayID* displayID, CGPoint* mouseLocation) {
    CGPoint mouseLoc = GetMouseLocation();
    
    // Grab the display for said mouse location.
    uint32_t count = 0;
    if (CGGetDisplaysWithPoint(mouseLoc, 1, displayID, &count) != kCGErrorSuccess)
    {
        NSLog(@"Oops.");
        return FALSE;
    }
    
    CGRect bounds = CGDisplayBounds(*displayID);
    
    mouseLocation->x = mouseLoc.x - bounds.origin.x;
    mouseLocation->y = mouseLoc.y - bounds.origin.y;
    return TRUE;
}

NSColor *GetColorAtMouse() {
    CGPoint mouseLoc;
    CGDirectDisplayID displayForPoint;
    
    if (GetDisplayMouseLocation(&displayForPoint, &mouseLoc)) {
    // NSLog(@"Mouse pos: %f, %f, %d, %d", mouseLoc.x, mouseLoc.y, (int)mouseLoc.x, (int)mouseLoc.y);
        return GetColorAtScreenCoordinate(displayForPoint, mouseLoc);
    } else {
        return NULL;
    }
}

NSImage *GetRectAtPoint(CGDirectDisplayID displayID, CGPoint location, int width, int height) {
    
    CGImageRef image = CGDisplayCreateImageForRect(displayID, CGRectMake(location.x-(width/2), location.y-(height/2), width, height));
    NSImage* bitmap = [[NSImage alloc] initWithCGImage:image size:NSMakeSize(width*3, height*3)];
    CGImageRelease(image);
    
    return bitmap;
}

NSBitmapImageRep *GetBitmapRectAtPoint(CGDirectDisplayID displayID, CGPoint location, int width, int height) {
    
    CGImageRef image = CGDisplayCreateImageForRect(displayID, CGRectMake(location.x-(width/2), location.y-(height/2), width, height));
    NSBitmapImageRep* bitmap = [[NSBitmapImageRep alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return bitmap;
}

NSColor *GetColorAtScreenCoordinate(CGDirectDisplayID displayID, CGPoint location) {

    // Grab the color on said display at said mouse location.
    CGImageRef image = CGDisplayCreateImageForRect(displayID, CGRectMake(location.x, location.y, 1, 1));
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
