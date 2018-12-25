#import "EzPlayMusic.h"
#import "spawn.h"

@interface UIApplication (PrivateMethods)
- (BOOL)launchApplicationWithIdentifier:(NSString *)identifier suspended:(BOOL)suspend;
@end

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzPlayMusic
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return nil;// not much point having this as it can confuse people
}

- (BOOL)isSelected {
	return self.EzPlayMusic;
}

- (void)setSelected:(BOOL)selected {
  self.EzPlayMusic = selected;
	[super refreshState];
    [self playmusic];
}

- (void)playmusic {
  NSString *bundleID = @"com.google.PlayMusic";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];
		self.EzPlayMusic = NO;
}
@end
