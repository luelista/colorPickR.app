//
//  MWGetScreenPixelColor.h
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 Max Weller. All rights reserved.
//

#import <Foundation/Foundation.h>


bool GetDisplayMouseLocation(CGDirectDisplayID* displayID, CGPoint* mouseLocation);
NSColor *GetColorAtMouse();

NSImage *GetRectAtPoint(CGDirectDisplayID displayID, CGPoint location, int width, int height);
NSBitmapImageRep *GetBitmapRectAtPoint(CGDirectDisplayID displayID, CGPoint location, int width, int height);

NSColor *GetColorAtScreenCoordinate(CGDirectDisplayID displayID, CGPoint location);
Boolean isPressed( unsigned short inKeyCode );

