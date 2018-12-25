#include "CSPRootListController.h"
#import "../libcolorpicker.h"
#import <spawn.h>

@implementation CSPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}
	return _specifiers;
}

- (void)selectColour {
	NSMutableDictionary *prefsDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.colorswitcher.plist"];
	if (!prefsDict) prefsDict = [NSMutableDictionary dictionary];
		NSString *fallbackHex = @"#ff0000";  // (You want to load from prefs probably)
	    UIColor *startColor = LCPParseColorString([prefsDict objectForKey:@"customColour"], fallbackHex); // this color will be used at startup
	    PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:NO];
	    [alert displayWithCompletion:
	    ^void (UIColor *pickedColor){
				NSString *hexString = [UIColor hexFromColor:pickedColor];
				[prefsDict setObject:hexString forKey:@"customColour"];
				[prefsDict writeToFile:@"/var/mobile/Library/Preferences/com.macs.colorswitcher.plist" atomically:YES];
	    }];
}

- (void)respringDevice {
	pid_t pid;
	int status;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	waitpid(pid, &status, WEXITED);
}
- (void)contactMethod {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/AuxiliumDev"]];
}
- (void)contactMethodPersonal {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/auxmacs"]];
}
@end
