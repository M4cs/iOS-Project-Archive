#import "NBCustomizeListController.h"
#import "NBPreViewController.h"
#define NBPrefsPath @"/var/mobile/Library/Preferences/com.xtm3x.noblur.plist"

@implementation NBCustomizeListController
-(id)initWithAppName:(NSString*)appName identifier:(NSString*)identifier {
    _appName = appName;
    [_appName retain];
    _identifier = identifier;
    return [self init];
}
- (NSArray*)specifiers {
    if (!_specifiers) {
        BOOL isSystemWideController = [_identifier isEqual:@"com.apple.UIKit"];
    	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:NBPrefsPath];

    	BOOL otdef = [[dict objectForKey:@"oTint"] boolValue];
    	NSString *otkey = !isSystemWideController ? [NSString stringWithFormat:@"%@-oTint", _identifier] : @"oTint";
    	NSString *utkey = !isSystemWideController ? [NSString stringWithFormat:@"%@-utintf", _identifier] : @"utintf";

    	BOOL oldef = [[dict objectForKey:@"oLevel"] boolValue];
    	NSString *olkey = !isSystemWideController ? [NSString stringWithFormat:@"%@-oLevel", _identifier] : @"oLevel";
    	NSString *ulkey = !isSystemWideController ? [NSString stringWithFormat:@"%@-ulevelf", _identifier] : @"ulevelf";

    	PSSpecifier *grp = [PSSpecifier emptyGroupSpecifier];
        PSSpecifier *blacklistSwitch = nil;
        if (isSystemWideController) {
            [grp setProperty:@"Enable NoBlur System Wide." forKey:@"footerText"];
            blacklistSwitch = [PSSpecifier preferenceSpecifierNamed:@"Enable" target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:[PSTableCell cellTypeFromString:@"PSSwitchCell"] edit:nil];
            [blacklistSwitch setProperty:_identifier forKey:@"key"];
            [blacklistSwitch setProperty:@YES forKey:@"default"];
        }
        else {
            if ([dict objectForKey:@"com.apple.UIKit"] ? [[dict objectForKey:@"com.apple.UIKit"] boolValue] : YES) {
                blacklistSwitch = [PSSpecifier preferenceSpecifierNamed:@"Blacklist" target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:[PSTableCell cellTypeFromString:@"PSSwitchCell"] edit:nil];
                [grp setProperty:[NSString stringWithFormat:@"Disable NoBlur in %@.", _appName] forKey:@"footerText"];
                [blacklistSwitch setProperty:_identifier forKey:@"key"];
            }
            else {
                blacklistSwitch = [PSSpecifier preferenceSpecifierNamed:@"Enable" target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:[PSTableCell cellTypeFromString:@"PSSwitchCell"] edit:nil];
                [grp setProperty:[NSString stringWithFormat:@"Enable NoBlur in %@.", _appName] forKey:@"footerText"];
                [blacklistSwitch setProperty:[NSString stringWithFormat:@"%@-enabled", _identifier] forKey:@"key"];
            }
            [blacklistSwitch setProperty:@NO forKey:@"default"];
        }

        PSSpecifier *grp2 = [PSSpecifier emptyGroupSpecifier];
    		
    	PSSpecifier *alphaSwitch = [PSSpecifier preferenceSpecifierNamed:@"Override Tint Alpha" target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:[PSTableCell cellTypeFromString:@"PSSwitchCell"] edit:nil];
        [alphaSwitch setProperty:otkey forKey:@"key"];
        [alphaSwitch setProperty:@(otdef) forKey:@"default"];

        PSSpecifier *alphaCustomize = [PSSpecifier preferenceSpecifierNamed:@"Customize" target:self set:nil get:nil detail:objc_getClass("NBPreViewController") cell:[PSTableCell cellTypeFromString:@"PSLinkCell"] edit:nil];
        [alphaCustomize setProperty:utkey forKey:@"setterKey"];
        [alphaCustomize setProperty:@0 forKey:@"mode"];

        // PSSpecifier *alphaSlider = [PSSpecifier preferenceSpecifierNamed:@"Tint Alpha" target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:[PSTableCell cellTypeFromString:@"PSSliderCell"] edit:nil];
        // [alphaSlider setProperty:@(0.0) forKey:@"min"];
        // [alphaSlider setProperty:@(1.0) forKey:@"max"];
        // [alphaSlider setProperty:@YES forKey:@"showValue"];
        // [alphaSlider setProperty:utkey forKey:@"key"];
        // [alphaSlider setProperty:@(utdef) forKey:@"default"];

        PSSpecifier *grp3 = [PSSpecifier emptyGroupSpecifier];

        PSSpecifier *levelSwitch = [PSSpecifier preferenceSpecifierNamed:@"Override Tint Level" target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:[PSTableCell cellTypeFromString:@"PSSwitchCell"] edit:nil];
        [levelSwitch setProperty:olkey forKey:@"key"];
        [levelSwitch setProperty:@(oldef) forKey:@"default"];

        PSSpecifier *levelCustomize = [PSSpecifier preferenceSpecifierNamed:@"Customize" target:self set:nil get:nil detail:objc_getClass("NBPreViewController") cell:[PSTableCell cellTypeFromString:@"PSLinkCell"] edit:nil];
        [levelCustomize setProperty:ulkey forKey:@"setterKey"];
        [levelCustomize setProperty:@1 forKey:@"mode"];

        // PSSpecifier *levelSlider = [PSSpecifier preferenceSpecifierNamed:@"Tint Level" target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:[PSTableCell cellTypeFromString:@"PSSliderCell"] edit:nil];
        // [levelSlider setProperty:@(0.0) forKey:@"min"];
        // [levelSlider setProperty:@(1.0) forKey:@"max"];
        // [levelSlider setProperty:@YES forKey:@"showValue"];
        // [levelSlider setProperty:ulkey forKey:@"key"];
        // [levelSlider setProperty:@(uldef) forKey:@"default"];

    	NSMutableArray *specifiers_ = [NSMutableArray arrayWithObjects:grp, blacklistSwitch, grp2, alphaSwitch, alphaCustomize, grp3, levelSwitch, levelCustomize, nil];		
        _specifiers = [specifiers_ retain];
	}
	
	return _specifiers;
}
-(id)readPreferenceValue:(PSSpecifier*)specifier {
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:NBPrefsPath];
	if (!dict[specifier.properties[@"key"]]) {
	   return specifier.properties[@"default"];
	}
	return dict[specifier.properties[@"key"]];
}
-(void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:NBPrefsPath]];
    [defaults setObject:value forKey:specifier.properties[@"key"]];
	[defaults writeToFile:NBPrefsPath atomically:YES];
	CFStringRef toPost = (CFStringRef)specifier.properties[@"PostNotification"];
	if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    NSString *alphaValue;
    NSString *levelValue;

    BOOL isSystemWideController = [_identifier isEqual:@"com.apple.UIKit"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:NBPrefsPath];

    NSString *utkey = !isSystemWideController ? [NSString stringWithFormat:@"%@-utintf", _identifier] : @"utintf";

    NSString *ulkey = !isSystemWideController ? [NSString stringWithFormat:@"%@-ulevelf", _identifier] : @"ulevelf";
    
    if (([dict objectForKey:utkey] ? [[dict objectForKey:utkey] floatValue] : 0.4) < 0.01) {
        alphaValue = [[NSString stringWithFormat:@"%f", [dict objectForKey:utkey] ? [[dict objectForKey:utkey] floatValue] : 0.4] substringToIndex:1];
    }
    else {
        alphaValue = [[NSString stringWithFormat:@"%f", [dict objectForKey:utkey] ? [[dict objectForKey:utkey] floatValue] : 0.4] substringToIndex:4];
    }
    if (([dict objectForKey:ulkey] ? [[dict objectForKey:ulkey] floatValue] : 0.0) < 0.01) {
        levelValue = [[NSString stringWithFormat:@"%f", [dict objectForKey:ulkey] ? [[dict objectForKey:ulkey] floatValue] : 0.0] substringToIndex:1];
    }
    else {
        levelValue = [[NSString stringWithFormat:@"%f", [dict objectForKey:ulkey] ? [[dict objectForKey:ulkey] floatValue] : 0.0] substringToIndex:4];
    }
    NSIndexPath *alphaIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    UITableViewCell *alphaCell = [self.table cellForRowAtIndexPath:alphaIndexPath];
    alphaCell.detailTextLabel.text = alphaValue;
    NSIndexPath *levelIndexPath = [NSIndexPath indexPathForRow:1 inSection:2];
    UITableViewCell *levelCell = [self.table cellForRowAtIndexPath:levelIndexPath];
    levelCell.detailTextLabel.text = levelValue;

    self.navigationItem.title = _appName;
    UIBarButtonItem *helpButton = [[UIBarButtonItem alloc] initWithTitle:@"Huh?" style:UIBarButtonItemStyleDone target:self action:@selector(help)];
    self.navigationItem.rightBarButtonItem = helpButton;
    [helpButton release];
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
    [UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = nil;
}
-(void)help {
    UIAlertView *helpMe = [[UIAlertView alloc] initWithTitle:@"Help" message:@"This is the App Settings menu.  Here you can customize the blur settings for this specific app." delegate:self cancelButtonTitle:@"Alright" otherButtonTitles:nil];          
    helpMe.tag = 101;
    [helpMe show];
    [helpMe release];
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        if (buttonIndex == 0) {
            UIAlertView *helpMe2 = [[UIAlertView alloc] initWithTitle:@"Help" message:@"Change what settings you want but if you don't change a value, it will default to the one in System Wide." delegate:self cancelButtonTitle:@"Gotcha" otherButtonTitles:nil];          
            [helpMe2 show];
            [helpMe2 release];
        }
    }
}
@end