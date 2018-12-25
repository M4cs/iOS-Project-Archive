#include "PickPocketRootListController.h"

@implementation PickPocketRootListController

+ (NSString *)hb_specifierPlist {
    return @"Root";
}

+ (NSString *)hb_shareText {
    return @"I'm using #PickPocket, a powerful, full featured and highly customizable Cydia tweak made by @Ziph0n and updated for iOS 11 by @Auxmacs to protect my device against thieves!";
}

+ (NSString *)hb_shareURL {
    return @"";
}

+ (UIColor *)hb_tintColor {
    return [UIColor colorWithRed:252.f / 255.f green:89.f / 255.f blue:121.f / 255.f alpha:1];
}

- (void)respring {
	#pragma clang diagnostic push
	#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	system("killall -9 SpringBoard");
	#pragma clang diagnostic pop
}

- (void)twitter {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/Ziph0n"]];
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=Ziph0n"]];
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetings:///user?screen_name=Ziph0n"]];
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=Ziph0n"]];
    else
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://mobile.twitter.com/Ziph0n"]];
}

- (void)twitterMacs {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/Auxmacs"]];
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=Auxmacs"]];
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetings:///user?screen_name=Auxmacs"]];
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=Auxmacs"]];
    else
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://mobile.twitter.com/Auxmacs"]];
}

- (void)reddit {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.reddit.com/user/Ziph0n/"]];
}

- (void)sendEmail {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:ziph0ntweak@gmail.com?subject=PickPocket%202%20(iOS%2010)"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.ziph0n.pickpocket10.plist"];
    BOOL passwordEnabled = [[prefs objectForKey:@"passwordEnabled"] boolValue];
    BOOL passwordTouchID = [[prefs objectForKey:@"passwordTouchID"] boolValue];
    NSString *password = [prefs objectForKey:@"password"];

    if (passwordEnabled) {
        if (password != nil && ![password isEqual:@""]) {
            if (passwordTouchID) {
                LAContext *myContext = [[LAContext alloc] init];
                NSError *authError = nil;
                NSString *myLocalizedReasonString = @"Authenticate using your finger to unlock the PickPocket's Preferences";
                if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
                    [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:myLocalizedReasonString reply:^(BOOL success, NSError *error) {
                        if (success) {
                        } else {
                            switch (error.code) {
                                case LAErrorAuthenticationFailed: {
                                    [self exitPreferences];
                                    break;
                                }

                                case LAErrorUserCancel:
                                    [self exitPreferences];
                                    break;

                                case LAErrorUserFallback: {
                                    UIAlertController *passwordAlert = [self getPasswordAlert];
                                    [self presentViewController:passwordAlert animated:YES completion:nil];
                                    break;
                                }

                                default: {
                                    UIAlertController *passwordAlert = [self getPasswordAlert];
                                    [self presentViewController:passwordAlert animated:YES completion:nil];
                                    break;
                                }
                            }
                        }
                    }];
                } else {
                    UIAlertController *passwordAlert = [self getPasswordAlert];
                    [self presentViewController:passwordAlert animated:YES completion:nil];
                }
            } else {
                UIAlertController *passwordAlert = [self getPasswordAlert];
                [self presentViewController:passwordAlert animated:YES completion:nil];
            }
        } else {
            UIAlertController *passwordAlert = [UIAlertController
                alertControllerWithTitle:@"Warning"
                message:@"You enabled the PickPocket preferences protection but you haven't set a password"
                preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *okAction = [UIAlertAction
                actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *action) {
                }];

            [passwordAlert addAction:okAction];

            [self presentViewController:passwordAlert animated:YES completion:nil];
        }
    }
}

- (UIAlertController *)getPasswordAlert {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.ziph0n.pickpocket10.plist"];
    NSString *password = [prefs objectForKey:@"password"];

    UIAlertController *passwordAlert = [UIAlertController
        alertControllerWithTitle:@"Enter Password"
        message:@"You need to enter your password in order to edit the PickPocket preferences"
        preferredStyle:UIAlertControllerStyleAlert];


    [passwordAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Password", @"Password");
        textField.secureTextEntry = YES;
    }];

    UIAlertAction *resetAction = [UIAlertAction
        actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
        style:UIAlertActionStyleDestructive
        handler:^(UIAlertAction *action) {
            [self exitPreferences];
        }];

    UIAlertAction *okAction = [UIAlertAction
        actionWithTitle:NSLocalizedString(@"OK", @"OK action")
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction *action) {
            UITextField *passwordField = passwordAlert.textFields.firstObject;
            NSString *passwordEntered = passwordField.text;
            if ([passwordEntered isEqual:password]) {
            } else {
                [self exitPreferences];
            }
        }];

    [passwordAlert addAction:resetAction];
    [passwordAlert addAction:okAction];

    return passwordAlert;
}

- (void)exitPreferences {
    UIAlertController *passwordAlert = [UIAlertController
        alertControllerWithTitle:@"Error"
        message:@"I guess that you are not the owner of this device. The preferences app will be closed."
        preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction
        actionWithTitle:NSLocalizedString(@"OK", @"OK action")
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction *action) {
            exit(0);
        }];

    [passwordAlert addAction:okAction];

    [self presentViewController:passwordAlert animated:YES completion:nil];
}

@end
