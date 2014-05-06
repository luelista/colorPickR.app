//
//  MWGetScreenPixelColor.h
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 Max Weller. All rights reserved.
//

#import <Foundation/Foundation.h>

CGPoint ConvertToCarbonScreenPoint(NSPoint cocoaPoint);
NSColor *GetColorAtMouse();
NSColor *GetColorAtScreenCoordinate(CGDirectDisplayID displayID, NSInteger x, NSInteger y);
Boolean isPressed( unsigned short inKeyCode );

