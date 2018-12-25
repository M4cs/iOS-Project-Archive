#import "EzAPTModule.h"
#import <spawn.h>



@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzAPTModule
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return [UIColor yellowColor];
}

- (BOOL)isSelected {
	return self.EzAPT;
}

- (void)setSelected:(BOOL)selected {
	self.EzAPT = selected;
	[super refreshState];
    [self aptget];
}

- (void)aptget {
    pid_t pid;
    int status;
    const char* args[] = {"apt-get", "update", NULL};
    posix_spawn(&pid, "/usr/bin/apt-get", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
	[super refreshState];
	[self aptget];
}
@end
