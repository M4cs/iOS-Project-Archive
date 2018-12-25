#import "EXCRootListController.h"
#import "spawn.h"

@implementation TouchesRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Touches" target:self] retain];
	}

	return _specifiers;
}
- (void)RespringMe {
	pid_t pid;
	int status;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	waitpid(pid, &status, WEXITED);
}
@end
