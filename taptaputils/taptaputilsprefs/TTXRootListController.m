#include "TTXRootListController.h"
#import <spawn.h>
#import <objc/runtime.h>
@implementation TTXRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}
-(void)credits {
UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"Credits" message:@"Made by Clarke1234\nApart of the Auxilium Dev Team" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
[alert1 show];
}

- (void)twitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/ClarkeCDC"]];
}
- (void)reddit{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://reddit.com/user/clarke1234"]];
}

- (void)respringDevice {
	pid_t pid;
	int status;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	waitpid(pid, &status, WEXITED);
}
@end
