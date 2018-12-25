#include "SPBRootListController.h"

@implementation SPBRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}
-(void)respring
{
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.auxilium.switcherprefs/respring"), NULL, NULL, YES);
}
- (void)ContactmacsTwitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/Auxmacs"]];
}

- (void)ContactmidTwitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/MidnightChip"]];
}

- (void)donate {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/AuxilumDevelopment"]];
}

- (void)patreon {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.patreon.com/auxiliumdev"]];
}

- (void)AuxiliumDiscord {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://discord.gg/E9T5gDF"]];
}

- (void)LuciTwitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/lucifers_circle"]];
}
@end

@end
