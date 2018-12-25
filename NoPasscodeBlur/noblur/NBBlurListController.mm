#import <Preferences/Preferences.h>

@interface NBBlurListController: PSListController {
    UIWindow *settingsView;
    NSString *alphaValue;
    NSString *levelValue;
}
@end

@implementation NBBlurListController
- (id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Blur" target:self];
    }
    [_specifiers retain];
    return _specifiers;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.xtm3x.noblur.plist"];
    if (([dict objectForKey:@"utintf"] ? [[dict objectForKey:@"utintf"] floatValue] : 0.4) < 0.01) {
        alphaValue = [[NSString stringWithFormat:@"%f", [dict objectForKey:@"utintf"] ? [[dict objectForKey:@"utintf"] floatValue] : 0.4] substringToIndex:1];
    }
    else {
        alphaValue = [[NSString stringWithFormat:@"%f", [dict objectForKey:@"utintf"] ? [[dict objectForKey:@"utintf"] floatValue] : 0.4] substringToIndex:4];
    }
    if (([dict objectForKey:@"ulevelf"] ? [[dict objectForKey:@"ulevelf"] floatValue] : 0.0) < 0.01) {
        levelValue = [[NSString stringWithFormat:@"%f", [dict objectForKey:@"ulevelf"] ? [[dict objectForKey:@"ulevelf"] floatValue] : 0.0] substringToIndex:1];
    }
    else {
        levelValue = [[NSString stringWithFormat:@"%f", [dict objectForKey:@"ulevelf"] ? [[dict objectForKey:@"ulevelf"] floatValue] : 0.0] substringToIndex:4];
    }
    NSIndexPath *alphaIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    UITableViewCell *alphaCell = [self.table cellForRowAtIndexPath:alphaIndexPath];
    alphaCell.detailTextLabel.text = alphaValue;
    NSIndexPath *levelIndexPath = [NSIndexPath indexPathForRow:1 inSection:2];
    UITableViewCell *levelCell = [self.table cellForRowAtIndexPath:levelIndexPath];
    levelCell.detailTextLabel.text = levelValue;
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
    [UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
    [dict release];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = nil;
}
@end