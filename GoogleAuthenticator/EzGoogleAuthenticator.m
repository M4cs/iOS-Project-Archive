#import "EzGoogleAuthenticator.h"
#import "spawn.h"

@interface UIApplication (PrivateMethods)
- (BOOL)launchApplicationWithIdentifier:(NSString *)identifier suspended:(BOOL)suspend;
@end

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzGoogleAuthenticator
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return nil;// not much point having this as it can confuse people
}

- (BOOL)isSelected {
	return self.EzGoogleAuthenticator;
}

- (void)setSelected:(BOOL)selected {
  self.EzGoogleAuthenticator = selected;
	[super refreshState];
    [self google];
}

- (void)google {
  NSString *bundleID = @"com.google.Authenticator";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];
		self.EzGoogleAuthenticator = NO;
	
}
@end
