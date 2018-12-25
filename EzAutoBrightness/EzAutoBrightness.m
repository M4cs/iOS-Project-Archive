#import "EzAutoBrightness.h"

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzAutoBrightness
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return [UIColor yellowColor];
}

- (BOOL)isSelected {
	if ([objc_getClass("PSBrightnessSettingsDetail") autoBrightnessEnabled]) {
		self.autoBrightness = FALSE;
	}	else
		self.autoBrightness = TRUE;
	} 
	return self.autoBrightness;
}

- (void)setSelected:(BOOL)selected {
	if ([objc_getClass("PSBrightnessSettingsDetail") autoBrightnessEnabled]) {
		selected = FALSE;
		[objc_getClass("PSBrightnessSettingsDetail") setAutoBrightnessEnabled:FALSE];
	} else {
		selected = TRUE;
		[objc_getClass("PSBrightnessSettingsDetail") setAutoBrightnessEnabled:TRUE];
	}
	self.autoBrightness = selected;
	[super refreshState];
}
@end
