//
//  MWAppDelegate.h
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MWAppDelegate : NSObject <NSApplicationDelegate>


@property (weak) NSTimer *repeatingTimer;

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSColorWell *colorBox;
@property (weak) IBOutlet NSButton *btnHexColor;
@property (weak) IBOutlet NSButton *btnRgbColor;
@property (weak) IBOutlet NSView *drawBox;
@property (unsafe_unretained) IBOutlet NSTextView *debugTxt;

- (IBAction)startRepeatingTimer:sender;
- (IBAction)stopRepeatingTimer:sender;
- (void)targetMethod:(NSTimer*)theTimer;
- (IBAction)copyHtmlColor:(id)sender;
- (IBAction)copyCssRgbColor:(id)sender;
- (IBAction)toggleTopmost:(id)sender;

@end
