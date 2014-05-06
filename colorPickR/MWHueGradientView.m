//
//  MWHueGradientView.m
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 Max Weller. All rights reserved.
//

#import "MWHueGradientView.h"

@implementation MWHueGradientView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        nsBitmapImageRepObj = [[NSBitmapImageRep alloc]
                               initWithBitmapDataPlanes:NULL
                               pixelsWide:frame.size.width
                               pixelsHigh:frame.size.height
                               bitsPerSample:8
                               samplesPerPixel:3
                               hasAlpha:NO
                               isPlanar:NO
                               colorSpaceName:@"NSCalibratedRGBColorSpace"
                               bytesPerRow:0 
                               bitsPerPixel:0];
        
        [self paintGradientBitmap];
    }
    return self;
}

- (void) paintGradientBitmap {
    NSSize size = [nsBitmapImageRepObj size];
    
    CGFloat   zFloatX;
    for (int x = 0; x < size.width; x++) {
        zFloatX = (CGFloat)x / size.width;
        
        
        NSColor* color = [NSColor colorWithCalibratedHue:zFloatX saturation:1 brightness:1 alpha:1];
        
        for (int y = 0; y < size.height; y++) {
            [nsBitmapImageRepObj setColor:color atX:x y:y];
        } // end for x
        
    } // end for y
    
    
    [self setNeedsDisplay:YES];
    
} // end paintGradientBitmap

- (void) paintSaturationBitmap:(NSColor*)hueColor {
    NSSize size = [nsBitmapImageRepObj size];
    
    float hue = [hueColor hueComponent];
    sliderPos = [hueColor saturationComponent] * size.width;
    CGFloat   zFloatX;
    for (int x = 0; x < size.width; x++) {
        zFloatX = (CGFloat)x / size.width;
        
        
        NSColor* color = [NSColor colorWithCalibratedHue:hue saturation:zFloatX brightness:1 alpha:1];
        
        for (int y = 0; y < size.height; y++) {
            [nsBitmapImageRepObj setColor:color atX:x y:y];
        } // end for x
        
    } // end for y
    
    
    [self setNeedsDisplay:YES];
    
} // end paintGradientBitmap

- (void) paintBrightnessBitmap:(NSColor*)hueColor {
    NSSize size = [nsBitmapImageRepObj size];
    
    float hue = [hueColor hueComponent];
    sliderPos = [hueColor brightnessComponent] * size.width;
    CGFloat   zFloatX;
    for (int x = 0; x < size.width; x++) {
        zFloatX = (CGFloat)x / size.width;
        
        
        NSColor* color = [NSColor colorWithCalibratedHue:hue saturation:0 brightness:zFloatX alpha:1];
        
        for (int y = 0; y < size.height; y++) {
            [nsBitmapImageRepObj setColor:color atX:x y:y];
        } // end for x
        
    } // end for y
    
    
    [self setNeedsDisplay:YES];
    
} // end paintGradientBitmap



- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    [NSGraphicsContext saveGraphicsState];
    [nsBitmapImageRepObj drawAtPoint:NSMakePoint(0, 0)];
    //[nsBitmapImageRepObj drawInRect:dirtyRect];
    
    [NSBezierPath fillRect:NSMakeRect(sliderPos, 0, 1, dirtyRect.size.height)];
    
    [NSGraphicsContext restoreGraphicsState];
    
    // Drawing code here.
}

@end
