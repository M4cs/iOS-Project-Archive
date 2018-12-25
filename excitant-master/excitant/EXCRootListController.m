#include "EXCRootListController.h"

@implementation TTPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}


- (void)ContactmeTwitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/MidnightChip"]];
}

- (void)AuxiliumDiscord {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://discord.gg/E9T5gDF"]];
}
- (void)Paypal {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/AuxilumDevelopment"]];
}
- (void)Patreon {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.patreon.com/auxiliumdev"]];
}
- (void)ContactmeReddit {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.reddit.com/user/midnightchips"]];
}
- (void)ContactmeRedditChila {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.reddit.com/user/chilaxan"]];
}
- (void)ContactmeTwitterRobChila {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/rob311apps"]];
}


- (void)RespringMe {
	pid_t pid;
	int status;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	waitpid(pid, &status, WEXITED);
}
@end
