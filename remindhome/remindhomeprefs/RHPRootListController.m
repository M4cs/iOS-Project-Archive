#include "RHPRootListController.h"
#import "../libcolorpicker.h"
#import <spawn.h>

@implementation RHPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}


- (void)selectColorBar {
	NSMutableDictionary *prefsDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.remindhome.plist"];
	if (!prefsDict) prefsDict = [NSMutableDictionary dictionary];
		NSString *fallbackHex = @"#ff0000";  // (You want to load from prefs probably)
	    UIColor *startColor = LCPParseColorString([prefsDict objectForKey:@"barColor"], fallbackHex);// this color will be used at startup
	    PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:NO];
	    [alert displayWithCompletion:
	    ^void (UIColor *pickedColor){
				NSString *hexString = [UIColor hexFromColor:pickedColor];
				[prefsDict setObject:hexString forKey:@"barColor"];
				[prefsDict writeToFile:@"/var/mobile/Library/Preferences/com.macs.remindhome.plist" atomically:YES];
	    }];
}

- (void)selectColorText {
	NSMutableDictionary *prefsDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.remindhome.plist"];
	if (!prefsDict) prefsDict = [NSMutableDictionary dictionary];
		NSString *fallbackHex = @"#ff0000";  // (You want to load from prefs probably)
			UIColor *startColor = LCPParseColorString([prefsDict objectForKey:@"textColor"], fallbackHex);// this color will be used at startup
	    PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:NO];
	    [alert displayWithCompletion:
	    ^void (UIColor *pickedColor){
				NSString *hexString = [UIColor hexFromColor:pickedColor];
				[prefsDict setObject:hexString forKey:@"textColor"];
				[prefsDict writeToFile:@"/var/mobile/Library/Preferences/com.macs.remindhome.plist" atomically:YES];
	    }];
}

- (void)selectColorButton {
	NSMutableDictionary *prefsDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.remindhome.plist"];
	if (!prefsDict) prefsDict = [NSMutableDictionary dictionary];
		NSString *fallbackHex = @"#ff0000";  // (You want to load from prefs probably)
			UIColor *startColor = LCPParseColorString([prefsDict objectForKey:@"buttonColor"], fallbackHex); // this color will be used at startup
	    PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:NO];
	    [alert displayWithCompletion:
	    ^void (UIColor *pickedColor){
				NSString *hexString = [UIColor hexFromColor:pickedColor];
				[prefsDict setObject:hexString forKey:@"buttonColor"];
				[prefsDict writeToFile:@"/var/mobile/Library/Preferences/com.macs.remindhome.plist" atomically:YES];
	    }];
}

- (void)respringDevice {
	pid_t pid;
	int status;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	waitpid(pid, &status, WEXITED);
}

@end
