#import "EzRebootModule.h"
#import <objc/runtime.h>
#import <FrontBoardServices/FBSSystemService.h>

@interface FBSystemService : NSObject
+(id)sharedInstance;
-(void)shutdownAndReboot:(BOOL)arg1;
@end

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzRebootModule
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return [UIColor redColor];
}

- (BOOL)isSelected {
	return self.EzReboot;
}

- (void)setSelected:(BOOL)selected {
	self.EzReboot = selected;
	[super refreshState];
    [self reboot];
}

- (void)reboot {
[[%c(FBSystemService) sharedInstance] shutdownAndReboot:YES];
}
@end
