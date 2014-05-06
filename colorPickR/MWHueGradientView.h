//
//  MWHueGradientView.h
//  colorPickR
//
//  Created by Max Weller on 06.05.14.
//  Copyright (c) 2014 Max Weller. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MWHueGradientView : NSView {
    
    NSBitmapImageRep         *   nsBitmapImageRepObj;
}

-(void)paintGradientBitmap;
@end
