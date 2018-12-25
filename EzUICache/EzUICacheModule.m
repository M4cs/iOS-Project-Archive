#import "EzUICacheModule.h"
#import <spawn.h>
#import <sys/wait.h>

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzUICacheModule
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return [UIColor blueColor];
}

- (BOOL)isSelected {
	return self.EzUICache;
}

- (void)setSelected:(BOOL)selected {
	self.EzUICache = selected;
	[super refreshState];
  [self uicache];
}

- (void)uicache {
    pid_t pid;
    int status;
    const char* args[] = {"uicache", NULL, NULL, NULL};
    posix_spawn(&pid, "/usr/bin/uicache", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
		CFRunLoopRunInMode(kCFRunLoopDefaultMode, 20.0, false);
		self.EzUICache = FALSE;
}
@end
