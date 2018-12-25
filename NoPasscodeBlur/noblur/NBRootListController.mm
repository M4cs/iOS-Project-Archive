#include "NBRootListController.h"

@implementation NBRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}
    [_specifiers retain];
	return _specifiers;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *respringButton = [[[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStyleDone target:self action:@selector(respring)] autorelease];
    ((UINavigationItem*)self.navigationItem).rightBarButtonItem = respringButton;
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
    [UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = nil;
}
- (void)twitter {

    NSString * _user = @"xTM3x";

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:_user]]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:_user]]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:_user]]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:_user]]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:_user]]];
    }
}
-(void)reset {
    CFArrayRef keyList = CFPreferencesCopyKeyList((__bridge CFStringRef)@"com.xtm3x.noblur", kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    CFPreferencesSetMultiple ( NULL, keyList, (__bridge CFStringRef)@"com.xtm3x.noblur", kCFPreferencesCurrentUser, kCFPreferencesAnyHost );
    UIAlertView *alert =[[UIAlertView alloc ] initWithTitle:@"Complete!"
                                                    message:[NSString stringWithFormat:@"You will need to respring to apply your changes."]
                                                   delegate:self
                                          cancelButtonTitle:@"Later"
                                          otherButtonTitles: nil];
    [alert addButtonWithTitle:@"Respring"];
    [alert show];
    [alert release];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //who are you, the declaration declarer?
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        system("killall -9 backboardd");
        #pragma clang diagnostic pop
    }
}
-(void) mail
{
    MFMailComposeViewController *mailViewController;
    if ([MFMailComposeViewController canSendMail])
    {
        mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"NoBlur 1.5"];
        
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *sysInfo = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        
        NSString *msg = [NSString stringWithFormat:@"\n\n\n\n\nI have an %@ running iOS %@", sysInfo, [UIDevice currentDevice].systemVersion];
        [mailViewController setMessageBody:msg isHTML:NO];
        [mailViewController setToRecipients:@[@"xtm3xyt@gmail.com"]];
            
        [self.rootController presentViewController:mailViewController animated:YES completion:nil];
    }

}
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [controller release];
}
- (void)respring {
    HBLogInfo(@"Give me a second...");
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    system("launchctl kickstart -k system/com.apple.cfprefsd.xpc.daemon");
    HBLogInfo(@"Thanks for the second!");
    // CFPreferencesSetAppValue(CFSTR("SBLanguageRestart"), kCFBooleanTrue, CFSTR("com.apple.springboard"));
    system("killall -9 backboardd");
    #pragma clang diagnostic pop
}
@end
