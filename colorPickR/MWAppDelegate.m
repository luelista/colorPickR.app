//
//  MWAppDelegate.m
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "MWAppDelegate.h"
#import "MWGetScreenPixelColor.h"
#include <Carbon/Carbon.h>
//#import "NSColor_MWColorExtensions.h"
#import "NSColor+MWColorExtensions.h"
#import "NSScreen+MWScreenPointConversion.h"

@implementation MWAppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self startRepeatingTimer:self];
    //[self.drawBox ]
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return TRUE;
}

- (IBAction)startRepeatingTimer:sender {
    
    // Cancel a preexisting timer.
    [self.repeatingTimer invalidate];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                      target:self selector:@selector(targetMethod:)
                                                    userInfo:NULL repeats:YES];
    self.repeatingTimer = timer;
}

- (void)targetMethod:(NSTimer*)theTimer {
    //NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    //NSLog(@"Timer started on %@", startDate);
    
    Boolean key = isPressed(kVK_Command);
    Boolean key2 = isPressed(kVK_Control);
    //NSLog(@"Command pressed? %d", key);
    
    if (key == 1 && key2 == 1) {
        CGPoint mouseLoc;
        CGDirectDisplayID display;
        if (GetDisplayMouseLocation(&display, &mouseLoc)) {
            
            NSColor* color = GetColorAtScreenCoordinate(display, mouseLoc);
            [self.colorBox setColor:color];
            [self onColorChange];
            /*NSImage* bitmap = GetRectAtPoint(display, mouseLoc, 34, 34);
            [bitmap lockFocus];
            [bitmap unlockFocus];
            //NSImage * img = [[NSImage alloc] initWi]
            [self.envImage setImage:bitmap];*/
            
            [self.envImage updateBitmapFromScreen:display atPos:mouseLoc];
        }
        [self debugOut];
    }
    
    
}

-(void)onColorChange {
    NSColor* color = [self.colorBox color];
    
    [self.btnHexColor setTitle:[color toHtmlColorString]];
    [self.btnRgbColor setTitle:[color toCssRgbString]];
    
    [self.gradSaturation paintSaturationBitmap:color];
    [self.gradBrightness paintBrightnessBitmap:color];
    
}

- (IBAction)copyHtmlColor:(id)sender {
    NSString * stringToWrite = [self.btnHexColor title];
    NSPasteboard* pb = [NSPasteboard generalPasteboard];
    [pb clearContents];
    [pb writeObjects:[NSArray arrayWithObject:stringToWrite]];
}

- (IBAction)copyCssRgbColor:(id)sender {
    NSString * stringToWrite = [self.btnRgbColor title];
    NSPasteboard* pb = [NSPasteboard generalPasteboard];
    [pb clearContents];
    [pb writeObjects:[NSArray arrayWithObject:stringToWrite]];
}

- (IBAction)toggleTopmost:(id)sender {
    
    if ([self.topmostBtn state] == NO) {
        [self.topmostBtn setState:YES];
        [self.topmostMenu setState:YES];
        [[self window] setLevel:NSFloatingWindowLevel];
    } else {
        [self.topmostBtn setState:NO];
        [self.topmostMenu setState:NO];
        [[self window] setLevel:NSNormalWindowLevel];
    }
}

- (IBAction)toggleDebugview:(id)sender {
    NSRect size = [[self window] frame];
    size.size.height = size.size.height < 300 ? 380 : 195;
    [[self window] setFrame:size display:true];
}

- (void)debugOut {
    // Grab the current mouse location.
    NSPoint mouseLoc = [NSEvent mouseLocation];
    CGPoint pt2 = [NSScreen carbonPointFrom:mouseLoc];
    
    // Grab the display for said mouse location.
    uint32_t count = 0;
    CGDirectDisplayID displayForPoint;
    if (CGGetDisplaysWithPoint(pt2, 1, &displayForPoint, &count) != kCGErrorSuccess)
    {
        NSLog(@"Oops.");
        
    }
    
    //CGPoint pt = ConvertToCarbonScreenPoint(mouseLoc);
    
    NSString* debug = [NSString stringWithFormat:@"mouseLoc: %d x %d\ncarbon mouseLoc 2: %d x %d\n\ndisplayId: %d",
                       (int)mouseLoc.x, (int)mouseLoc.y, (int)pt2.x, (int)pt2.y,
                        (int)displayForPoint];
    
    [self.debugTxt setString:debug];

}

@end
