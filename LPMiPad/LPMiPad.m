#import "LPMiPad.h"

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation lpmipad
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return [UIColor yellowColor];
}

- (BOOL)isSelected {
	if ([objc_getClass("_CDBatterySaver") batterySaver]) {
		self.lpmipad = FALSE;
	}	else
		self.lpmipad = TRUE;
	} 
	return self.autoBrightness;
}

-(void)setLowPowerMode:(BOOL) isOn {
    _CDBatterySaver *batterySaver = [objc_getClass("_CDBatterySaver") batterySaver];
    int nextState;

    if(isOn) {
        nextState = 1;
    } else {
        nextState = 0;
    }

    if([batterySaver setMode:nextState]) {
        NSLog(@"Set power mode state");
    }
}
@end
