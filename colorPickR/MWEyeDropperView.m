//
//  MWEyeDropperView.m
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 Max Weller. All rights reserved.
//

#import "MWEyeDropperView.h"
#import "MWGetScreenPixelColor.h"

@implementation MWEyeDropperView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
    }
    return self;
}


-(void)updateBitmapFromScreen:(CGDirectDisplayID)displayID atPos:(CGPoint)pos {
    nsBitmapImageRepObj = GetBitmapRectAtPoint(displayID, pos, 24, 24);
    
    
    [self setNeedsDisplay:YES];
    
} // end paintGradientBitmap

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    [NSGraphicsContext saveGraphicsState];
    
    if (nsBitmapImageRepObj != NULL) {
        [nsBitmapImageRepObj drawInRect:NSMakeRect(0, 0, 96, 96)];
    }
    
    [NSBezierPath fillRect:NSMakeRect(46, 0, 1, 96)];
    [NSBezierPath fillRect:NSMakeRect(50, 0, 1, 96)];
    [NSBezierPath fillRect:NSMakeRect(0, 46, 96, 1)];
    [NSBezierPath fillRect:NSMakeRect(0, 50, 96, 1)];
    
    [NSGraphicsContext restoreGraphicsState];
    
    // Drawing code here.
}


- (void)setUpGState {
    [super setUpGState];
    [[NSGraphicsContext currentContext] setImageInterpolation:
     NSImageInterpolationNone];
}

@end
