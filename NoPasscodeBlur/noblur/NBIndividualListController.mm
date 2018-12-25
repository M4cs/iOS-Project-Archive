#import <Preferences/Preferences.h>

@interface NBIndividualListController: PSListController {
    UIWindow *settingsView;
}
@end

@implementation NBIndividualListController
- (id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Individual" target:self];
    }
    [_specifiers retain];
    return _specifiers;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
    [UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = nil;
}
@end
