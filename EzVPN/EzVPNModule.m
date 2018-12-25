#import "EzVPNModule.h"

@interface NEVPNManager ()
+(BOOL)isEnabled;
+(void)setEnabled:(BOOL)arg1;
@end

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzVPNModule
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return [UIColor yellowColor];
}

- (BOOL)isSelected {
	if ([NEVPNManager isEnabled]) {
		self.ezvpn = TRUE;
	} else {
		self.ezvpn = FALSE;
	}
	return self.ezvpn;
}

- (void)setSelected:(BOOL)selected {
	if ([NEVPNManager isEnabled]) {
		[NEVPNManager setEnabled:FALSE];
		selected = FALSE;
	} else {
		[NEVPNManager setEnabled:TRUE];
		selected = TRUE;
	}
	self.ezvpn = selected;
	[super refreshState];
}
@end
