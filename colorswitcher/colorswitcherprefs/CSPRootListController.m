#include "CSPRootListController.h"

@implementation CSPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

NSString *readFromKey = @"customColor"; //  (You want to load from prefs probably)
NSString *fallbackHex = @"#ff0000";  // (You want to load from prefs probably)

UIColor *startColor = LCPParseColorString(readFromKey, fallbackHex); // this color will be used at startup
PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:YES];

[alert displayWithCompletion:
	^void (UIColor *pickedColor) {
		NSString *hexString = [UIColor hexFromColor:pickedColor];
		hexString = [hexString stringByAppendingFormat:@":%f", pickedColor.alpha];
	}];
	return _specifiers;
}

@end
