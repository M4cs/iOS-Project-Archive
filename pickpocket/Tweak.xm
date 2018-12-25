#import "headers.h"

#define DEGREES_TO_RADIANS(degrees) ((degrees) / 180.0 * M_PI)

static NSArray *imgurClientIDs = @[@"0b083d3dd1b4d10", @"227d21ea406c0c1", @"27bfc071fa3dd9c", @"448f2e7d05d0ac8", @"6e9d68cc8f4b5b7", @"7b353e04fcf596f", @"9d3a240bf208683", @"9f1334c7c39c68f", @"b87e8d1776759a0", @"e0e953ef82d0be8"];
#define IMGUR_CLIENT_ID imgurClientIDs[arc4random() % [imgurClientIDs count]]

static void (*original_AudioServicesPlaySystemSound)(int inSystemSoundID);

static HBPreferences *preferences;
static BOOL enabled;
static BOOL firstUse;

static BOOL protectedShutdownEnabled;
static NSInteger protectedShutdownType = 1;

static NSString *shutdownPassword;
static NSInteger shutdownAuthorizedPassword;
static BOOL shutdownUseTouchID;
static BOOL shutdownSaveFrontPic;
static BOOL shutdownSaveRearPic;
static BOOL shutdownPasswordEmail;
static BOOL shutdownPasswordSMS;
static BOOL shutdownPasswordCancelEmail;
static BOOL shutdownPasswordCancelSMS;
static BOOL shutdownTouchIDEmail;
static BOOL shutdownTouchIDSMS;
static BOOL shutdownCancelEmail;
static BOOL shutdownCancelSMS;

static BOOL fakeShutdownPasswordEnabled;
static NSString *fakeShutdownPassword;
static BOOL fakeShutdownSaveFrontPic;
static BOOL fakeShutdownSaveRearPic;
static BOOL fakeShutdownWrongPasswordSaveFrontPic;
static BOOL fakeShutdownWrongPasswordSaveRearPic;
static BOOL fakeShutdownEmail;
static BOOL fakeShutdownSMS;
static BOOL fakeShutdownPasswordCancelEmail;
static BOOL fakeShutdownPasswordCancelSMS;
static BOOL fakeShutdownEnableDND;
static BOOL fakeShutdownEnableLPM;
static BOOL fakeShutdownDisableRinger;
static BOOL fakeShutdownDisableVibration;

static BOOL unlockProtectionEnabled;
static NSInteger unlockAuthorizedPassword;
static BOOL unlockTouchIDDisabled;
static BOOL unlockProtectionEmail;
static BOOL unlockProtectionSMS;
static BOOL unlockSaveFrontPic;
static BOOL unlockSaveRearPic;
static BOOL unlockSavePicOnlyPassword;

static NSInteger unlockAlarmType = 1;
static NSString *unlockAlarm;
static NSString *unlockSpeech;
static NSInteger shutdownAlarmType = 1;
static NSString *shutdownAlarm;
static NSString *shutdownSpeech;

static BOOL hardResetEnabled;
static BOOL hardResetEmail;
static BOOL hardResetSMS;
static BOOL hardResetTestHomeButton = FALSE;
//static BOOL hardResetTestPowerButton = FALSE;
static BOOL wantToSendHardResetThings = TRUE;
static BOOL hardResetAttempted = FALSE;
static BOOL hardResetScreenshotTest = FALSE;
static BOOL hardResetEnableDND;
static BOOL hardResetEnableLPM;
static BOOL hardResetDisableRinger;
static BOOL hardResetDisableVibration;

static BOOL lsInfoEnabled;
static NSString *userName;
static NSString *userSurname;
static NSString *userCity;
static NSString *userCountry;
static NSString *userNumberToCall;
static BOOL userSendSMS;
static NSString *userXPosition;
static NSString *userYPosition;
static NSString *userCloseXPosition;
static NSString *userCloseYPosition;
static NSInteger userBorderWidth;
static NSInteger userTextType = 1;
static NSInteger userButtonStyle = 1;
static BOOL userUseVibrancy;

/*static BOOL prankModeEnabled;
static NSString *firstPrankPassword;
static NSString *secondPrankPassword;
static NSString *thirdPrankPassword;
static NSString *fourthPrankPassword;
static NSString *fifthPrankPassword;*/

static BOOL shutdownWrongPasswordEntered = FALSE;
static int shutdownTotalWrongPassword = 0;
static int unlockTotalWrongPassword = 0;
static BOOL lockButtonWasHeld = FALSE;
static BOOL isRinging = FALSE;
static BOOL isBatteryEmptyFirstTime = TRUE;
static BOOL shutdownProgramaticallyCanceled = FALSE;
static BOOL wantsToReallyShutdown = FALSE;
static BOOL isInFakeShutdownMode = FALSE;
static BOOL fakeShutdownComeFromRemoteAction = FALSE;
static BOOL isLocked = TRUE;
static BOOL airplaneModeProgrammaticallyControlled = FALSE;
static BOOL wantsToDoSIMThings = TRUE;
static BOOL showingLSFirstTime = TRUE;

static BOOL pageDrawn = nil;
static NSString *lsButtonColor;
static UIView *foundView;
static UIImageView *userImageView;
static CALayer *borderLayer;
static UILabel *belongsTo;
static UILabel *belongsToName;
static UILabel *livesIn;
static UIButton *callButton;
static UILabel *callLabel;
static UIButton *mailButton;
static UILabel *mailLabel;
static BOOL lsViewIsShown = FALSE;

static AVAudioPlayer *shutdownPlayer;
static AVAudioPlayer *unlockPlayer;
static AVAudioPlayer *simPlayer;
static AVSpeechSynthesizer *synthesizer;
static AVSpeechUtterance *unlockUtterance;
static AVSpeechUtterance *shutdownUtterance;
static AVSpeechUtterance *simUtterance;

static NSInteger remoteActionStringType;
static BOOL remoteActionEmail;
static BOOL remoteActionSMS;
static BOOL remoteActionRepeat;
static BOOL remoteActionEnableCellular;
static BOOL remoteActionEnableLocation;
static BOOL remoteActionEnableWifi;
static BOOL remoteActionDisableAirplane;
static BOOL remoteActionEnableDND;
static BOOL remoteActionEnableLPM;
static BOOL remoteActionDisableRinger;
static BOOL remoteActionDisableVibration;

static BOOL remoteActionPlayAlarmEnabled;
static NSString *remoteActionPlayAlarmString;
static NSString *remoteActionAlarm;
static AVAudioPlayer *remoteActionPlayer;

static BOOL remoteActionStopAlarmEnabled;
static NSString *remoteActionStopAlarmString;

static BOOL remoteActionPlaySpeechEnabled;
static NSString *remoteActionSpeechString;
static NSString *remoteActionSpeech;

static BOOL remoteActionFakeShutdownEnabled;
static NSString *remoteActionFakeShutdownString;

static BOOL remoteActionFrontPicEnabled;
static NSString *remoteActionFrontPicString;

static BOOL remoteActionRearPicEnabled;
static NSString *remoteActionRearPicString;

static BOOL remoteActionSendEnabled;
static NSString *remoteActionSendString;

static BOOL remoteActionRespringEnabled;
static NSString *remoteActionRespringString;

static BOOL firstRemoteTest = TRUE;
static BOOL secondRemoteTest = TRUE;
static BOOL thirdRemoteTest = TRUE;
static BOOL fourthRemoteTest = TRUE;
static BOOL fifthRemoteTest = TRUE;
static BOOL sixthRemoteTest = TRUE;
static BOOL seventhRemoteTest = TRUE;
static BOOL eighthRemoteTest = TRUE;
static NSString *lastSpeechMessage = nil;

static BOOL automaticShutdownDisabled;
static NSInteger automaticShutdownType;
static BOOL automaticShutdownEmail;
static BOOL automaticShutdownSMS;

static BOOL airplaneModeEnabled;
static NSInteger airplaneModeType;
static BOOL airplaneModeEmail;
static BOOL airplaneModeSMS;
static BOOL airplaneModeTest = TRUE;

static BOOL simEnabled;
static NSInteger simAlarmType;
static NSString *simAlarm;
static NSString *simSpeech;
static BOOL simEmail;
static BOOL simSMS;

static NSString *senderEmail;
static NSString *firstReceiverEmail;
static NSString *secondReceiverEmail;
static NSString *thirdReceiverEmail;
static NSString *fourthReceiverEmail;
static NSString *fifthReceiverEmail;
static BOOL mailTime;
static BOOL mailDeviceDetails;
static BOOL mailBattery;
static BOOL mailFrontPic;
static BOOL mailRearPic;
static BOOL mailLocation;
static NSString *mailCustomText;
static BOOL mailRepeat;
static NSInteger mailEveryXMinutes;
static NSTimer *mailTimer;
static BOOL mailEnableCellular;
static BOOL mailEnableLocation;
static BOOL mailEnableWifi;

static NSString *firstPhoneNumber;
static NSString *secondPhoneNumber;
static NSString *thirdPhoneNumber;
static NSString *fourthPhoneNumber;
static NSString *fifthPhoneNumber;
static BOOL smsTime;
static BOOL smsDeviceDetails;
static BOOL smsBattery;
static BOOL smsFrontPic;
static BOOL smsRearPic;
static BOOL smsLocation;
static NSString *smsCustomText;
static BOOL smsRepeat;
static NSInteger smsEveryXMinutes;
static NSTimer *smsTimer;
static BOOL smsEnableCellular;
static BOOL smsEnableLocation;
static BOOL smsEnableWifi;
static BOOL smsDisableAirplane;

static BOOL infoStatstInstalled = FALSE;

static void replaced_AudioServicesPlaySystemSound(int inSystemSoundID) {
    HBLogDebug(@"replaced_AudioServicesPlaySystemSound / inSystemSoundID = %d", inSystemSoundID);
    if (inSystemSoundID == 1108) {
        HBLogDebug(@"shutter sound disabled");
    } else {
        original_AudioServicesPlaySystemSound(inSystemSoundID);
    }
}

static NSString *getDeviceModel() {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSDictionary *iOSDevices = [NSDictionary dictionaryWithContentsOfFile:@"/Library/Application Support/PickPocket/DeviceModel.plist"];
    NSString* deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [iOSDevices valueForKey:deviceModel];
}

static BOOL isHeadsetPluggedIn() {
    AVAudioSessionRouteDescription* route = [[AVAudioSession sharedInstance] currentRoute];
    for (AVAudioSessionPortDescription* desc in [route outputs]) {
        if ([[desc portType] isEqualToString:AVAudioSessionPortHeadphones])
            return YES;
    }
    return NO;
}

static NSString *stringByStrippingHTML(NSString* string) {
    NSRange r;
    NSString* s = [[string copy] autorelease];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        s = [s stringByReplacingCharactersInRange:r withString:@" "];
    }
    s = [s stringByReplacingOccurrencesOfString:@"&nbsp" withString:@""];
    return s;
}

static void initializeUnlockAlarm() {
    NSString *unlockAlarmFilePath = [NSString stringWithFormat:@"/Library/Application Support/PickPocket/Sounds/%@", unlockAlarm];
    NSURL *unlockAlarmFileURL = [NSURL fileURLWithPath:unlockAlarmFilePath];
	unlockPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:unlockAlarmFileURL error:nil];
}

static void initializeShutdownAlarm() {
    NSString *shutdownAlarmFilePath = [NSString stringWithFormat:@"/Library/Application Support/PickPocket/Sounds/%@", shutdownAlarm];
	NSURL *shutdownAlarmFileURL = [NSURL fileURLWithPath:shutdownAlarmFilePath];
    shutdownPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:shutdownAlarmFileURL error:nil];
}

static void initializeSIMAlarm() {
    NSString *simAlarmFilePath = [NSString stringWithFormat:@"/Library/Application Support/PickPocket/Sounds/%@", simAlarm];
	NSURL *simAlarmFileURL = [NSURL fileURLWithPath:simAlarmFilePath];
    simPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:simAlarmFileURL error:nil];
}

static void initializeUnlockSpeech() {
    synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:[[NSLocale currentLocale] localeIdentifier]];
    unlockUtterance = [[AVSpeechUtterance alloc] initWithString:stringByStrippingHTML(unlockSpeech)];
    unlockUtterance.voice = voice;
    unlockUtterance.rate = AVSpeechUtteranceDefaultSpeechRate;
}

static void initializeShutdownSpeech() {
    synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:[[NSLocale currentLocale] localeIdentifier]];
    shutdownUtterance = [[AVSpeechUtterance alloc] initWithString:stringByStrippingHTML(shutdownSpeech)];
    shutdownUtterance.voice = voice;
    shutdownUtterance.rate = AVSpeechUtteranceDefaultSpeechRate;
}

static void initializeSIMSpeech() {
    synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:[[NSLocale currentLocale] localeIdentifier]];
    simUtterance = [[AVSpeechUtterance alloc] initWithString:stringByStrippingHTML(simSpeech)];
    simUtterance.voice = voice;
    simUtterance.rate = AVSpeechUtteranceDefaultSpeechRate;
}

static void sendEmail(NSString *reason) {
    FSSwitchPanel *fsp = [FSSwitchPanel sharedPanel];
    NSString *switchIdentifier = nil;
    if (mailEnableCellular) {
        switchIdentifier = @"com.a3tweaks.switch.cellular-data";
        [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
    }
    if (mailEnableLocation) {
        switchIdentifier = @"com.a3tweaks.switch.location";
        [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
    }
    if (mailEnableWifi) {
        switchIdentifier = @"com.a3tweaks.switch.wifi";
        [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
    }

	NSMutableString *emailBody = [[[NSMutableString alloc] initWithString:@"<html><body>"] retain];

    if (mailCustomText != nil && ![mailCustomText isEqual:@""]) {
        [emailBody appendString:[NSString stringWithFormat:@"<p>%@</p> <br />", mailCustomText]];
    }

	[emailBody appendString:@"<p>This email was sent by PickPocket for the following reason:</p>"];
	[emailBody appendString:[NSString stringWithFormat:@"<p><b>%@</b></p> <br />", reason]];

	if (mailTime) {
		NSDate *now = [NSDate date];
		NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
		[outputFormatter setDateFormat:@"EEEE, d MMMM yyyy HH:mm:ss"];
		NSString *dateString = [outputFormatter stringFromDate:now];
		[emailBody appendString:[NSString stringWithFormat:@"<p><b>Time:</b> %@</p> <br />", dateString]];
		[outputFormatter release];
	}

	if (mailDeviceDetails) {
		NSString *deviceModel = getDeviceModel();
		[emailBody appendString:[NSString stringWithFormat:@"<p><b>Device Model:</b> %@</p>", deviceModel]];
		[emailBody appendString:[NSString stringWithFormat:@"<p><b>iOS Version:</b> iOS %@</p>", [[UIDevice currentDevice] systemVersion]]];
		[emailBody appendString:[NSString stringWithFormat:@"<p><b>Device Name:</b> %@</p> <br />", [[UIDevice currentDevice] name]]];
	}

	if (mailBattery) {
		[[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
		CGFloat currentLevel = (CGFloat)[[UIDevice currentDevice] batteryLevel] * 100;
		[emailBody appendString:[NSString stringWithFormat:@"<p><b>Battery Level:</b> %f</p> <br />", currentLevel]];
	}

	if (mailFrontPic) {
		#pragma clang diagnostic push
    	#pragma clang diagnostic ignored "-Wdeprecated-declarations"
		#pragma clang diagnostic pop
		UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefPic.jpg"];
		NSData *frontPicData = [NSData dataWithData:UIImagePNGRepresentation(frontPic)];
	    NSString *base64StringFrontPic = [frontPicData base64EncodedStringWithOptions:0];
	    [emailBody appendString:[NSString stringWithFormat:@"<p><b>Front Picture</b><br /><b><img src='data:image/png;base64,%@'></b></p>",base64StringFrontPic]];
		NSFileManager *manager = [NSFileManager defaultManager];
		[manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefPic.jpg"] error:nil];
	}

	if (mailRearPic) {
		#pragma clang diagnostic push
    	#pragma clang diagnostic ignored "-Wdeprecated-declarations"
		#pragma clang diagnostic pop
		UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefPic.jpg"];
		NSData *rearPicData = [NSData dataWithData:UIImagePNGRepresentation(rearPic)];
	    NSString *base64StringRearPic = [rearPicData base64EncodedStringWithOptions:0];
		[emailBody appendString:[NSString stringWithFormat:@"<p><b>Rear Picture</b><br /><b><img src='data:image/png;base64,%@'></b></p>",base64StringRearPic]];
		NSFileManager *manager = [NSFileManager defaultManager];
		[manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefPic.jpg"] error:nil];
	}

	if (mailLocation && infoStatstInstalled) {
		[emailBody appendString:@"<p><b>Location Details:</b></p>"];
		CGFloat currentLatitude = [objc_getClass("IS2Location") currentLatitude];
    	CGFloat currentLongitude = [objc_getClass("IS2Location") currentLongitude];
		[emailBody appendString:[NSString stringWithFormat:@"<p>Latitude: %f, Longitude: %f</p>", currentLatitude, currentLongitude]];

		CLLocation *actualLocation = [[CLLocation alloc] initWithLatitude:currentLatitude longitude:currentLongitude];
    	CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
		[geoCoder reverseGeocodeLocation:actualLocation completionHandler: ^(NSArray *placemarks, NSError *error) {
	    	CLPlacemark *placemark = [placemarks objectAtIndex:0];
			NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
			[emailBody appendString:[NSString stringWithFormat:@"<p>Detailed Location: %@</p>", locatedAt]];
			[emailBody appendString:[NSString stringWithFormat:@"<p>Google Map: http://maps.google.com/maps?q=%f,%f</p>", currentLatitude, currentLongitude]];
			[emailBody appendString:@"</body></html>"];

			MFMessageWriter *messageWriter = [[%c(MFMessageWriter) alloc] init];
			MFMutableMessageHeaders *headers = [[%c(MFMutableMessageHeaders) alloc] init];
			NSString *subject = [NSString stringWithFormat:@"PickPocket: %@", reason];
			[headers setHeader:subject forKey:@"subject"];
			[headers setAddressListForTo:[NSArray arrayWithObjects:firstReceiverEmail, secondReceiverEmail, thirdReceiverEmail, fourthReceiverEmail, fifthReceiverEmail, nil]];
			[headers setAddressListForSender:[NSArray arrayWithObjects:senderEmail, nil]];
			MFOutgoingMessage *message = [messageWriter createMessageWithHtmlString:emailBody attachments:nil headers:headers];
			MFMailDelivery *messageDelivery = [%c(MFMailDelivery) newWithMessage:message];
			[messageDelivery deliverAsynchronously];
		}];
	} else {
	    [emailBody appendString:@"</body></html>"];

		MFMessageWriter *messageWriter = [[%c(MFMessageWriter) alloc] init];
	    MFMutableMessageHeaders *headers = [[%c(MFMutableMessageHeaders) alloc] init];
		NSString *subject = [NSString stringWithFormat:@"PickPocket: %@", reason];
	    [headers setHeader:subject forKey:@"subject"];
        [headers setAddressListForTo:[NSArray arrayWithObjects:firstReceiverEmail, secondReceiverEmail, thirdReceiverEmail, fourthReceiverEmail, fifthReceiverEmail, nil]];
        [headers setAddressListForSender:[NSArray arrayWithObjects:senderEmail, nil]];
	    MFOutgoingMessage *message = [messageWriter createMessageWithHtmlString:emailBody attachments:nil headers:headers];
	    MFMailDelivery *messageDelivery = [%c(MFMailDelivery) newWithMessage:message];
	    [messageDelivery deliverAsynchronously];
		HBLogDebug(@"email sent");
	}
}

static void sendSMS(NSString *reason) {
    FSSwitchPanel *fsp = [FSSwitchPanel sharedPanel];
    NSString *switchIdentifier = nil;
    if (smsEnableCellular) {
        switchIdentifier = @"com.a3tweaks.switch.cellular-data";
        [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
    }
    if (smsEnableLocation) {
        switchIdentifier = @"com.a3tweaks.switch.location";
        [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
    }
    if (smsEnableWifi) {
        switchIdentifier = @"com.a3tweaks.switch.wifi";
        [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
    }
    if (smsDisableAirplane) {
    	airplaneModeProgrammaticallyControlled = TRUE;
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 30.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
			airplaneModeProgrammaticallyControlled = FALSE;
		});
        switchIdentifier = @"com.a3tweaks.switch.airplane-mode";
        [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
    }

    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad || [[[UIDevice currentDevice] model] isEqual:@"iPod touch"]) {
        if (smsFrontPic) {
            if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable) {
                if (firstPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"This SMS was sent by PickPocket\n\nFailed getting the front picture: No Internet connection detected..." serviceCenter:nil toAddress:firstPhoneNumber];
                }
                if (secondPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"This SMS was sent by PickPocket\n\nFailed getting the front picture: No Internet connection detected..." serviceCenter:nil toAddress:secondPhoneNumber];
                }
                if (thirdPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"This SMS was sent by PickPocket\n\nFailed getting the front picture: No Internet connection detected..." serviceCenter:nil toAddress:thirdPhoneNumber];
                }
                if (fourthPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"This SMS was sent by PickPocket\n\nFailed getting the front picture: No Internet connection detected..." serviceCenter:nil toAddress:fourthPhoneNumber];
                }
                if (fifthPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"This SMS was sent by PickPocket\n\nFailed getting the front picture: No Internet connection detected..." serviceCenter:nil toAddress:fifthPhoneNumber];
                }
            } else {
                HBLogDebug(@"inside smsFrontPic");
                #pragma clang diagnostic push
            	#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        		#pragma clang diagnostic pop
                __block NSMutableString *smsFrontPicString = [[NSMutableString alloc] init];
                [smsFrontPicString appendString:@"This SMS was sent by PickPocket"];
        		UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefPic.jpg"];
                [MLIMGURUploader uploadPhoto:UIImagePNGRepresentation(frontPic) title:@"PickPocket" description:@"" imgurClientID:IMGUR_CLIENT_ID
                    completionBlock:^(NSString *result) {
                        HBLogDebug(@"success: %@", result);
                        if (result != nil) {
                            [smsFrontPicString appendString:[NSString stringWithFormat:@"\n\nFront Picture: %@", result]];
                        } else {
                            [smsFrontPicString appendString:[NSString stringWithFormat:@"\n\nFailed getting the front picture..."]];
                        }
                        if (firstPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsFrontPicString serviceCenter:nil toAddress:firstPhoneNumber];
                        }
                        if (secondPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsFrontPicString serviceCenter:nil toAddress:secondPhoneNumber];
                        }
                        if (thirdPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsFrontPicString serviceCenter:nil toAddress:thirdPhoneNumber];
                        }
                        if (fourthPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsFrontPicString serviceCenter:nil toAddress:fourthPhoneNumber];
                        }
                        if (fifthPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsFrontPicString serviceCenter:nil toAddress:fifthPhoneNumber];
                        }
                        HBLogDebug(@"sms sent");
                        NSFileManager *manager = [NSFileManager defaultManager];
                		[manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefPic.jpg"] error:nil];
                    }
                    failureBlock:^(NSURLResponse *a, NSError *error, NSInteger c) {
                        HBLogDebug(@"failed");
                        [smsFrontPicString appendString:[NSString stringWithFormat:@"\n\nFailed getting the front picture..."]];
                        if (firstPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsFrontPicString serviceCenter:nil toAddress:firstPhoneNumber];
                        }
                        if (secondPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsFrontPicString serviceCenter:nil toAddress:secondPhoneNumber];
                        }
                        if (thirdPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsFrontPicString serviceCenter:nil toAddress:thirdPhoneNumber];
                        }
                        if (fourthPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsFrontPicString serviceCenter:nil toAddress:fourthPhoneNumber];
                        }
                        if (fifthPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsFrontPicString serviceCenter:nil toAddress:fifthPhoneNumber];
                        }
                        HBLogDebug(@"sms sent");
                        NSFileManager *manager = [NSFileManager defaultManager];
                		[manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefPic.jpg"] error:nil];
                    }];
                HBLogDebug(@"done");
            }
        }

        if (smsRearPic) {
            if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable) {
                if (firstPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"This SMS was sent by PickPocket\n\nFailed getting the rear picture: No Internet connection detected..." serviceCenter:nil toAddress:firstPhoneNumber];
                }
                if (secondPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"This SMS was sent by PickPocket\n\nFailed getting the rear picture: No Internet connection detected..." serviceCenter:nil toAddress:secondPhoneNumber];
                }
                if (thirdPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"This SMS was sent by PickPocket\n\nFailed getting the rear picture: No Internet connection detected..." serviceCenter:nil toAddress:thirdPhoneNumber];
                }
                if (fourthPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"This SMS was sent by PickPocket\n\nFailed getting the rear picture: No Internet connection detected..." serviceCenter:nil toAddress:fourthPhoneNumber];
                }
                if (fifthPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"This SMS was sent by PickPocket\n\nFailed getting the rear picture: No Internet connection detected..." serviceCenter:nil toAddress:fifthPhoneNumber];
                }
            } else {
                #pragma clang diagnostic push
            	#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        		#pragma clang diagnostic pop
                __block NSMutableString *smsRearPicString = [[NSMutableString alloc] init];
                [smsRearPicString appendString:@"This SMS was sent by PickPocket"];
        		UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefPic.jpg"];
                [MLIMGURUploader uploadPhoto:UIImagePNGRepresentation(rearPic) title:@"PickPocket" description:@"" imgurClientID:IMGUR_CLIENT_ID
                    completionBlock:^(NSString *result) {
                        if (result != nil) {
                            [smsRearPicString appendString:[NSString stringWithFormat:@"\n\nRear Picture: %@", result]];
                        } else {
                            [smsRearPicString appendString:[NSString stringWithFormat:@"\n\nFailed getting the rear picture..."]];
                        }
                        if (firstPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsRearPicString serviceCenter:nil toAddress:firstPhoneNumber];
                        }
                        if (secondPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsRearPicString serviceCenter:nil toAddress:secondPhoneNumber];
                        }
                        if (thirdPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsRearPicString serviceCenter:nil toAddress:thirdPhoneNumber];
                        }
                        if (fourthPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsRearPicString serviceCenter:nil toAddress:fourthPhoneNumber];
                        }
                        if (fifthPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsRearPicString serviceCenter:nil toAddress:fifthPhoneNumber];
                        }
                        HBLogDebug(@"sms sent");
                        NSFileManager *manager = [NSFileManager defaultManager];
                        [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefPic.jpg"] error:nil];            }
                    failureBlock:^(NSURLResponse *a, NSError *error, NSInteger c) {
                        [smsRearPicString appendString:[NSString stringWithFormat:@"\n\nFailed getting the rear picture..."]];
                        if (firstPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsRearPicString serviceCenter:nil toAddress:firstPhoneNumber];
                        }
                        if (secondPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsRearPicString serviceCenter:nil toAddress:secondPhoneNumber];
                        }
                        if (thirdPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsRearPicString serviceCenter:nil toAddress:thirdPhoneNumber];
                        }
                        if (fourthPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsRearPicString serviceCenter:nil toAddress:fourthPhoneNumber];
                        }
                        if (fifthPhoneNumber != nil) {
                            [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsRearPicString serviceCenter:nil toAddress:fifthPhoneNumber];
                        }
                        HBLogDebug(@"sms sent");
                        NSFileManager *manager = [NSFileManager defaultManager];
                        [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefPic.jpg"] error:nil];
                    }];
            }
        }

        __block NSMutableString *smsString = [[NSMutableString alloc] init];

        if (smsCustomText != nil && ![smsCustomText isEqual:@""]) {
            [smsString appendString:[NSString stringWithFormat:@"%@\n\n", smsCustomText]];
        }

        [smsString appendString:@"This SMS was sent by PickPocket for the following reason:\n"];
        [smsString appendString:reason];

        if (smsTime) {
    		NSDate *now = [NSDate date];
    		NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    		[outputFormatter setDateFormat:@"EEEE, d MMMM yyyy HH:mm:ss"];
    		NSString *dateString = [outputFormatter stringFromDate:now];
    		[smsString appendString:[NSString stringWithFormat:@"\n\nTime: %@", dateString]];
    		[outputFormatter release];
    	}

    	if (smsDeviceDetails) {
    		NSString *deviceModel = getDeviceModel();
            [smsString appendString:[NSString stringWithFormat:@"\n\nDevice Model: %@", deviceModel]];
            [smsString appendString:[NSString stringWithFormat:@"\niOS Version: %@", [[UIDevice currentDevice] systemVersion]]];
            [smsString appendString:[NSString stringWithFormat:@"\nDevice Name: %@", [[UIDevice currentDevice] name]]];
    	}

    	if (smsBattery) {
    		[[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    		CGFloat currentLevel = (CGFloat)[[UIDevice currentDevice] batteryLevel] * 100;
            [smsString appendString:[NSString stringWithFormat:@"\n\nBattery Level: %f", currentLevel]];
    	}

        if (smsLocation && infoStatstInstalled) {
            [smsString appendString:[NSString stringWithFormat:@"\n\nLocation Details:"]];
            CGFloat currentLatitude = [objc_getClass("IS2Location") currentLatitude];
            CGFloat currentLongitude = [objc_getClass("IS2Location") currentLongitude];
            [smsString appendString:[NSString stringWithFormat:@"\nLatitude: %f", currentLatitude]];
            [smsString appendString:[NSString stringWithFormat:@"\nLongitude: %f", currentLongitude]];

            CLLocation *actualLocation = [[CLLocation alloc] initWithLatitude:currentLatitude longitude:currentLongitude];
            CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
            [geoCoder reverseGeocodeLocation:actualLocation completionHandler: ^(NSArray *placemarks, NSError *error) {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable) {
                    [smsString appendString:[NSString stringWithFormat:@"\nFailed getting the detailed location: No Internet connection detected..."]];
                } else {
                    [smsString appendString:[NSString stringWithFormat:@"\nDetailed Location %@", locatedAt]];
                }
                [smsString appendString:[NSString stringWithFormat:@"\nGoogle Map: http://maps.google.com/maps?q=%f,%f", currentLatitude, currentLongitude]];

                if (firstPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsString serviceCenter:nil toAddress:firstPhoneNumber];
                }
                if (secondPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsString serviceCenter:nil toAddress:secondPhoneNumber];
                }
                if (thirdPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsString serviceCenter:nil toAddress:thirdPhoneNumber];
                }
                if (fourthPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsString serviceCenter:nil toAddress:fourthPhoneNumber];
                }
                if (fifthPhoneNumber != nil) {
                    [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsString serviceCenter:nil toAddress:fifthPhoneNumber];
                }
                HBLogDebug(@"sms sent");
            }];
        } else {
            if (firstPhoneNumber != nil) {
                [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsString serviceCenter:nil toAddress:firstPhoneNumber];
            }
            if (secondPhoneNumber != nil) {
                [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsString serviceCenter:nil toAddress:secondPhoneNumber];
            }
            if (thirdPhoneNumber != nil) {
                [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsString serviceCenter:nil toAddress:thirdPhoneNumber];
            }
            if (fourthPhoneNumber != nil) {
                [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsString serviceCenter:nil toAddress:fourthPhoneNumber];
            }
            if (fifthPhoneNumber != nil) {
                [[CTMessageCenter sharedMessageCenter] sendSMSWithText:smsString serviceCenter:nil toAddress:fifthPhoneNumber];
            }
            HBLogDebug(@"sms sent");
        }
    }
}

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    if (enabled) {
        showingLSFirstTime = TRUE;

        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *pathForFile = @"/Library/MobileSubstrate/DynamicLibraries/InfoStats2.dylib";
        if ([fileManager fileExistsAtPath:pathForFile]) {
            infoStatstInstalled = TRUE;
        }
    }
}

- (_Bool)_handlePhysicalButtonEvent:(UIPressesEvent *)arg1 {
    if (enabled) {
        int type = arg1.allPresses.allObjects[0].type;
        int force = arg1.allPresses.allObjects[0].force;

        if (type == 101 && force == 0) {
            hardResetTestHomeButton = FALSE;
            if (hardResetAttempted || isInFakeShutdownMode || lockButtonWasHeld) {
                return nil;
            } else {
                return %orig;
            }

        } else if (type == 101 && force == 1) {
            hardResetTestHomeButton = TRUE;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                hardResetTestHomeButton = FALSE;
            });
            if (hardResetAttempted || isInFakeShutdownMode || lockButtonWasHeld) {
                return nil;
            } else {
                return %orig;
            }

        } else if (type == 104 && force == 0) {
            if (hardResetAttempted || isInFakeShutdownMode || lsViewIsShown) {
                return nil;
            } else {
                return %orig;
            }

        } else if (type == 104 && force == 1) {
            if (hardResetAttempted || isInFakeShutdownMode || lsViewIsShown) {
                return nil;
            } else {
                return %orig;
            }
        } else {
            return %orig;
        }
    } else {
        return %orig;
    }
}

- (void)powerDownCanceled:(id)arg1 {
	HBLogDebug(@"Cancel button / arg1 = %@", arg1);
	%orig;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    lockButtonWasHeld = FALSE;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (enabled) {
            if (protectedShutdownType == 1) {
            	if (!shutdownProgramaticallyCanceled) {
            		if (shutdownWrongPasswordEntered == TRUE) {
            	        shutdownTotalWrongPassword++;
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                            if (shutdownSaveFrontPic) {
                                #pragma clang diagnostic push
                                #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                                #pragma clang diagnostic pop
                                UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefFrontPic.jpg"];
                                UIImageWriteToSavedPhotosAlbum(frontPic, nil, nil, nil);
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                    NSFileManager *manager = [NSFileManager defaultManager];
                                    [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefFrontPic.jpg"] error:nil];
                                });
                            }
                            if (shutdownSaveRearPic) {
                                #pragma clang diagnostic push
                                #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                                #pragma clang diagnostic pop
                                UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefRearPic.jpg"];
                                UIImageWriteToSavedPhotosAlbum(rearPic, nil, nil, nil);
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                    NSFileManager *manager = [NSFileManager defaultManager];
                                    [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefRearPic.jpg"] error:nil];
                                });
                            }
                        });
            	    }
            	    if (shutdownTotalWrongPassword >= shutdownAuthorizedPassword) {
                        isRinging = TRUE;
                        shutdownTotalWrongPassword = 0;
                        if (!isHeadsetPluggedIn()) {
                            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            	            [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
                        }
                        if (shutdownAlarmType == 1) {
                            shutdownPlayer.numberOfLoops = -1;
                            [shutdownPlayer play];
                        } else if (shutdownAlarmType == 2) {
                            [synthesizer speakUtterance:shutdownUtterance];;
                        }
            			if (shutdownPasswordEmail) {
            				sendEmail(@"Wrong Shutdown Passcode Detected!");
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (mailRepeat) {
                                    if (mailTimer == nil) {
                                        mailTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewShutdownPasscodeMail) userInfo:nil repeats:YES];
                                    }
                                }
                            });
            			}
                        if (shutdownPasswordSMS) {
                            sendSMS(@"Wrong Shutdown Passcode Detected!");
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (smsRepeat) {
                                    if (smsTimer == nil) {
                                        smsTimer = [NSTimer scheduledTimerWithTimeInterval:smsEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewShutdownPasscodeSMS) userInfo:nil repeats:YES];
                                    }
                                }
                            });
                        }
            	    }
            	}
                shutdownProgramaticallyCanceled = FALSE;
            } else if (protectedShutdownType == 2) {
                wantsToReallyShutdown = FALSE;
                if (shutdownWrongPasswordEntered) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                        if (fakeShutdownWrongPasswordSaveFrontPic) {
                            #pragma clang diagnostic push
                            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                            #pragma clang diagnostic pop
                            UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefFrontPic.jpg"];
                            UIImageWriteToSavedPhotosAlbum(frontPic, nil, nil, nil);
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                NSFileManager *manager = [NSFileManager defaultManager];
                                [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefFrontPic.jpg"] error:nil];
                            });
                        }
                        if (fakeShutdownWrongPasswordSaveRearPic) {
                            #pragma clang diagnostic push
                            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                            #pragma clang diagnostic pop
                            UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefRearPic.jpg"];
                            UIImageWriteToSavedPhotosAlbum(rearPic, nil, nil, nil);
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                NSFileManager *manager = [NSFileManager defaultManager];
                                [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefRearPic.jpg"] error:nil];
                            });
                        }
                    });
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 20.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    shutdownWrongPasswordEntered = FALSE;
                });
            }
        }
    });
}

- (void)_handleShutDownAndReboot {
	HBLogDebug(@"reboot");
	if (enabled) {
		HBLogDebug(@"1");
		if (!isBatteryEmptyFirstTime) {
			HBLogDebug(@"2");
		} else if (protectedShutdownEnabled) {
    		HBLogDebug(@"3");
    		if (!lockButtonWasHeld) {
			    HBLogDebug(@"4");
                SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
                SBLockHardwareButtonActions *lockHardwareButtonActions = springboard.lockHardwareButton.buttonActions;
                [lockHardwareButtonActions performLongPressActions];
    		} else {
    			HBLogDebug(@"5");
				//%orig;
    		}
		} else {
			HBLogDebug(@"6");
			//%orig;
		}
	} else {
		HBLogDebug(@"7");
		//%orig;
	}
}

- (_Bool)_volumeChanged:(struct __IOHIDEvent *)arg1 {
    if (enabled) {
        if (isRinging || hardResetAttempted || isInFakeShutdownMode) {
            return FALSE;
        } else {
            return %orig;
        }
    } else {
        return %orig;
    }
}

%new
-(void)pickpocketSendNewShutdownPasscodeMail {
    HBLogDebug(@"inside pickpocketSendNewShutdownPasscodeMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Wrong Shutdown Passcode Detected!");
    });
}

%new
-(void)pickpocketSendNewShutdownFingerprintMail {
    HBLogDebug(@"inside pickpocketSendNewShutdownFingerprintMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Wrong Shutdown Fingerprint Detected!");
    });
}

%new
-(void)pickpocketSendNewHardResetMail {
    HBLogDebug(@"inside pickpocketSendNewHardResetMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Hard Reset Aborted! :)");
    });
}

%new
-(void)pickpocketSendNewFakeShutdownMail {
    HBLogDebug(@"inside pickpocketSendNewFakeShutdownMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Fake Shutdown Detected!");
    });
}

%new
-(void)pickpocketSendNewShutdownPasscodeSMS {
    HBLogDebug(@"inside pickpocketSendNewShutdownPasscodeSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Wrong Shutdown Passcode Detected!");
    });
}

%new
-(void)pickpocketSendNewShutdownFingerprintSMS {
    HBLogDebug(@"inside pickpocketSendNewShutdownFingerprintSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Wrong Shutdown Fingerprint Detected!");
    });
}

%new
-(void)pickpocketSendNewHardResetSMS {
    HBLogDebug(@"inside pickpocketSendNewHardResetSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Hard Reset Aborted! :)");
    });
}

%new
-(void)pickpocketSendNewFakeShutdownSMS {
    HBLogDebug(@"inside pickpocketSendNewFakeShutdownSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Fake Shutdown Detected!");
    });
}

%end

%hook SBPowerDownController

- (void)powerDown {
    HBLogDebug(@"powerDown");
    HBLogDebug(@"lockButtonWasHeld = %d", lockButtonWasHeld);
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    CGFloat currentLevel = (CGFloat)[[UIDevice currentDevice] batteryLevel] * 100;
    if (enabled) {
        HBLogDebug(@"1");
        if (currentLevel <= 2 && !lockButtonWasHeld) {
            HBLogDebug(@"2");
            if (isBatteryEmptyFirstTime && automaticShutdownDisabled) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    isBatteryEmptyFirstTime = FALSE;
                    if (automaticShutdownType == 2) {
                        isRinging = TRUE;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIWindow *pickpocketBlackWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 5000, 5000)];
                            pickpocketBlackWindow.windowLevel = UIWindowLevelAlert + 100;
                            pickpocketBlackWindow.hidden = NO;
                            pickpocketBlackWindow.alpha = 1.0;
                            pickpocketBlackWindow.backgroundColor = [UIColor blackColor];
                            [pickpocketBlackWindow _setSecure:YES];
                            [pickpocketBlackWindow makeKeyAndVisible];
                        });

                        SBBacklightController *backlightControllerObject =  (SBBacklightController *)[objc_getClass("SBBacklightController") sharedInstance];
                        [backlightControllerObject setBacklightFactor:0.0 source:0];

                        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                        [[AVSystemController sharedAVSystemController] setVolumeTo:0.0 forCategory:@"Audio/Video"];

                        FSSwitchPanel *fsp = [FSSwitchPanel sharedPanel];
                        NSString *switchIdentifier = nil;
                        switchIdentifier = @"com.a3tweaks.switch.ringer";
                        [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                        switchIdentifier = @"com.a3tweaks.switch.vibration";
                        [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                    }
                    if (automaticShutdownEmail) {
                        sendEmail(@"Battery Almost Empty!");
                    }
                    if (automaticShutdownSMS) {
                        sendSMS(@"Battery Almost Empty!");
                    }
                });
            } else if (!automaticShutdownDisabled) {
                %orig;
            }
        } else if (protectedShutdownEnabled) {
            if (protectedShutdownType == 1) {
                HBLogDebug(@"3");
                if (!lockButtonWasHeld) {
                    HBLogDebug(@"4");
                    SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
                    SBLockHardwareButtonActions *lockHardwareButtonActions = springboard.lockHardwareButton.buttonActions;
                    [lockHardwareButtonActions performLongPressActions];
                } else {
                    HBLogDebug(@"5");
                    %orig;
                }
            } else if (protectedShutdownType == 2) {
                if (wantsToReallyShutdown) {
                    %orig;
                } else {
                    HBLogDebug(@"fake shutdown");
                    isInFakeShutdownMode = TRUE;
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                        [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
                        [shutdownPlayer stop];
                        [unlockPlayer stop];
                        [remoteActionPlayer stop];
                        [simPlayer stop];

                        __block UIActivityIndicatorView *spinner = nil;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                            spinner.frame = CGRectMake(0, 0, 24, 24);
                            spinner.hidesWhenStopped = YES;
                            SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
                            SBPowerDownController *_powerDownController = springboard.powerDownController;
                            spinner.center = CGPointMake(CGRectGetMidX(_powerDownController.view.bounds), CGRectGetMidY(_powerDownController.view.bounds));
                            [_powerDownController.view addSubview:spinner];
                            [spinner startAnimating];
                        });

                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            SBBacklightController *backlightControllerObject = (SBBacklightController *)[objc_getClass("SBBacklightController") sharedInstance];
                            [backlightControllerObject setBacklightFactor:0.0 source:0];
                            [spinner stopAnimating];
                            [spinner removeFromSuperview];
                        });

                        isRinging = TRUE;
                        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                        [[AVSystemController sharedAVSystemController] setVolumeTo:0.0 forCategory:@"Audio/Video"];

                        if (!fakeShutdownComeFromRemoteAction || !isBatteryEmptyFirstTime) {
                            FSSwitchPanel *fsp = [FSSwitchPanel sharedPanel];
                            NSString *switchIdentifier = nil;
                            if (fakeShutdownEnableDND) {
                                switchIdentifier = @"com.a3tweaks.switch.do-not-disturb";
                                [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
                            }
                            if (fakeShutdownEnableLPM) {
                                switchIdentifier = @"com.a3tweaks.switch.low-power";
                                [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
                            }
                            if (fakeShutdownDisableRinger) {
                                switchIdentifier = @"com.a3tweaks.switch.ringer";
                                [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                            }
                            if (fakeShutdownDisableVibration) {
                                switchIdentifier = @"com.a3tweaks.switch.vibration";
                                [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                            }

                            if (fakeShutdownEmail) {
                                sendEmail(@"Fake Shutdown Detected!");
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if (mailRepeat) {
                                        if (mailTimer == nil) {
                                            mailTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewFakeShutdownMail) userInfo:nil repeats:YES];
                                        }
                                    }
                                });
                            }
                            if (fakeShutdownSMS) {
                                sendSMS(@"Fake Shutdown Detected!");
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if (smsRepeat) {
                                        if (smsTimer == nil) {
                                            smsTimer = [NSTimer scheduledTimerWithTimeInterval:smsEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewFakeShutdownSMS) userInfo:nil repeats:YES];
                                        }
                                    }
                                });
                            }
                            if (fakeShutdownSaveFrontPic) {
                                #pragma clang diagnostic push
                                #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                                #pragma clang diagnostic pop
                                UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefFrontPic.jpg"];
                                UIImageWriteToSavedPhotosAlbum(frontPic, nil, nil, nil);
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                    NSFileManager *manager = [NSFileManager defaultManager];
                                    [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefFrontPic.jpg"] error:nil];
                                });
                            }
                            if (fakeShutdownSaveRearPic) {
                                #pragma clang diagnostic push
                                #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                                #pragma clang diagnostic pop
                                UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefRearPic.jpg"];
                                UIImageWriteToSavedPhotosAlbum(rearPic, nil, nil, nil);
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                    NSFileManager *manager = [NSFileManager defaultManager];
                                    [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefRearPic.jpg"] error:nil];
                                });
                            }
                        }
                    });
                }
            }
        } else {
            HBLogDebug(@"6");
            %orig;
        }
    } else {
        HBLogDebug(@"7");
        %orig;
    }
}

%new
-(void)pickpocketSendNewFakeShutdownSMS {
    HBLogDebug(@"inside pickpocketSendNewFakeShutdownSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Fake Shutdown Detected!");
    });
}

%new
-(void)pickpocketSendNewFakeShutdownMail {
    HBLogDebug(@"inside pickpocketSendNewFakeShutdownMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Fake Shutdown Detected!");
    });
}

%end

%hook SBHomeHardwareButtonActions

- (void)performLongPressActions {
    if (enabled) {
        if (isRinging || hardResetAttempted || isInFakeShutdownMode || lsViewIsShown) {
        } else {
            %orig;
        }
    } else {
        %orig;
    }
}

%end

%hook SBLockHardwareButtonActions

- (void)performLongPressActions {
    HBLogDebug(@"performLongPressActions");
    if (enabled && hardResetTestHomeButton) {
        HBLogDebug(@"hard reset attempted");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            if (hardResetEmail) {
                sendEmail(@"Hard Reset Attempted!");
            }
            if (hardResetSMS) {
                sendSMS(@"Hard Reset Attempted!");
            }
        });
        hardResetAttempted = TRUE;
        isRinging = TRUE;

        [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        [shutdownPlayer stop];
        [unlockPlayer stop];
        [remoteActionPlayer stop];
        [simPlayer stop];

        UIWindow *pickpocketBlackWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 5000, 5000)];
        pickpocketBlackWindow.windowLevel = UIWindowLevelAlert + 100;
        pickpocketBlackWindow.hidden = NO;
        pickpocketBlackWindow.alpha = 1.0;
        pickpocketBlackWindow.backgroundColor = [UIColor blackColor];
        [pickpocketBlackWindow _setSecure:YES];
        [pickpocketBlackWindow makeKeyAndVisible];

        SBBacklightController *backlightControllerObject =  (SBBacklightController *)[objc_getClass("SBBacklightController") sharedInstance];
        [backlightControllerObject setBacklightFactor:0.0 source:0];

        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVSystemController sharedAVSystemController] setVolumeTo:0.0 forCategory:@"Audio/Video"];

        FSSwitchPanel *fsp = [FSSwitchPanel sharedPanel];
        NSString *switchIdentifier = nil;
        if (hardResetEnableDND) {
            switchIdentifier = @"com.a3tweaks.switch.do-not-disturb";
            [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
        }
        if (hardResetEnableLPM) {
            switchIdentifier = @"com.a3tweaks.switch.low-power";
            [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
        }
        if (hardResetDisableRinger) {
            switchIdentifier = @"com.a3tweaks.switch.ringer";
            [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
        }
        if (hardResetDisableVibration) {
            switchIdentifier = @"com.a3tweaks.switch.vibration";
            [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
        }

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 20 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            wantToSendHardResetThings = TRUE;
            if (hardResetAttempted) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    if (hardResetEmail) {
                        sendEmail(@"Hard Reset Aborted! :)");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (mailRepeat) {
                                if (mailTimer == nil) {
                                    mailTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewHardResetMail) userInfo:nil repeats:YES];
                                }
                            }
                        });
                    }
                    if (hardResetSMS) {
                        sendSMS(@"Hard Reset Aborted! :)");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (smsRepeat) {
                                if (smsTimer == nil) {
                                    smsTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewHardResetSMS) userInfo:nil repeats:YES];
                                }
                            }
                        });
                    }
                });
            }
        });


    } else if (enabled && !lockButtonWasHeld && !hardResetTestHomeButton) {
        lockButtonWasHeld = TRUE;
        if (protectedShutdownEnabled) {
            if (protectedShutdownType == 1) {
                if (shutdownUseTouchID) {
                    shutdownProgramaticallyCanceled = FALSE;
                    __block BOOL shutdownTouchID = FALSE;
                    LAContext *myContext = [[LAContext alloc] init];
                    NSError *authError = nil;
                    NSString *myLocalizedReasonString = [NSString stringWithFormat:@"Fingerprint required to shutdown your %@", [[UIDevice currentDevice] model]];
                    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
                        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:myLocalizedReasonString reply:^(BOOL success, NSError *error) {
                            if (success) {
                                HBLogDebug(@"User is authenticated successfully");
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    %orig;
                                    HBLogDebug(@"lockButtonWasHeld = %d", lockButtonWasHeld);
                                    isRinging = FALSE;
                                    shutdownWrongPasswordEntered = FALSE;
                                    shutdownTotalWrongPassword = 0;
                                    [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
                                    [shutdownPlayer stop];
                                    [unlockPlayer stop];
                                    [remoteActionPlayer stop];
                                    [simPlayer stop];
                                    shutdownTouchID = TRUE;
                                    [mailTimer invalidate];
                                    mailTimer = nil;
                                    [smsTimer invalidate];
                                    smsTimer = nil;
                                });
                            } else {
                                __block BOOL wantsToShowShutdownScreen = TRUE;
                                switch (error.code) {
                                    case LAErrorAuthenticationFailed:
                                        HBLogDebug(@"Authentication Failed");
                                        wantsToShowShutdownScreen = FALSE;
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                                                isRinging = TRUE;
                                                lockButtonWasHeld = FALSE;
                                                shutdownTotalWrongPassword = 0;
                                                shutdownTouchID = TRUE;
                                                if (!isHeadsetPluggedIn()) {
                                                    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                                                    [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
                                                }
                                                if (shutdownAlarmType == 1) {
                                                    shutdownPlayer.numberOfLoops = -1;
                                                    [shutdownPlayer play];
                                                } else if (shutdownAlarmType == 2) {
                                                    [synthesizer speakUtterance:shutdownUtterance];;
                                                }
                                                shutdownTouchID = TRUE;
                                                if (shutdownTouchIDEmail) {
                                                    sendEmail(@"Wrong Shutdown Fingerprint Detected!");
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        if (mailRepeat) {
                                                            if (mailTimer == nil) {
                                                                mailTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewShutdownFingerprintMail) userInfo:nil repeats:YES];
                                                            }
                                                        }
                                                    });
                                                }
                                                if (shutdownTouchIDSMS) {
                                                    sendSMS(@"Wrong Shutdown Fingerprint Detected!");
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        if (smsRepeat) {
                                                            if (smsTimer == nil) {
                                                                smsTimer = [NSTimer scheduledTimerWithTimeInterval:smsEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewShutdownFingerprintSMS) userInfo:nil repeats:YES];
                                                            }
                                                        }
                                                    });
                                                }
                                            });
                                        });
                                        break;

                                    case LAErrorUserCancel:
                                        HBLogDebug(@"User pressed Cancel button");
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            shutdownTouchID = TRUE;
                                            lockButtonWasHeld = FALSE;
                                            wantsToShowShutdownScreen = FALSE;
                                            if (shutdownCancelEmail) {
                                                sendEmail(@"Touch ID Canceled!");
                                            }
                                            if (shutdownCancelSMS) {
                                                sendSMS(@"Touch ID Canceled!");
                                            }
                                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                                                if (shutdownSaveFrontPic) {
                                                    #pragma clang diagnostic push
                                                    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                                                    #pragma clang diagnostic pop
                                                    UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefFrontPic.jpg"];
                                                    UIImageWriteToSavedPhotosAlbum(frontPic, nil, nil, nil);
                                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                                        NSFileManager *manager = [NSFileManager defaultManager];
                                                        [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefFrontPic.jpg"] error:nil];
                                                    });
                                                }
                                                if (shutdownSaveRearPic) {
                                                    #pragma clang diagnostic push
                                                    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                                                    #pragma clang diagnostic pop
                                                    UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefRearPic.jpg"];
                                                    UIImageWriteToSavedPhotosAlbum(rearPic, nil, nil, nil);
                                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                                        NSFileManager *manager = [NSFileManager defaultManager];
                                                        [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefRearPic.jpg"] error:nil];
                                                    });
                                                }
                                            });
                                        });
                                        break;

                                    case LAErrorUserFallback:
                                        HBLogDebug(@"User pressed Enter Password");
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            shutdownTouchID = FALSE;
                                        });
                                        break;

                                    case LAErrorPasscodeNotSet:
                                        HBLogDebug(@"Passcode Not Set");
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            shutdownTouchID = FALSE;
                                        });
                                        break;

                                    case LAErrorTouchIDNotAvailable:
                                        HBLogDebug(@"Touch ID not available");
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            shutdownTouchID = FALSE;
                                        });
                                        break;

                                    case LAErrorTouchIDNotEnrolled:
                                        HBLogDebug(@"Touch ID not Enrolled or configured");
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            shutdownTouchID = FALSE;
                                        });
                                        break;

                                    default:
                                        HBLogDebug(@"Touch ID is not configured");
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            shutdownTouchID = FALSE;
                                        });
                                        break;
                                }
                                if (!shutdownTouchID && wantsToShowShutdownScreen) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        HBLogDebug(@"Authentication Fails");
                                        %orig;
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                            SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
                                            //SBPowerDownController *_powerDownController = MSHookIvar<SBPowerDownController*>(self, "_powerDownController");
                                            SBPowerDownController *_powerDownController = springboard.powerDownController;
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                                HBLogDebug(@"_powerDownController = %@", _powerDownController);
                                                UIAlertController *shutdownPasswordAlert = [self getShutdownPasswordAlert:_powerDownController];
                                                [_powerDownController presentViewController:shutdownPasswordAlert animated:YES completion:nil];
                                            });
                                        });
                                    });
                                }
                            }
                        }];
                    } else {
                        HBLogDebug(@"Can not evaluate Touch ID. This device doesn’t support one");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            %orig;
                            SBPowerDownController *_powerDownController = MSHookIvar<SBPowerDownController*>(self, "_powerDownController");
                            UIAlertController *shutdownPasswordAlert = [self getShutdownPasswordAlert:_powerDownController];
                            [_powerDownController presentViewController:shutdownPasswordAlert animated:YES completion:nil];
                        });
                    }
                } else {
                    %orig;
                    HBLogDebug(@"i'm here!");
                    SBPowerDownController *_powerDownController = MSHookIvar<SBPowerDownController*>(self, "_powerDownController");
                    UIAlertController *shutdownPasswordAlert = [self getShutdownPasswordAlert:_powerDownController];
                    [_powerDownController presentViewController:shutdownPasswordAlert animated:YES completion:nil];
                }
            } else {
                %orig;
                if (fakeShutdownPasswordEnabled) {
                    SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
                    SBPowerDownController *_powerDownController = springboard.powerDownController;
                    UILongPressGestureRecognizer *longPressShowPasswordPopup = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showPasswordPopup:)] autorelease];
                    longPressShowPasswordPopup.minimumPressDuration = 2.0;
                    [_powerDownController.view addGestureRecognizer:longPressShowPasswordPopup];
                }
            }
        } else {
            %orig;
        }
    } else if (enabled && lockButtonWasHeld) {
    } else {
        %orig;
    }
}


%new
-(void)pickpocketSendNewShutdownPasscodeMail {
    HBLogDebug(@"inside pickpocketSendNewShutdownPasscodeMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Wrong Shutdown Passcode Detected!");
    });
}

%new
-(void)pickpocketSendNewShutdownFingerprintMail {
    HBLogDebug(@"inside pickpocketSendNewShutdownFingerprintMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Wrong Shutdown Fingerprint Detected!");
    });
}

%new
-(void)pickpocketSendNewHardResetMail {
    HBLogDebug(@"inside pickpocketSendNewHardResetMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Hard Reset Aborted! :)");
    });
}

%new
-(void)pickpocketSendNewShutdownPasscodeSMS {
    HBLogDebug(@"inside pickpocketSendNewShutdownPasscodeSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Wrong Shutdown Passcode Detected!");
    });
}

%new
-(void)pickpocketSendNewShutdownFingerprintSMS {
    HBLogDebug(@"inside pickpocketSendNewShutdownFingerprintSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Wrong Shutdown Fingerprint Detected!");
    });
}

%new
-(void)pickpocketSendNewHardResetSMS {
    HBLogDebug(@"inside pickpocketSendNewHardResetSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Hard Reset Aborted! :)");
    });
}

%new
- (void)showPasswordPopup:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        HBLogDebug(@"showPasswordPopup");
        SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
        SBPowerDownController *_powerDownController = springboard.powerDownController;
        UIAlertController *shutdownPasswordAlert = [self getShutdownPasswordAlert:_powerDownController];
        [_powerDownController presentViewController:shutdownPasswordAlert animated:YES completion:nil];
    }
}

%new
- (UIAlertController *)getShutdownPasswordAlert:(SBPowerDownController *)_powerDownController {
    UIAlertController *shutdownPasswordAlert = [UIAlertController
                                alertControllerWithTitle:@"Enter password"
                                message:@"This is the only way to shutdown your device"
                                preferredStyle:UIAlertControllerStyleAlert];


    [shutdownPasswordAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Password", @"Password");
        textField.secureTextEntry = YES;
    }];

    UIAlertAction *resetAction = [UIAlertAction
                 actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                           style:UIAlertActionStyleDestructive
                         handler:^(UIAlertAction *action) {
                            SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
                            [springboard powerDownCanceled:_powerDownController];
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                                if (protectedShutdownType == 1) {
                                    if (shutdownPasswordCancelEmail) {
                                        sendEmail(@"Shutdown Password Canceled!");
                                    }
                                    if (shutdownPasswordCancelSMS) {
                                        sendSMS(@"Shutdown Password Canceled!");
                                    }
                                } else {
                                    if (fakeShutdownPasswordCancelEmail) {
                                        sendEmail(@"Fake Shutdown Password Canceled!");
                                    }
                                    if (fakeShutdownPasswordCancelSMS) {
                                        sendSMS(@"Fake Shutdown Password Canceled!");
                                    }
                                }
                            });
                         }];

    UIAlertAction *okAction = [UIAlertAction
                actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                          style:UIAlertActionStyleDefault
                        handler:^(UIAlertAction *action) {
                            UITextField *passwordField = shutdownPasswordAlert.textFields.firstObject;
                            NSString *password = passwordField.text;
                            NSString *rightPassword = nil;
                            if (protectedShutdownType == 1) {
                                rightPassword = shutdownPassword;
                            } else if (protectedShutdownType == 2) {
                                rightPassword = fakeShutdownPassword;
                            }
                            if ([password isEqual:rightPassword]) {
                                isRinging = FALSE;
                                shutdownWrongPasswordEntered = FALSE;
                                shutdownTotalWrongPassword = 0;
                                unlockTotalWrongPassword = 0;
                                [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
                                [shutdownPlayer stop];
                                [unlockPlayer stop];
                                [remoteActionPlayer stop];
                                [simPlayer stop];
                                [mailTimer invalidate];
                                mailTimer = nil;
                                [smsTimer invalidate];
                                smsTimer = nil;
                                if (protectedShutdownType == 2) {
                                    wantsToReallyShutdown = TRUE;
                                }
                            } else {
                                shutdownWrongPasswordEntered = TRUE;
                                SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
                                [springboard powerDownCanceled:_powerDownController];
                                if (protectedShutdownType == 2) {
                                    wantsToReallyShutdown = FALSE;
                                }
                            }
                          }];

    [shutdownPasswordAlert addAction:resetAction];
    [shutdownPasswordAlert addAction:okAction];

    return shutdownPasswordAlert;
}

%end

%hook SBScreenFlash
- (id)initWithScreen:(id)arg1 {
    if (enabled) {
        if (hardResetAttempted || isInFakeShutdownMode) {
            return nil;
        } else {
            hardResetScreenshotTest = TRUE;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                hardResetScreenshotTest = FALSE;
            });
            return %orig;
        }
    } else {
        hardResetScreenshotTest = TRUE;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            hardResetScreenshotTest = FALSE;
        });
        return %orig;
    }
}
%end

%hook SBUIPasscodeLockViewBase

- (void)resetForFailedPasscode {
    %orig;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (enabled) {
            if (unlockProtectionEnabled) {
                unlockTotalWrongPassword++;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    if (unlockSaveFrontPic) {
                        #pragma clang diagnostic push
                        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                        #pragma clang diagnostic pop
                        UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefFrontPic.jpg"];
                        UIImageWriteToSavedPhotosAlbum(frontPic, nil, nil, nil);
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            NSFileManager *manager = [NSFileManager defaultManager];
                            [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefFrontPic.jpg"] error:nil];
                        });
                    }
                    if (unlockSaveRearPic) {
                        #pragma clang diagnostic push
                        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                        #pragma clang diagnostic pop
                        UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefRearPic.jpg"];
                        UIImageWriteToSavedPhotosAlbum(rearPic, nil, nil, nil);
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            NSFileManager *manager = [NSFileManager defaultManager];
                            [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefRearPic.jpg"] error:nil];
                        });
                    }
                });

                if (unlockTotalWrongPassword >= unlockAuthorizedPassword) {
                    isRinging = TRUE;
                    unlockTotalWrongPassword = 0;
                    if (!isHeadsetPluggedIn()) {
                        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                        [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
                    }
                    if (unlockAlarmType == 1) {
                        unlockPlayer.numberOfLoops = -1;
                        [unlockPlayer play];
                    } else if (unlockAlarmType == 2) {
                        [synthesizer speakUtterance:unlockUtterance];;
                    }
                    if (unlockProtectionEmail) {
                        sendEmail(@"Wrong Unlock Password Detected!");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (mailRepeat) {
                                if (mailTimer == nil) {
                                    mailTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewUnlockPasscodeMail) userInfo:nil repeats:YES];
                                }
                            }
                        });
                    }
                    if (unlockProtectionSMS) {
                        sendSMS(@"Wrong Unlock Password Detected!");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (smsRepeat) {
                                if (smsTimer == nil) {
                                    smsTimer = [NSTimer scheduledTimerWithTimeInterval:smsEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewUnlockPasscodeSMS) userInfo:nil repeats:YES];
                                }
                            }
                        });
                    }
                }
            }
        }
    });
}

%new
-(void)pickpocketSendNewUnlockPasscodeMail {
    HBLogDebug(@"inside pickpocketSendNewUnlockPasscodeMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Wrong Unlock Password Detected!");
    });
}

%new
-(void)pickpocketSendNewUnlockPasscodeSMS {
    HBLogDebug(@"inside pickpocketSendNewUnlockPasscodeSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Wrong Unlock Password Detected!");
    });
}

%end

%hook SBDeviceLockController

- (BOOL)attemptDeviceUnlockWithPassword:(NSString *)passcode appRequested:(BOOL)requested {
    BOOL r = %orig;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (enabled && passcode != nil) {
            if (unlockProtectionEnabled) {
                if (r == 1) {
                    isRinging = FALSE;
                    unlockTotalWrongPassword = 0;
                    shutdownTotalWrongPassword = 0;
                    [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
                    [unlockPlayer stop];
                    [shutdownPlayer stop];
                    [remoteActionPlayer stop];
                    [simPlayer stop];
                    [mailTimer invalidate];
                    mailTimer = nil;
                    [smsTimer invalidate];
                    smsTimer = nil;
                }

                if (r == 0) {
                    unlockTotalWrongPassword++;
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                        if (unlockSaveFrontPic) {
                            #pragma clang diagnostic push
                        	#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    		#pragma clang diagnostic pop
                        	UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefFrontPic.jpg"];
                            UIImageWriteToSavedPhotosAlbum(frontPic, nil, nil, nil);
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                NSFileManager *manager = [NSFileManager defaultManager];
                        		[manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefFrontPic.jpg"] error:nil];
                            });
                        }
                        if (unlockSaveRearPic) {
                            #pragma clang diagnostic push
                        	#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    		#pragma clang diagnostic pop
                        	UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefRearPic.jpg"];
                            UIImageWriteToSavedPhotosAlbum(rearPic, nil, nil, nil);
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                NSFileManager *manager = [NSFileManager defaultManager];
                        		[manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefRearPic.jpg"] error:nil];
                            });
                        }
                    });
                }

                if (unlockTotalWrongPassword >= unlockAuthorizedPassword) {
                    isRinging = TRUE;
                    unlockTotalWrongPassword = 0;
                    if (!isHeadsetPluggedIn()) {
                        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                        [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
                    }
                    if (unlockAlarmType == 1) {
                        unlockPlayer.numberOfLoops = -1;
                        [unlockPlayer play];
                    } else if (unlockAlarmType == 2) {
                        [synthesizer speakUtterance:unlockUtterance];;
                    }
                    if (unlockProtectionEmail) {
                        sendEmail(@"Wrong Unlock Password Detected!");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (mailRepeat) {
                                if (mailTimer == nil) {
                                    mailTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewUnlockPasscodeMail) userInfo:nil repeats:YES];
                                }
                            }
                        });
                    }
                    if (unlockProtectionSMS) {
                        sendSMS(@"Wrong Unlock Password Detected!");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (smsRepeat) {
                                if (smsTimer == nil) {
                                    smsTimer = [NSTimer scheduledTimerWithTimeInterval:smsEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewUnlockPasscodeSMS) userInfo:nil repeats:YES];
                                }
                            }
                        });
                    }
                }
            }
        }
    });
    return r;
}

%new
-(void)pickpocketSendNewUnlockPasscodeMail {
    HBLogDebug(@"inside pickpocketSendNewUnlockPasscodeMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Wrong Unlock Password Detected!");
    });
}

%new
-(void)pickpocketSendNewUnlockPasscodeSMS {
    HBLogDebug(@"inside pickpocketSendNewUnlockPasscodeSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Wrong Unlock Password Detected!");
    });
}

%end

%hook SBDashBoardViewController

- (void)handleBiometricEvent:(unsigned long long)arg1 {
    %orig;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (enabled) {
            if (!unlockTouchIDDisabled) {
                if (arg1 == 10) {
                    if (unlockProtectionEnabled) {
                        unlockTotalWrongPassword++;
                        if (unlockTotalWrongPassword >= unlockAuthorizedPassword) {
                            isRinging = TRUE;
                            unlockTotalWrongPassword = 0;
                            if (!isHeadsetPluggedIn()) {
                                [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                                [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
                            }
                            if (unlockAlarmType == 1) {
                                unlockPlayer.numberOfLoops = -1;
                                [unlockPlayer play];
                            } else if (unlockAlarmType == 2) {
                                [synthesizer speakUtterance:unlockUtterance];;
                            }
                            if (unlockProtectionEmail) {
                                sendEmail(@"Wrong Unlock Fingerprint Detected!");
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if (mailRepeat) {
                                        if (mailTimer == nil) {
                                            mailTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewUnlockFingerprintMail) userInfo:nil repeats:YES];
                                        }
                                    }
                                });
                            }
                            if (unlockProtectionSMS) {
                                sendSMS(@"Wrong Unlock Fingerprint Detected!");
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if (smsRepeat) {
                                        if (smsTimer == nil) {
                                            smsTimer = [NSTimer scheduledTimerWithTimeInterval:smsEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewUnlockFingerprintSMS) userInfo:nil repeats:YES];
                                        }
                                    }
                                });
                            }
                        }
                        if (!unlockSavePicOnlyPassword) {
                            if (unlockSaveFrontPic) {
                                #pragma clang diagnostic push
                                #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                                #pragma clang diagnostic pop
                                UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefFrontPic.jpg"];
                                UIImageWriteToSavedPhotosAlbum(frontPic, nil, nil, nil);
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                    NSFileManager *manager = [NSFileManager defaultManager];
                                    [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefFrontPic.jpg"] error:nil];
                                });
                            }
                            if (unlockSaveRearPic) {
                                #pragma clang diagnostic push
                                #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                                #pragma clang diagnostic pop
                                UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefRearPic.jpg"];
                                UIImageWriteToSavedPhotosAlbum(rearPic, nil, nil, nil);
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                    NSFileManager *manager = [NSFileManager defaultManager];
                                    [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefRearPic.jpg"] error:nil];
                                });
                            }
                        }
                    }
                }
            }
            if (arg1 == 4) {
                if (unlockProtectionEnabled) {
                    isRinging = FALSE;
                    unlockTotalWrongPassword = 0;
                    shutdownTotalWrongPassword = 0;
                    [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
                    [unlockPlayer stop];
                    [shutdownPlayer stop];
                    [remoteActionPlayer stop];
                    [simPlayer stop];
                    [mailTimer invalidate];
                    mailTimer = nil;
                    [smsTimer invalidate];
                    smsTimer = nil;
                }
            }
        }
    });
}

%new
-(void)pickpocketSendNewUnlockFingerprintMail {
    HBLogDebug(@"inside pickpocketSendNewUnlockFingerprintMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Wrong Unlock Fingerprint Detected!");
    });
}

%new
-(void)pickpocketSendNewUnlockFingerprintSMS {
    HBLogDebug(@"inside pickpocketSendNewUnlockFingerprintSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Wrong Unlock Fingerprint Detected!");
    });
}

%end

%hook SBLockScreenManager

- (void)_finishUIUnlockFromSource:(int)arg1 withOptions:(id)arg2 {
	%orig;
	if (enabled) {
        if (showingLSFirstTime) {
            showingLSFirstTime = FALSE;
        }
        if (firstUse) {
            FBShowTwitterFollowAlert(@"PickPocket", @"Hey there! Thanks for buying PickPocket! If you'd like to follow @Ziph0n on Twitter for more updates, tweak giveaways and other cool stuff, hit the button below!", @"Ziph0n");
            firstUse = FALSE;
            [preferences setBool:firstUse forKey:@"firstUse"];
        }
		isLocked = FALSE;
		lsViewIsShown = FALSE;

        isRinging = FALSE;
        unlockTotalWrongPassword = 0;
        shutdownTotalWrongPassword = 0;
        [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        [unlockPlayer stop];
        [shutdownPlayer stop];
        [remoteActionPlayer stop];
        [simPlayer stop];
        [mailTimer invalidate];
        mailTimer = nil;
        [smsTimer invalidate];
        smsTimer = nil;
	}
}

- (void)lockUIFromSource:(int)arg1 withOptions:(id)arg2 {
	%orig;
	if (enabled) {
		isLocked = TRUE;
	}
}

%end

%hook SBDashBoardView

- (id)initWithFrame:(CGRect)arg1 {
    HBLogDebug(@"initWithFrame");
    id r = %orig;
    if (r && lsInfoEnabled) {
        pageDrawn = FALSE;
    }
    return r;
}

- (void)layoutSubviews{
    HBLogDebug(@"layoutSubviews");
    %orig;
    if (!pageDrawn && lsInfoEnabled && showingLSFirstTime) {
        HBLogDebug(@"button drawn");
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenHeight = screenRect.size.height;
        CGFloat screenWidth = screenRect.size.width;

        UIView *foregroundLockView = foregroundLockView = MSHookIvar<UIView*>(self, "_mainPageView");

        UIButton *lsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

        if ([userXPosition isEqual:@""] && ![userYPosition isEqual:@""]) {
            lsButton.frame = CGRectMake((screenWidth / 2) - 75, [userYPosition floatValue], 150, 35);
        } else if (![userXPosition isEqual:@""] && [userYPosition isEqual:@""]) {
            lsButton.frame = CGRectMake([userXPosition floatValue], screenHeight - 100, 150, 35);
        } else if (![userXPosition isEqual:@""] && ![userYPosition isEqual:@""]) {
            lsButton.frame = CGRectMake([userXPosition floatValue], [userYPosition floatValue], 150, 35);
        } else {
            lsButton.frame = CGRectMake((screenWidth / 2) - 75, screenHeight - 100, 150, 35);
        }
        [lsButton setTitle:[NSString stringWithFormat:@"Found this %@?", [[UIDevice currentDevice] model]] forState:UIControlStateNormal];
        [lsButton setTitleColor:LCPParseColorString(lsButtonColor, @"#FFFFFF") forState:UIControlStateNormal];
        [lsButton addTarget:self action:@selector(pickpocketLSButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [foregroundLockView addSubview:lsButton];

        pageDrawn = YES;
    }
}

%new
-(void)pickpocketLSButtonClicked:(id)arg1 {

    lsViewIsShown = TRUE;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGFloat screenWidth = screenRect.size.width;

    UIView *foregroundView = MSHookIvar<UIView*>(self, "_slideableContentView");

    foundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    foundView.alpha = 0.0f;
    [foregroundView addSubview:foundView];

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [blurEffectView setFrame:foundView.bounds];
    [foundView addSubview:blurEffectView];

    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:foundView.bounds];

    UIImage *userImage = [UIImage imageWithContentsOfFile:@"/var/mobile/Library/PickPocket/userImage.png"];
    if (userImage != nil) {
        userImageView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth / 2) - 1, screenHeight * 0.6, 2, 2)];
        userImageView.layer.cornerRadius = 50;
        userImageView.layer.masksToBounds = YES;
        userImageView.image = userImage;
        borderLayer = [CALayer layer];
        CGRect borderFrame = CGRectMake(0, 0, 100, 100);
        borderLayer.backgroundColor = [[UIColor clearColor] CGColor];
        borderLayer.frame = borderFrame;
        borderLayer.cornerRadius = 50;
        borderLayer.borderWidth = userBorderWidth;
        borderLayer.borderColor = [[UIColor clearColor] CGColor];

        [userImageView.layer addSublayer:borderLayer];
        [foundView addSubview:userImageView];
    }

    if (![userName isEqual:@""] || ![userSurname isEqual:@""]) {
        belongsTo = [[UILabel alloc] initWithFrame:CGRectMake(0, screenHeight * 0.10 + 120, screenWidth, 50)];
        belongsTo.text = @"The owner of this device is:";
        belongsTo.font = [UIFont systemFontOfSize:20.0f];
        belongsTo.textAlignment = NSTextAlignmentCenter;
        belongsTo.lineBreakMode = NSLineBreakByWordWrapping;
        belongsTo.alpha = 0.0f;
        belongsTo.textColor = [UIColor whiteColor];

        belongsToName = [[UILabel alloc] initWithFrame:CGRectMake(0, screenHeight * 0.10 + 160, screenWidth, 50)];
        if (userName == nil && userSurname == nil) {
            belongsToName.text = [NSString stringWithFormat:@""];
        } else if (userName != nil && userSurname == nil) {
            belongsToName.text = [NSString stringWithFormat:@"%@", userName];
        } else if (userName == nil && userSurname != nil) {
            belongsToName.text = [NSString stringWithFormat:@"%@", userSurname];
        } else {
            belongsToName.text = [NSString stringWithFormat:@"%@ %@", userName, userSurname];
        }
        belongsToName.font = [UIFont systemFontOfSize:29.0f];
        belongsToName.lineBreakMode = NSLineBreakByWordWrapping;
        belongsToName.textAlignment = NSTextAlignmentCenter;
        belongsToName.alpha = 0.0f;
        belongsToName.textColor = [UIColor whiteColor];
    }

    livesIn = [[UILabel alloc] initWithFrame:CGRectMake(30, screenHeight * 0.45, screenWidth - 60, 80)];
    if ((userCity == nil && userCountry == nil) || ([userCity isEqual:@""] && [userCountry isEqual:@""])) {
        livesIn.text = [NSString stringWithFormat:@"Please tap on one of the buttons below to call or send an E-Mail.\nThanks in advance!"];
    } else if ((userCity != nil && userCountry == nil) || (![userCity isEqual:@""] && [userCountry isEqual:@""])) {
        livesIn.text = [NSString stringWithFormat:@"I live in %@\nPlease tap on one of the buttons below to call or send an E-Mail.\nThanks in advance!", userCity];
    } else if ((userCity == nil && userCountry != nil) || ([userCity isEqual:@""] && ![userCountry isEqual:@""])) {
        livesIn.text = [NSString stringWithFormat:@"I live in %@\nPlease tap on one of the buttons below to call or send an E-Mail.\nThanks in advance!", userCountry];
    } else {
        livesIn.text = [NSString stringWithFormat:@"I live in %@, %@\nPlease tap on one of the buttons below to call or send an E-Mail.\nThanks in advance!", userCity, userCountry];
    }
    livesIn.font = [UIFont systemFontOfSize:20.0f];
    livesIn.numberOfLines = 0;
    livesIn.lineBreakMode = NSLineBreakByWordWrapping;
    livesIn.textAlignment = NSTextAlignmentCenter;
    livesIn.alpha = 0.0f;
    livesIn.textColor = [UIColor whiteColor];

    callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *callImage = [UIImage imageWithContentsOfFile:@"/Library/Application Support/PickPocket/Images/call.png"];
    callButton.frame = CGRectMake(0, screenHeight * 0.65, 64, 64);
    [callButton addTarget:self action:@selector(pickpocketCallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [callButton setImage:callImage forState:UIControlStateNormal];
    callButton.contentMode = UIViewContentModeScaleToFill;
    callButton.alpha = 0.0f;
    [foundView addSubview:callButton];

    callLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, screenHeight * 0.65 + 70, 64, 64)];
    callLabel.text = @"Call";
    callLabel.font = [UIFont systemFontOfSize:22.0f];
    callLabel.textAlignment = NSTextAlignmentCenter;
    callLabel.alpha = 0.0f;
    callLabel.textColor = [UIColor whiteColor];


    mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *mailImage = [UIImage imageWithContentsOfFile:@"/Library/Application Support/PickPocket/Images/mail.png"];
    mailButton.frame = CGRectMake(screenWidth - 80, screenHeight * 0.65, 64, 64);
    [mailButton addTarget:self action:@selector(pickpocketMailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [mailButton setImage:mailImage forState:UIControlStateNormal];
    mailButton.contentMode = UIViewContentModeScaleToFill;
    mailButton.alpha = 0.0f;
    [foundView addSubview:mailButton];

    mailLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 80, screenHeight * 0.65 + 70, 64, 64)];
    mailLabel.text = @"Email";
    mailLabel.font = [UIFont systemFontOfSize:22.0f];
    mailLabel.textAlignment = NSTextAlignmentCenter;
    mailLabel.alpha = 0.0f;
    mailLabel.textColor = [UIColor whiteColor];

    if (userTextType == 1) {
        if (![userName isEqual:@""] || ![userSurname isEqual:@""]) {
            [[vibrancyEffectView contentView] addSubview:belongsTo];
            [[vibrancyEffectView contentView] addSubview:belongsToName];
        }
        [[vibrancyEffectView contentView] addSubview:livesIn];
        [[vibrancyEffectView contentView] addSubview:callLabel];
        [[vibrancyEffectView contentView] addSubview:mailLabel];
    } else {
        if (![userName isEqual:@""] || ![userSurname isEqual:@""]) {
            [foundView addSubview:belongsTo];
            [foundView addSubview:belongsToName];
        }
        [foundView addSubview:livesIn];
        [foundView addSubview:callLabel];
        [foundView addSubview:mailLabel];
    }

    [[blurEffectView contentView] addSubview:vibrancyEffectView];


    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    if ([userCloseXPosition isEqual:@""] && ![userCloseYPosition isEqual:@""]) {
        closeButton.frame = CGRectMake((screenWidth / 2) - 75, [userYPosition floatValue], 150, 35);
    } else if (![userCloseXPosition isEqual:@""] && [userCloseYPosition isEqual:@""]) {
        closeButton.frame = CGRectMake([userXPosition floatValue], screenHeight - 100, 150, 35);
    } else if (![userCloseXPosition isEqual:@""] && ![userCloseYPosition isEqual:@""]) {
        closeButton.frame = CGRectMake([userXPosition floatValue], [userYPosition floatValue], 150, 35);
    } else {
        closeButton.frame = CGRectMake((screenWidth / 2) - 75, screenHeight - 100, 150, 35);
    }

    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(pickpocketFoundViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [foundView addSubview:closeButton];

    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        foundView.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];

    [UIView animateWithDuration:0.7 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        userImageView.frame = CGRectMake((screenWidth / 2) - 50, screenHeight * 0.10, 100, 100);
    } completion:^(BOOL finished) {
        borderLayer.borderColor = [[UIColor whiteColor] CGColor];
    }];

    [UIView animateWithDuration:0.6 delay:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
        belongsTo.alpha = 1.0f;
        belongsToName.alpha = 1.0f;
        livesIn.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            callButton.alpha = 1.0f;
            callLabel.alpha = 1.0f;
            mailButton.alpha = 1.0f;
            mailLabel.alpha = 1.0f;
            callButton.frame = CGRectMake((screenWidth / 4) - 40, screenHeight * 0.65, 64, 64);
            callLabel.frame = CGRectMake((screenWidth / 4) - 40, screenHeight * 0.65 + 70, 64, 64);
            mailButton.frame = CGRectMake(((3 * screenWidth) / 4) - 40, screenHeight * 0.65, 64, 64);
            mailLabel.frame = CGRectMake(((3 * screenWidth) / 4) - 40, screenHeight * 0.65 + 70, 64, 64);
        } completion:^(BOOL finished) {
        }];
    }];
}

%new
-(void)pickpocketFoundViewButtonClicked:(id)arg1 {

    lsViewIsShown = FALSE;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGFloat screenWidth = screenRect.size.width;

    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        callButton.alpha = 0.0f;
        callLabel.alpha = 0.0f;
        mailButton.alpha = 0.0f;
        mailLabel.alpha = 0.0f;
        callButton.frame = CGRectMake(0, screenHeight * 0.65, 64, 64);
        callLabel.frame = CGRectMake(0, screenHeight * 0.65 + 70, 64, 64);
        mailButton.frame = CGRectMake(screenWidth - 80, screenHeight * 0.65, 64, 64);
        mailLabel.frame = CGRectMake(screenWidth - 80, screenHeight * 0.65 + 70, 64, 64);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            belongsTo.alpha = 0.0f;
            belongsToName.alpha = 0.0f;
            livesIn.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
                foundView.alpha = 0.0f;
            } completion:^(BOOL finished) {
            }];
        }];
    }];

    [UIView animateWithDuration:0.6 delay:0.9 options:UIViewAnimationOptionCurveEaseIn animations:^{
        userImageView.frame = CGRectMake((screenWidth / 2) - 1, screenHeight * 0.6, 2, 2);
        borderLayer.borderColor = [[UIColor clearColor] CGColor];
    } completion:^(BOOL finished) {
    }];
}


%new
-(void)pickpocketCallButtonClicked:(id)arg1 {
    if (userNumberToCall == nil) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@":("
                                                        message:@"The owner of this device forgot to mention his phone number :("
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        #pragma clang diagnostic pop
    } else {
        NSString *urlToCall = [NSString stringWithFormat:@"tel:%@", userNumberToCall];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlToCall]];
    }
}

%new
-(void)pickpocketMailButtonClicked:(id)arg1 {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        sendEmail(@"This device has been found!");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (mailRepeat) {
                if (mailTimer == nil) {
                    mailTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewDeviceFoundMail) userInfo:nil repeats:YES];
                }
            }
        });
        if (userSendSMS) {
            sendSMS(@"This device has been found!");
            dispatch_async(dispatch_get_main_queue(), ^{
                if (smsRepeat) {
                    if (smsTimer == nil) {
                        smsTimer = [NSTimer scheduledTimerWithTimeInterval:smsEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewDeviceFoundSMS) userInfo:nil repeats:YES];
                    }
                }
            });
        }
    });
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you! <3"
                                                    message:@"An email has been sent. Thanks for your help!"
                                                   delegate:nil
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    #pragma clang diagnostic pop
}

%new
-(void)pickpocketSendNewDeviceFoundMail {
    HBLogDebug(@"inside pickpocketSendNewDeviceFoundMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: This device has been found!");
    });
}

%new
-(void)pickpocketSendNewDeviceFoundSMS {
    HBLogDebug(@"inside pickpocketSendNewDeviceFoundSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: This device has been found!");
    });
}

%end

%hook SBBacklightController
- (void)animateBacklightToFactor:(float)arg1 duration:(double)arg2 source:(int)arg3 completion:(id)arg4 {
    if (!lsViewIsShown) {
        %orig;
    }
}
%end

%hook SBVolumeHUDView
- (id)init {
    if (enabled && isRinging) {
        return nil;
    } else {
        return %orig;
    }
}
%end

%hook SBRingerHUDView
- (id)init {
    if (enabled) {
        if (isRinging || hardResetAttempted) {
            return nil;
        } else {
            return %orig;
        }
    } else {
        return %orig;
    }
}
%end

%hook SBTelephonyManager

- (void)setIsInAirplaneMode:(BOOL)arg1 {
	HBLogDebug(@"setIsInAirplaneMode")
	if (enabled && airplaneModeEnabled) {
		BOOL hasBeenBlocked = FALSE;
		if (airplaneModeType == 1) {
			if (isLocked) {
				hasBeenBlocked = TRUE;
			} else {
				%orig;
			}
		} else if (airplaneModeType == 2) {
			if (isRinging || hardResetAttempted || isInFakeShutdownMode) {
				hasBeenBlocked = TRUE;
			} else {
				%orig;
			}
		} else if (airplaneModeType == 3) {
			hasBeenBlocked = TRUE;
		}
		if (hasBeenBlocked && !airplaneModeProgrammaticallyControlled && airplaneModeTest) {
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                airplaneModeTest = FALSE;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    airplaneModeTest = TRUE;
                });
				if (airplaneModeEmail) {
                    sendEmail(@"Airplane Mode Blocked!");
                }
                if (airplaneModeSMS) {
                    sendSMS(@"Airplane Mode Blocked!");
                }
            });
		}
	} else {
		%orig;
	}
}

%end

%hook SBCCAirplaneModeSetting

- (_Bool)_toggleState {
	HBLogDebug(@"_toggleState");
	if (enabled && airplaneModeEnabled) {
		BOOL hasBeenBlocked = FALSE;
		if (airplaneModeType == 1) {
			if (isLocked) {
				hasBeenBlocked = TRUE;
			}
		} else if (airplaneModeType == 2) {
			if (isRinging || hardResetAttempted || isInFakeShutdownMode) {
				hasBeenBlocked = TRUE;
			}
		} else if (airplaneModeType == 3) {
			hasBeenBlocked = TRUE;
		}
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
			if (hasBeenBlocked && !airplaneModeProgrammaticallyControlled && airplaneModeTest) {
                airplaneModeTest = FALSE;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    airplaneModeTest = TRUE;
                });
				if (airplaneModeEmail) {
                    sendEmail(@"Airplane Mode Blocked!");
	               }
	            if (airplaneModeSMS) {
	                sendSMS(@"Airplane Mode Blocked!");
	            }
			}
        });
        if (hasBeenBlocked) {
			return nil;
        } else {
        	return %orig;
        }
	} else {
		return %orig;
	}
}

%end

%hook SBSIMLockManager

- (void)_updateToStatus:(long long)arg1 {
	if (simEnabled) {
		if (arg1 == 3) { //3 = No SIM Card
			if (wantsToDoSIMThings) {
				wantsToDoSIMThings = FALSE;
				dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 30.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
					wantsToDoSIMThings = TRUE;
				});
				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
					if (simAlarmType == 1) {
						isRinging = TRUE;
						if (!isHeadsetPluggedIn()) {
		                	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
		                    [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
		                }
		                simPlayer.numberOfLoops = -1;
		                [simPlayer play];
					} else if (simAlarmType == 2) {
						isRinging = TRUE;
						if (!isHeadsetPluggedIn()) {
		                	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
		                    [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
		                }
		                [synthesizer speakUtterance:simUtterance];;
					}
					if (simEmail) {
						sendEmail(@"SIM Card Pulled!");
						dispatch_async(dispatch_get_main_queue(), ^{
							if (mailRepeat) {
								if (mailTimer == nil) {
									mailTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewSIMMail) userInfo:nil repeats:YES];
								}
							}
						});
					}
					if (simSMS) {
						sendSMS(@"SIM Card Pulled!");
						dispatch_async(dispatch_get_main_queue(), ^{
							if (smsRepeat) {
								if (smsTimer == nil) {
									smsTimer = [NSTimer scheduledTimerWithTimeInterval:smsEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewSIMSMS) userInfo:nil repeats:YES];
								}
							}
						});
					}
				});
			}
		} else if (arg1 == 2) {
			isRinging = FALSE;
	        unlockTotalWrongPassword = 0;
	        shutdownTotalWrongPassword = 0;
	        [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        	[unlockPlayer stop];
	        [shutdownPlayer stop];
	        [remoteActionPlayer stop];
	        [simPlayer stop];
	        [mailTimer invalidate];
	        mailTimer = nil;
	        [smsTimer invalidate];
	        smsTimer = nil;
		}
	}
	%orig;
}

-(void)pickpocketSendNewSIMMail {
    HBLogDebug(@"inside pickpocketSendNewSIMMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: SIM Card Pulled!");
    });
}

%new
-(void)pickpocketSendNewSIMSMS {
    HBLogDebug(@"inside pickpocketSendNewSIMSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: SIM Card Pulled!");
    });
}

%end

%hook BBServer

- (void)publishBulletin:(BBBulletin*)bulletin destinations:(unsigned long long)arg2 alwaysToLockScreen:(BOOL)arg3 {
    if (enabled) {
        BOOL remoteAction = FALSE;
        NSString *message = bulletin.message;
        NSString *sectionID = bulletin.sectionID;
        HBLogDebug(@"sectionID = %@ / message = %@", sectionID, message);
        if ([sectionID isEqual:@"com.apple.MobileSMS"]) {
            if (message != nil) {
                if (remoteActionStringType == 1) {

                    HBLogDebug(@"remoteActionPlayAlarmEnabled = %d", remoteActionPlayAlarmEnabled);
                    HBLogDebug(@"remoteActionPlayAlarmString = %@", remoteActionPlayAlarmString);
                    HBLogDebug(@"isInFakeShutdownMode = %d", isInFakeShutdownMode);
                    HBLogDebug(@"hardResetAttempted = %d", hardResetAttempted);
                    HBLogDebug(@"firstRemoteTest = %d", firstRemoteTest);

                    if (remoteActionPlayAlarmEnabled && remoteActionPlayAlarmString != nil && !isInFakeShutdownMode && !hardResetAttempted && firstRemoteTest) {
                    	firstRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		firstRemoteTest = TRUE;
                    	});
                        if ([message isEqual:remoteActionPlayAlarmString]) {
                            isRinging = TRUE;
                            NSString *remoteActionAlarmFilePath = [NSString stringWithFormat:@"/Library/Application Support/PickPocket/Sounds/%@", remoteActionAlarm];
                            NSURL *remoteActionAlarmFileURL = [NSURL fileURLWithPath:remoteActionAlarmFilePath];
                        	remoteActionPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:remoteActionAlarmFileURL error:nil];
                            if (!isHeadsetPluggedIn()) {
                                [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                                [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
                            }
                            remoteActionPlayer.numberOfLoops = -1;
                            [remoteActionPlayer play];
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionStopAlarmEnabled && remoteActionStopAlarmString != nil && secondRemoteTest) {
                    	secondRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		secondRemoteTest = TRUE;
                    	});
                        if ([message isEqual:remoteActionStopAlarmString]) {
                            [shutdownPlayer stop];
                            [unlockPlayer stop];
                            [remoteActionPlayer stop];
                            [simPlayer stop];
                            isRinging = FALSE;
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionPlaySpeechEnabled && remoteActionSpeechString != nil && !isInFakeShutdownMode && !hardResetAttempted && (thirdRemoteTest || ![message isEqual:lastSpeechMessage])) {
                    	thirdRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		thirdRemoteTest = TRUE;
                    	});
                        if ([message rangeOfString:remoteActionSpeechString].location != NSNotFound) {
                        	lastSpeechMessage = message;
                            isRinging = TRUE;
                            if (!isHeadsetPluggedIn()) {
                                [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                                [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
                            }
                            isRinging = FALSE;
                            AVSpeechSynthesizer *remoteActionSynthesizer = [[AVSpeechSynthesizer alloc] init];
                            AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:[[NSLocale currentLocale] localeIdentifier]];

                            NSError *error = nil;
                            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([\"])(?:\\\\\\1|.)*?\\1" options:0 error:&error];
                            NSRange range = [regex rangeOfFirstMatchInString:message options:0 range:NSMakeRange(0, [message length])];
                            NSString *speech = nil;
                            if (range.location == NSNotFound) {
                                speech = remoteActionSpeech;
                            } else {
                                speech = [message substringWithRange:range];
                            }
                            AVSpeechUtterance *remoteActionUtterance = [[AVSpeechUtterance alloc] initWithString:stringByStrippingHTML(speech)];
                            remoteActionUtterance.voice = voice;
                            remoteActionUtterance.rate = AVSpeechUtteranceDefaultSpeechRate;
                            [remoteActionSynthesizer speakUtterance:remoteActionUtterance];
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionFakeShutdownEnabled && remoteActionFakeShutdownString != nil && fourthRemoteTest) {
                    	fourthRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		fourthRemoteTest = TRUE;
                    	});
                        if ([message isEqual:remoteActionFakeShutdownString]) {
                        	isRinging = TRUE;
                            isInFakeShutdownMode = TRUE;
                        	dispatch_async(dispatch_get_main_queue(), ^{
    							UIWindow *pickpocketBlackWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 5000, 5000)];
    	                        pickpocketBlackWindow.windowLevel = UIWindowLevelAlert + 100;
    	                    	pickpocketBlackWindow.hidden = NO;
    	                        pickpocketBlackWindow.alpha = 1.0;
    	                    	pickpocketBlackWindow.backgroundColor = [UIColor blackColor];
    	                        [pickpocketBlackWindow _setSecure:YES];
    	                        [pickpocketBlackWindow makeKeyAndVisible];
    	                    });

    	                    SBBacklightController *backlightControllerObject = (SBBacklightController *)[objc_getClass("SBBacklightController") sharedInstance];
                            [backlightControllerObject setBacklightFactor:0.0 source:0];

    						[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                            [[AVSystemController sharedAVSystemController] setVolumeTo:0.0 forCategory:@"Audio/Video"];

                            FSSwitchPanel *fsp = [FSSwitchPanel sharedPanel];
                            NSString *switchIdentifier = nil;
                            switchIdentifier = @"com.a3tweaks.switch.ringer";
                            [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                            switchIdentifier = @"com.a3tweaks.switch.vibration";
                            [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionFrontPicEnabled && remoteActionFrontPicString != nil && fifthRemoteTest) {
                    	fifthRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		fifthRemoteTest = TRUE;
                    	});
                        if ([message isEqual:remoteActionFrontPicString]) {
                            #pragma clang diagnostic push
                            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                            #pragma clang diagnostic pop
                            UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefFrontPic.jpg"];
                            UIImageWriteToSavedPhotosAlbum(frontPic, nil, nil, nil);
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                NSFileManager *manager = [NSFileManager defaultManager];
                                [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefFrontPic.jpg"] error:nil];
                            });
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionRearPicEnabled && remoteActionRearPicString != nil && sixthRemoteTest) {
                    	sixthRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		sixthRemoteTest = TRUE;
                    	});
                        if ([message isEqual:remoteActionRearPicString]) {
                            #pragma clang diagnostic push
                            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                            #pragma clang diagnostic pop
                            UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefRearPic.jpg"];
                            UIImageWriteToSavedPhotosAlbum(rearPic, nil, nil, nil);
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                NSFileManager *manager = [NSFileManager defaultManager];
                                [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefRearPic.jpg"] error:nil];
                            });
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionSendEnabled && remoteActionSendString != nil && seventhRemoteTest) {
                        seventhRemoteTest = FALSE;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            seventhRemoteTest = TRUE;
                        });
                        if ([message isEqual:remoteActionSendString]) {
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionRespringEnabled && remoteActionRespringString != nil && eighthRemoteTest) {
                        eighthRemoteTest = FALSE;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            eighthRemoteTest = TRUE;
                        });
                        if ([message isEqual:remoteActionRespringString]) {
                            #pragma clang diagnostic push
                            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                            #pragma clang diagnostic pop
                            remoteAction = TRUE;
                        }
                    }

                } else {
                    if (remoteActionPlayAlarmEnabled && remoteActionPlayAlarmString != nil && !isInFakeShutdownMode && !hardResetAttempted && firstRemoteTest) {
                    	firstRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		firstRemoteTest = TRUE;
                    	});
                        if ([message rangeOfString:remoteActionPlayAlarmString].location != NSNotFound) {
                            isRinging = TRUE;
                            NSString *remoteActionAlarmFilePath = [NSString stringWithFormat:@"/Library/Application Support/PickPocket/Sounds/%@", remoteActionAlarm];
                            NSURL *remoteActionAlarmFileURL = [NSURL fileURLWithPath:remoteActionAlarmFilePath];
                        	remoteActionPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:remoteActionAlarmFileURL error:nil];
                            if (!isHeadsetPluggedIn()) {
                                [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                                [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
                            }
                            remoteActionPlayer.numberOfLoops = -1;
                            [remoteActionPlayer play];
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionStopAlarmEnabled && remoteActionStopAlarmString != nil && secondRemoteTest) {
                    	secondRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		secondRemoteTest = TRUE;
                    	});
                        if ([message rangeOfString:remoteActionStopAlarmString].location != NSNotFound) {
                            [shutdownPlayer stop];
                            [unlockPlayer stop];
                            [remoteActionPlayer stop];
                            [simPlayer stop];
                            isRinging = FALSE;
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionPlaySpeechEnabled && remoteActionSpeechString != nil && !isInFakeShutdownMode && !hardResetAttempted && (thirdRemoteTest || ![message isEqual:lastSpeechMessage])) {
                    	thirdRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		thirdRemoteTest = TRUE;
                    	});
                        if ([message rangeOfString:remoteActionSpeechString].location != NSNotFound) {
                        	lastSpeechMessage = message;
                            isRinging = TRUE;
                            if (!isHeadsetPluggedIn()) {
                                [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                                [[AVSystemController sharedAVSystemController] setVolumeTo:1.0 forCategory:@"Audio/Video"];
                            }
                            isRinging = FALSE;
                            AVSpeechSynthesizer *remoteActionSynthesizer = [[AVSpeechSynthesizer alloc] init];
                            AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:[[NSLocale currentLocale] localeIdentifier]];

                            NSError *error = nil;
                            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([\"])(?:\\\\\\1|.)*?\\1" options:0 error:&error];
                            NSRange range = [regex rangeOfFirstMatchInString:message options:0 range:NSMakeRange(0, [message length])];
                            NSString *speech = nil;
                            if (range.location == NSNotFound) {
                                speech = remoteActionSpeech;
                            } else {
                                speech = [message substringWithRange:range];
                            }
                            AVSpeechUtterance *remoteActionUtterance = [[AVSpeechUtterance alloc] initWithString:stringByStrippingHTML(speech)];
                            remoteActionUtterance.voice = voice;
                            remoteActionUtterance.rate = AVSpeechUtteranceDefaultSpeechRate;
                            [remoteActionSynthesizer speakUtterance:remoteActionUtterance];
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionFakeShutdownEnabled && remoteActionFakeShutdownString != nil && fourthRemoteTest) {
                    	fourthRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		fourthRemoteTest = TRUE;
                    	});
                        if ([message rangeOfString:remoteActionFakeShutdownString].location != NSNotFound) {
                            isRinging = TRUE;
                            isInFakeShutdownMode = TRUE;
                        	dispatch_async(dispatch_get_main_queue(), ^{
    							UIWindow *pickpocketBlackWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 5000, 5000)];
    	                        pickpocketBlackWindow.windowLevel = UIWindowLevelAlert + 100;
    	                    	pickpocketBlackWindow.hidden = NO;
    	                        pickpocketBlackWindow.alpha = 1.0;
    	                    	pickpocketBlackWindow.backgroundColor = [UIColor blackColor];
    	                        [pickpocketBlackWindow _setSecure:YES];
    	                        [pickpocketBlackWindow makeKeyAndVisible];
    	                    });

    	                    SBBacklightController *backlightControllerObject =  (SBBacklightController *)[objc_getClass("SBBacklightController") sharedInstance];
                            [backlightControllerObject setBacklightFactor:0.0 source:0];

    						[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                            [[AVSystemController sharedAVSystemController] setVolumeTo:0.0 forCategory:@"Audio/Video"];

                            FSSwitchPanel *fsp = [FSSwitchPanel sharedPanel];
                            NSString *switchIdentifier = nil;
                            switchIdentifier = @"com.a3tweaks.switch.ringer";
                            [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                            switchIdentifier = @"com.a3tweaks.switch.vibration";
                            [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionFrontPicEnabled && remoteActionFrontPicString != nil && fifthRemoteTest) {
    					fifthRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		fifthRemoteTest = TRUE;
                    	});
                        if ([message rangeOfString:remoteActionFrontPicString].location != NSNotFound) {
                            #pragma clang diagnostic push
                            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                            #pragma clang diagnostic pop
                            UIImage *frontPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefFrontPic.jpg"];
                            UIImageWriteToSavedPhotosAlbum(frontPic, nil, nil, nil);
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                NSFileManager *manager = [NSFileManager defaultManager];
                                [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefFrontPic.jpg"] error:nil];
                            });
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionRearPicEnabled && remoteActionRearPicString != nil && sixthRemoteTest) {
                    	sixthRemoteTest = FALSE;
                    	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    		sixthRemoteTest = TRUE;
                    	});
                        if ([message rangeOfString:remoteActionRearPicString].location != NSNotFound) {
                            #pragma clang diagnostic push
                            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                            #pragma clang diagnostic pop
                            UIImage *rearPic = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/thiefRearPic.jpg"];
                            UIImageWriteToSavedPhotosAlbum(rearPic, nil, nil, nil);
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                NSFileManager *manager = [NSFileManager defaultManager];
                                [manager removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thiefRearPic.jpg"] error:nil];
                            });
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionSendEnabled && remoteActionSendString != nil && seventhRemoteTest) {
                        seventhRemoteTest = FALSE;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            seventhRemoteTest = TRUE;
                        });
                        if ([message rangeOfString:remoteActionSendString].location != NSNotFound) {
                            remoteAction = TRUE;
                        }
                    }

                    else if (remoteActionRespringEnabled && remoteActionRespringString != nil && eighthRemoteTest) {
                        eighthRemoteTest = FALSE;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 180.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            eighthRemoteTest = TRUE;
                        });
                        if ([message rangeOfString:remoteActionRespringString].location != NSNotFound) {
                            #pragma clang diagnostic push
                            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                            #pragma clang diagnostic pop
                            remoteAction = TRUE;
                        }
                    }
                }
            }
        }

        if (remoteAction) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                FSSwitchPanel *fsp = [FSSwitchPanel sharedPanel];
                NSString *switchIdentifier = nil;
                if (remoteActionEnableCellular) {
                    switchIdentifier = @"com.a3tweaks.switch.cellular-data";
                    [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
                }
                if (remoteActionEnableLocation) {
                    switchIdentifier = @"com.a3tweaks.switch.location";
                    [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
                }
                if (remoteActionEnableWifi) {
                    switchIdentifier = @"com.a3tweaks.switch.wifi";
                    [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
                }
                if (remoteActionDisableAirplane) {
					airplaneModeProgrammaticallyControlled = TRUE;
                	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 30.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
						airplaneModeProgrammaticallyControlled = FALSE;
					});
                    switchIdentifier = @"com.a3tweaks.switch.airplane-mode";
                    [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                }
                if (remoteActionEnableDND) {
                    switchIdentifier = @"com.a3tweaks.switch.do-not-disturb";
                    [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
                }
                if (remoteActionEnableLPM) {
                    switchIdentifier = @"com.a3tweaks.switch.low-power";
                    [fsp setState:FSSwitchStateOn forSwitchIdentifier:switchIdentifier];
                }
                if (remoteActionDisableRinger) {
                    switchIdentifier = @"com.a3tweaks.switch.ringer";
                    [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                }
                if (remoteActionDisableVibration) {
                    switchIdentifier = @"com.a3tweaks.switch.vibration";
                    [fsp setState:FSSwitchStateOff forSwitchIdentifier:switchIdentifier];
                }

                if (remoteActionEmail) {
                    sendEmail(@"Remote Action Triggered!");
                    dispatch_async(dispatch_get_main_queue(), ^{
						if (mailRepeat && remoteActionRepeat) {
							if (mailTimer == nil) {
								mailTimer = [NSTimer scheduledTimerWithTimeInterval:mailEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewRemoteMail) userInfo:nil repeats:YES];
							}
						}
					});
                }
                if (remoteActionSMS) {
                    sendSMS(@"Remote Action Triggered!");
                    dispatch_async(dispatch_get_main_queue(), ^{
						if (smsRepeat && remoteActionRepeat) {
							if (smsTimer == nil) {
								smsTimer = [NSTimer scheduledTimerWithTimeInterval:smsEveryXMinutes * 60.0 target:self selector:@selector(pickpocketSendNewRemoteSMS) userInfo:nil repeats:YES];
							}
						}
					});
                }
            });
        } else {
            %orig;
        }
    } else {
        %orig;
    }
}

%new
-(void)pickpocketSendNewRemoteMail {
    HBLogDebug(@"inside pickpocketSendNewRemoteMail");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendEmail(@"Scheduled Mail: Remote Action Triggered!");
    });
}

%new
-(void)pickpocketSendNewRemoteSMS {
    HBLogDebug(@"inside pickpocketSendNewRemoteSMS");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sendSMS(@"Scheduled SMS: Remote Action Triggered!");
    });
}

%end

%ctor {

    NSString *pickPocketPath = @"/var/mobile/Library/";
    NSString *folderName = [pickPocketPath stringByAppendingPathComponent:@"PickPocket"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if (![fileManager fileExistsAtPath:folderName]) {
        [fileManager createDirectoryAtPath:folderName withIntermediateDirectories:YES attributes:nil error:&error];
    }

	@autoreleasepool {
        BOOL shouldLoad = NO;
        NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
        NSUInteger count = args.count;
        if (count != 0) {
            NSString *executablePath = args[0];
            if (executablePath) {
                NSString *processName = [executablePath lastPathComponent];
                BOOL isSpringBoard = [processName isEqualToString:@"SpringBoard"];
                BOOL isCamshot = [processName isEqualToString:@"camshot"];
                if (isSpringBoard || isCamshot) {
                    shouldLoad = YES;
                }
            }
        }

        if (shouldLoad) {

            preferences = [HBPreferences preferencesForIdentifier:@"com.ziph0n.pickpocket10"];
            [preferences registerBool:&enabled default:YES forKey:@"enabled"];
            [preferences registerBool:&firstUse default:YES forKey:@"firstUse"];

            [preferences registerBool:&protectedShutdownEnabled default:YES forKey:@"protectedShutdownEnabled"];
            [preferences registerInteger:&protectedShutdownType default:1 forKey:@"protectedShutdownType"];

            [preferences registerObject:&shutdownPassword default:@"alpine" forKey:@"shutdownPassword"];
            [preferences registerInteger:&shutdownAuthorizedPassword default:2 forKey:@"shutdownAuthorizedPassword"];
            [preferences registerBool:&shutdownUseTouchID default:YES forKey:@"shutdownUseTouchID"];
            [preferences registerBool:&shutdownSaveFrontPic default:YES forKey:@"shutdownSaveFrontPic"];
            [preferences registerBool:&shutdownSaveRearPic default:YES forKey:@"shutdownSaveRearPic"];
            [preferences registerBool:&shutdownPasswordEmail default:YES forKey:@"shutdownPasswordEmail"];
            [preferences registerBool:&shutdownPasswordSMS default:YES forKey:@"shutdownPasswordSMS"];
            [preferences registerBool:&shutdownPasswordCancelEmail default:YES forKey:@"shutdownPasswordCancelEmail"];
            [preferences registerBool:&shutdownPasswordCancelSMS default:YES forKey:@"shutdownPasswordCancelSMS"];
            [preferences registerBool:&shutdownTouchIDEmail default:YES forKey:@"shutdownTouchIDEmail"];
            [preferences registerBool:&shutdownTouchIDSMS default:YES forKey:@"shutdownTouchIDSMS"];
            [preferences registerBool:&shutdownCancelEmail default:NO forKey:@"shutdownCancelEmail"];
            [preferences registerBool:&shutdownCancelSMS default:NO forKey:@"shutdownCancelSMS"];

            [preferences registerBool:&fakeShutdownPasswordEnabled default:YES forKey:@"fakeShutdownPasswordEnabled"];
            [preferences registerObject:&fakeShutdownPassword default:@"alpine" forKey:@"fakeShutdownPassword"];
            [preferences registerBool:&fakeShutdownSaveFrontPic default:YES forKey:@"fakeShutdownSaveFrontPic"];
            [preferences registerBool:&fakeShutdownSaveRearPic default:YES forKey:@"fakeShutdownSaveRearPic"];
            [preferences registerBool:&fakeShutdownWrongPasswordSaveFrontPic default:YES forKey:@"fakeShutdownWrongPasswordSaveFrontPic"];
            [preferences registerBool:&fakeShutdownWrongPasswordSaveRearPic default:YES forKey:@"fakeShutdownWrongPasswordSaveRearPic"];
            [preferences registerBool:&fakeShutdownEmail default:YES forKey:@"fakeShutdownEmail"];
            [preferences registerBool:&fakeShutdownSMS default:YES forKey:@"fakeShutdownSMS"];
            [preferences registerBool:&fakeShutdownPasswordCancelEmail default:YES forKey:@"fakeShutdownPasswordCancelEmail"];
            [preferences registerBool:&fakeShutdownPasswordCancelSMS default:YES forKey:@"fakeShutdownPasswordCancelSMS"];
            [preferences registerBool:&fakeShutdownEnableDND default:YES forKey:@"fakeShutdownEnableDND"];
            [preferences registerBool:&fakeShutdownEnableLPM default:YES forKey:@"fakeShutdownEnableLPM"];
            [preferences registerBool:&fakeShutdownDisableRinger default:YES forKey:@"fakeShutdownDisableRinger"];
            [preferences registerBool:&fakeShutdownDisableVibration default:YES forKey:@"fakeShutdownDisableVibration"];

            [preferences registerBool:&unlockProtectionEnabled default:YES forKey:@"unlockProtectionEnabled"];
            [preferences registerInteger:&unlockAuthorizedPassword default:2 forKey:@"unlockAuthorizedPassword"];
            [preferences registerBool:&unlockTouchIDDisabled default:FALSE forKey:@"unlockTouchIDDisabled"];
            [preferences registerBool:&unlockSaveFrontPic default:YES forKey:@"unlockSaveFrontPic"];
            [preferences registerBool:&unlockSaveRearPic default:YES forKey:@"unlockSaveRearPic"];
            [preferences registerBool:&unlockProtectionEmail default:YES forKey:@"unlockProtectionEmail"];
            [preferences registerBool:&unlockProtectionSMS default:YES forKey:@"unlockProtectionSMS"];
            [preferences registerBool:&unlockSavePicOnlyPassword default:NO forKey:@"unlockSavePicOnlyPassword"];

            [preferences registerBool:&hardResetEnabled default:YES forKey:@"hardResetEnabled"];
            [preferences registerBool:&hardResetEmail default:YES forKey:@"hardResetEmail"];
            [preferences registerBool:&hardResetSMS default:YES forKey:@"hardResetSMS"];
            [preferences registerBool:&hardResetEnableDND default:YES forKey:@"hardResetEnableDND"];
            [preferences registerBool:&hardResetEnableLPM default:YES forKey:@"hardResetEnableLPM"];
            [preferences registerBool:&hardResetDisableRinger default:YES forKey:@"hardResetDisableRinger"];
            [preferences registerBool:&hardResetDisableVibration default:YES forKey:@"hardResetDisableVibration"];

            [preferences registerBool:&lsInfoEnabled default:YES forKey:@"lsInfoEnabled"];
            [preferences registerObject:&userName default:nil forKey:@"userName"];
            [preferences registerObject:&userSurname default:nil forKey:@"userSurname"];
            [preferences registerObject:&userCity default:nil forKey:@"userCity"];
            [preferences registerObject:&userCountry default:nil forKey:@"userCountry"];
            [preferences registerObject:&userNumberToCall default:nil forKey:@"userNumberToCall"];
            [preferences registerBool:&userSendSMS default:YES forKey:@"userSendSMS"];
            [preferences registerObject:&userXPosition default:@"" forKey:@"userXPosition"];
            [preferences registerObject:&userYPosition default:@"" forKey:@"userYPosition"];
            [preferences registerObject:&userCloseXPosition default:@"" forKey:@"userCloseXPosition"];
            [preferences registerObject:&userCloseYPosition default:@"" forKey:@"userCloseYPosition"];
            [preferences registerInteger:&userBorderWidth default:1 forKey:@"userBorderWidth"];
            [preferences registerInteger:&userTextType default:1 forKey:@"userTextType"];
            [preferences registerInteger:&userButtonStyle default:1 forKey:@"userButtonStyle"];
            [preferences registerBool:&userUseVibrancy default:YES forKey:@"userUseVibrancy"];

            /*[preferences registerBool:&prankModeEnabled default:YES forKey:@"prankModeEnabled"];
            [preferences registerObject:&firstPrankPassword default:nil forKey:@"firstPrankPassword"];
            [preferences registerObject:&secondPrankPassword default:nil forKey:@"secondPrankPassword"];
            [preferences registerObject:&thirdPrankPassword default:nil forKey:@"thirdPrankPassword"];
            [preferences registerObject:&fourthPrankPassword default:nil forKey:@"fourthPrankPassword"];
            [preferences registerObject:&fifthPrankPassword default:nil forKey:@"fifthPrankPassword"];*/

            [preferences registerInteger:&unlockAlarmType default:1 forKey:@"unlockAlarmType"];
            [preferences registerObject:&unlockAlarm default:nil forKey:@"unlockAlarm"];
            [preferences registerObject:&unlockSpeech default:nil forKey:@"unlockSpeech"];
            [preferences registerInteger:&shutdownAlarmType default:1 forKey:@"shutdownAlarmType"];
            [preferences registerObject:&shutdownAlarm default:nil forKey:@"shutdownAlarm"];
            [preferences registerObject:&shutdownSpeech default:nil forKey:@"shutdownSpeech"];

            [preferences registerInteger:&remoteActionStringType default:1 forKey:@"remoteActionStringType"];
            [preferences registerBool:&remoteActionEmail default:YES forKey:@"remoteActionEmail"];
            [preferences registerBool:&remoteActionSMS default:YES forKey:@"remoteActionSMS"];
            [preferences registerBool:&remoteActionRepeat default:YES forKey:@"remoteActionRepeat"];
            [preferences registerBool:&remoteActionEnableCellular default:YES forKey:@"remoteActionEnableCellular"];
            [preferences registerBool:&remoteActionEnableLocation default:YES forKey:@"remoteActionEnableLocation"];
            [preferences registerBool:&remoteActionEnableWifi default:YES forKey:@"remoteActionEnableWifi"];
            [preferences registerBool:&remoteActionDisableAirplane default:YES forKey:@"remoteActionDisableAirplane"];
            [preferences registerBool:&remoteActionEnableDND default:YES forKey:@"remoteActionEnableDND"];
            [preferences registerBool:&remoteActionEnableLPM default:YES forKey:@"remoteActionEnableLPM"];
            [preferences registerBool:&remoteActionDisableRinger default:YES forKey:@"remoteActionDisableRinger"];
            [preferences registerBool:&remoteActionDisableVibration default:YES forKey:@"remoteActionDisableVibration"];
            [preferences registerBool:&remoteActionPlayAlarmEnabled default:NO forKey:@"remoteActionPlayAlarmEnabled"];
            [preferences registerObject:&remoteActionPlayAlarmString default:nil forKey:@"remoteActionPlayAlarmString"];
            [preferences registerObject:&remoteActionAlarm default:nil forKey:@"remoteActionAlarm"];
            [preferences registerBool:&remoteActionStopAlarmEnabled default:NO forKey:@"remoteActionStopAlarmEnabled"];
            [preferences registerObject:&remoteActionStopAlarmString default:nil forKey:@"remoteActionStopAlarmString"];
            [preferences registerBool:&remoteActionPlaySpeechEnabled default:NO forKey:@"remoteActionPlaySpeechEnabled"];
            [preferences registerObject:&remoteActionSpeechString default:nil forKey:@"remoteActionSpeechString"];
            [preferences registerObject:&remoteActionSpeech default:nil forKey:@"remoteActionSpeech"];
            [preferences registerBool:&remoteActionFakeShutdownEnabled default:NO forKey:@"remoteActionFakeShutdownEnabled"];
            [preferences registerObject:&remoteActionFakeShutdownString default:nil forKey:@"remoteActionFakeShutdownString"];
            [preferences registerBool:&remoteActionFrontPicEnabled default:NO forKey:@"remoteActionFrontPicEnabled"];
            [preferences registerObject:&remoteActionFrontPicString default:nil forKey:@"remoteActionFrontPicString"];
            [preferences registerBool:&remoteActionRearPicEnabled default:NO forKey:@"remoteActionRearPicEnabled"];
            [preferences registerObject:&remoteActionRearPicString default:nil forKey:@"remoteActionRearPicString"];
            [preferences registerBool:&remoteActionSendEnabled default:NO forKey:@"remoteActionSendEnabled"];
            [preferences registerObject:&remoteActionSendString default:nil forKey:@"remoteActionSendString"];
            [preferences registerBool:&remoteActionRespringEnabled default:NO forKey:@"remoteActionRespringEnabled"];
            [preferences registerObject:&remoteActionRespringString default:nil forKey:@"remoteActionRespringString"];

            [preferences registerBool:&automaticShutdownDisabled default:YES forKey:@"automaticShutdownDisabled"];
            [preferences registerInteger:&automaticShutdownType default:1 forKey:@"automaticShutdownType"];
            [preferences registerBool:&automaticShutdownEmail default:YES forKey:@"automaticShutdownEmail"];
            [preferences registerBool:&automaticShutdownSMS default:YES forKey:@"automaticShutdownSMS"];

            [preferences registerBool:&airplaneModeEnabled default:YES forKey:@"airplaneModeEnabled"];
            [preferences registerInteger:&airplaneModeType default:1 forKey:@"airplaneModeType"];
            [preferences registerBool:&airplaneModeEmail default:YES forKey:@"airplaneModeEmail"];
            [preferences registerBool:&airplaneModeSMS default:YES forKey:@"airplaneModeSMS"];

            [preferences registerBool:&simEnabled default:YES forKey:@"simEnabled"];
            [preferences registerInteger:&simAlarmType default:1 forKey:@"simAlarmType"];
            [preferences registerObject:&simAlarm default:nil forKey:@"simAlarm"];
            [preferences registerObject:&simSpeech default:nil forKey:@"simSpeech"];
            [preferences registerBool:&simEmail default:YES forKey:@"simEmail"];
            [preferences registerBool:&simSMS default:YES forKey:@"simSMS"];

            [preferences registerObject:&senderEmail default:nil forKey:@"senderEmail"];
            [preferences registerObject:&firstReceiverEmail default:nil forKey:@"firstReceiverEmail"];
            [preferences registerObject:&secondReceiverEmail default:nil forKey:@"secondReceiverEmail"];
            [preferences registerObject:&thirdReceiverEmail default:nil forKey:@"thirdReceiverEmail"];
            [preferences registerObject:&fourthReceiverEmail default:nil forKey:@"fourthReceiverEmail"];
            [preferences registerObject:&fifthReceiverEmail default:nil forKey:@"fifthReceiverEmail"];
            [preferences registerBool:&mailTime default:YES forKey:@"mailTime"];
            [preferences registerBool:&mailDeviceDetails default:YES forKey:@"mailDeviceDetails"];
            [preferences registerBool:&mailBattery default:YES forKey:@"mailBattery"];
            [preferences registerBool:&mailFrontPic default:YES forKey:@"mailFrontPic"];
            [preferences registerBool:&mailRearPic default:YES forKey:@"mailRearPic"];
            [preferences registerBool:&mailLocation default:YES forKey:@"mailLocation"];
            [preferences registerObject:&mailCustomText default:nil forKey:@"mailCustomText"];
            [preferences registerBool:&mailRepeat default:YES forKey:@"mailRepeat"];
            [preferences registerInteger:&mailEveryXMinutes default:5 forKey:@"mailEveryXMinutes"];
            [preferences registerBool:&mailEnableCellular default:YES forKey:@"mailEnableCellular"];
            [preferences registerBool:&mailEnableLocation default:YES forKey:@"mailEnableLocation"];
            [preferences registerBool:&mailEnableWifi default:YES forKey:@"mailEnableWifi"];

            [preferences registerObject:&firstPhoneNumber default:nil forKey:@"firstPhoneNumber"];
            [preferences registerObject:&secondPhoneNumber default:nil forKey:@"secondPhoneNumber"];
            [preferences registerObject:&thirdPhoneNumber default:nil forKey:@"thirdPhoneNumber"];
            [preferences registerObject:&fourthPhoneNumber default:nil forKey:@"fourthPhoneNumber"];
            [preferences registerObject:&fifthPhoneNumber default:nil forKey:@"fifthPhoneNumber"];
            [preferences registerBool:&smsTime default:YES forKey:@"smsTime"];
            [preferences registerBool:&smsDeviceDetails default:YES forKey:@"smsDeviceDetails"];
            [preferences registerBool:&smsBattery default:YES forKey:@"smsBattery"];
            [preferences registerBool:&smsFrontPic default:YES forKey:@"smsFrontPic"];
            [preferences registerBool:&smsRearPic default:YES forKey:@"smsRearPic"];
            [preferences registerBool:&smsLocation default:YES forKey:@"smsLocation"];
            [preferences registerObject:&smsCustomText default:nil forKey:@"smsCustomText"];
            [preferences registerBool:&smsRepeat default:YES forKey:@"smsRepeat"];
            [preferences registerInteger:&smsEveryXMinutes default:5 forKey:@"smsEveryXMinutes"];
            [preferences registerBool:&smsEnableCellular default:YES forKey:@"smsEnableCellular"];
            [preferences registerBool:&smsEnableLocation default:YES forKey:@"smsEnableLocation"];
            [preferences registerBool:&smsEnableWifi default:YES forKey:@"smsEnableWifi"];
            [preferences registerBool:&smsDisableAirplane default:YES forKey:@"smsDisableAirplane"];

            NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.ziph0n.pickpocket10.plist"];
            lsButtonColor = ([prefs objectForKey:@"lsButtonColor"] ? [prefs objectForKey:@"lsButtonColor"] : @"#FFFFFF");

            if ([shutdownPassword isEqual:@""]) {
                shutdownPassword = @"alpine";
            }

            if ([fakeShutdownPassword isEqual:@""]) {
                fakeShutdownPassword = @"alpine";
            }

            if ([remoteActionPlayAlarmString isEqual:@""]) {
                remoteActionPlayAlarmString = nil;
            }

            if ([remoteActionStopAlarmString isEqual:@""]) {
                remoteActionStopAlarmString = nil;
            }

            if ([remoteActionSpeechString isEqual:@""]) {
                remoteActionSpeechString = nil;
            }

            if ([remoteActionFakeShutdownString isEqual:@""]) {
                remoteActionFakeShutdownString = nil;
            }

            if ([remoteActionFrontPicString isEqual:@""]) {
                remoteActionFrontPicString = nil;
            }

            if ([remoteActionRearPicString isEqual:@""]) {
                remoteActionRearPicString = nil;
            }

            if ([remoteActionSendString isEqual:@""]) {
                remoteActionSendString = nil;
            }

            if ([remoteActionRespringString isEqual:@""]) {
                remoteActionRespringString = nil;
            }

            if (protectedShutdownType == 0) {
                protectedShutdownType = 1;
            }

            if (unlockAlarmType == 0) {
                unlockAlarmType = 1;
            }

            if (shutdownAlarmType == 0) {
                shutdownAlarmType = 1;
            }

            if (userTextType == 0) {
                userTextType = 1;
            }

            if (userButtonStyle == 0) {
                userButtonStyle = 1;
            }

            if (remoteActionStringType == 0) {
                remoteActionStringType = 1;
            }

            if (automaticShutdownType == 0) {
                automaticShutdownType = 1;
            }

            if (airplaneModeType == 0) {
                airplaneModeType = 1;
            }

            if (simAlarmType == 0) {
                simAlarmType = 1;
            }

            if (unlockAlarmType == 1) {
                initializeUnlockAlarm();
            } else if (unlockAlarmType == 2) {
                initializeUnlockSpeech();
            }

            if (shutdownAlarmType == 1) {
                initializeShutdownAlarm();
            } else if (shutdownAlarmType == 2) {
                initializeShutdownSpeech();
            }

            if (simAlarmType == 1) {
                initializeSIMAlarm();
            } else if (simAlarmType == 2) {
                initializeSIMSpeech();
            }

            MSHookFunction((void **)AudioServicesPlaySystemSound, (void **)replaced_AudioServicesPlaySystemSound, (void **)&original_AudioServicesPlaySystemSound);
            %init();
        }
    }
}
