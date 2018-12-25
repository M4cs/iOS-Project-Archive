#include "CCPRootListController.h"
#import "libcolorpicker.h"
#import <spawn.h>

@implementation CCPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)selectBarColors {
	NSMutableDictionary *prefsDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.ColorCamPrefs.plist"];
	if (!prefsDict) prefsDict = [NSMutableDictionary dictionary];
		NSString *fallbackHex = @"#ffffff";  // (You want to load from prefs probably)
	    UIColor *startColor = LCPParseColorString([prefsDict objectForKey:@"barColor"], fallbackHex); // this color will be used at startup
	    PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:NO];
	    [alert displayWithCompletion:
	    ^void (UIColor *pickedColor){
				NSString *hexString = [UIColor hexFromColor:pickedColor];
				[prefsDict setObject:hexString forKey:@"barColor"];
				[prefsDict writeToFile:@"/var/mobile/Library/Preferences/com.macs.ColorCamPrefs.plist" atomically:YES];
	    }];
}


- (void)selectShutterColor {
	NSMutableDictionary *prefsDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.ColorCamPrefs.plist"];
	if (!prefsDict) prefsDict = [NSMutableDictionary dictionary];
		NSString *fallbackHex = @"#000000";  // (You want to load from prefs probably)
	    UIColor *startColor = LCPParseColorString([prefsDict objectForKey:@"shutterColor"], fallbackHex); // this color will be used at startup
	    PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:NO];
	    [alert displayWithCompletion:
	    ^void (UIColor *pickedColor){
				NSString *hexString = [UIColor hexFromColor:pickedColor];
				[prefsDict setObject:hexString forKey:@"shutterColor"];
				[prefsDict writeToFile:@"/var/mobile/Library/Preferences/com.macs.ColorCamPrefs.plist" atomically:YES];
	    }];
}

- (void)selectGlyphColor {
	NSMutableDictionary *prefsDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.ColorCamPrefs.plist"];
	if (!prefsDict) prefsDict = [NSMutableDictionary dictionary];
		NSString *fallbackHex = @"#000000";  // (You want to load from prefs probably)
	    UIColor *startColor = LCPParseColorString([prefsDict objectForKey:@"glyphColor"], fallbackHex); // this color will be used at startup
	    PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:NO];
	    [alert displayWithCompletion:
	    ^void (UIColor *pickedColor){
				NSString *hexString = [UIColor hexFromColor:pickedColor];
				[prefsDict setObject:hexString forKey:@"glyphColor"];
				[prefsDict writeToFile:@"/var/mobile/Library/Preferences/com.macs.ColorCamPrefs.plist" atomically:YES];
	    }];
}

- (void)respringDevice {
	pid_t pid;
	int status;
	const char* args[] = {"killall", "-9", "Camera", NULL};
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
