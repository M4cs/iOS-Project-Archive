#import "EXCRootListController.h"
#import <spawn.h>
@implementation SBRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"TapTapUtils" target:self] retain];
	}

	return _specifiers;
}
-(void)respringDevice{
	pid_t pid;
	int status;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	waitpid(pid, &status, WEXITED);
}

@end
