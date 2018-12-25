#import "EzSnapchatOpener.h"
#import "spawn.h"

@interface UIApplication (PrivateMethods)
- (BOOL)launchApplicationWithIdentifier:(NSString *)identifier suspended:(BOOL)suspend;
@end

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzSnapchatOpener
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return nil;// not much point having this as it can confuse people
}

- (BOOL)isSelected {
	return self.EzSnapchatOpener;
}

- (void)setSelected:(BOOL)selected {
  self.EzSnapchatOpener = selected;
	[super refreshState];
    [self snapchat];
}

- (void)snapchat {
  NSString *bundleID = @"com.toyopagroup.picaboo";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];
		self.EzSnapchatOpener = NO;
	
}
@end
