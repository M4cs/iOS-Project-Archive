#import "libfireball.h"
#import "libfireball_private.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

void FBSetPrefsTint(UIViewController *prefs, UIColor *tintColor)
{
	UIViewController *self = prefs;

	UISplitViewController *splitViewController = (UISplitViewController *)self.splitViewController;//[[UIApplication sharedApplication] keyWindow].rootViewController;
	UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
	UIViewController *lastViewController = navigationController.visibleViewController;//

	[navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor}];

	navigationController.navigationBar.tintColor = tintColor;
	lastViewController.view.tintColor = tintColor;
	[lastViewController.view setAutoresizesSubviews:YES];
	if([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
		[self setEdgesForExtendedLayout:UIRectEdgeBottom];
	}

	[UISegmentedControl appearanceWhenContainedIn:self.class, nil].tintColor = tintColor;
	[UISlider appearanceWhenContainedIn:self.class, nil].maximumTrackTintColor = tintColor;

	[[UISwitch appearanceWhenContainedIn:self.class, nil] setOnTintColor:tintColor];
}

void FBResetPrefsTint(UIViewController *prefs)
{
	UIViewController *self = prefs;

	UISplitViewController *splitViewController = (UISplitViewController *)self.splitViewController;//[[UIApplication sharedApplication] keyWindow].rootViewController;
	UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
	UIViewController *lastViewController = navigationController.visibleViewController;//

	navigationController.navigationBar.barTintColor = nil;
	navigationController.navigationBar.tintColor = nil;
	[navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
	lastViewController.view.tintColor = nil;
	[lastViewController.view setAutoresizesSubviews:NO];
}

PSSpecifier *FBVersionCopyrightSpecifier(NSString *packageIdentifier, NSString *copyrightName, NSString *yearMade)
{
	NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath: @"/bin/sh"];
	[task setArguments:
	 @[@"-c", [NSString stringWithFormat:@"dpkg -s %@ | grep 'Version'", packageIdentifier]]
	];
	NSPipe *pipe = [NSPipe pipe];
	[task setStandardOutput:pipe];
	[task launch];

	NSData *data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
	NSString *version = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];


	[task release];

	PSSpecifier *footer = [FBGetClass(@"PSSpecifier") preferenceSpecifierNamed:@"" target:nil set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footer setProperty:[NSString stringWithFormat:@"© %@ %@\n %@", copyrightName, FBDynamicYear(yearMade), version] forKey:@"footerText"];
	[footer setProperty:@"1" forKey:@"footerAlignment"];

	[version release];

	return footer;
}

static NSString *FBDynamicYear(NSString *yearMade)
{
	NSString *dynamicYear = @"";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
	[dateFormatter setDateFormat:@"yyyy"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDate *date = [NSDate date];
	NSString *dateString = [dateFormatter stringFromDate:date];
	if ([yearMade isEqual:dateString]) dynamicYear = dateString;
	else dynamicYear = [NSString stringWithFormat:@"%@ - %@", yearMade, dateString];
	[dateFormatter release];
	return dynamicYear;
}

void FBKillProcess(NSString *signal, NSString *processName)
{
	pid_t pid;
	signal = signal ? signal : @"9";
	signal = [NSString stringWithFormat:@"-%@", signal];

	const char *args[] = {"killall", signal.UTF8String, processName.UTF8String, NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char *const *)args, NULL);
}

@interface FBBarButtonItem : UIBarButtonItem

@property (nonatomic, retain) NSString *shareText;
@property (assign) UIViewController *container;

@end

@implementation FBBarButtonItem
@synthesize shareText, container;

- (void)dealloc
{
    self.shareText = nil;
    [super dealloc];
}

@end

@interface FBTwitterShareHandler : NSObject

+ (FBTwitterShareHandler *)sharedInstance;

@end

@implementation FBTwitterShareHandler


- (void)shareTapped:(FBBarButtonItem *)sender
{
	SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
	[composeController setInitialText:sender.shareText];
	[sender.container presentViewController:composeController animated:YES completion:nil];
}

+ (FBTwitterShareHandler *)sharedInstance
{
    static FBTwitterShareHandler *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[self alloc] init];
        
        return sharedSingleton;
    }
}

@end


void FBAddTwitterShareButton(UIViewController *prefs, UIImage *twitterIcon, NSString *shareText)
{
	FBTwitterShareHandler *shareHandler = [FBTwitterShareHandler sharedInstance];

	FBBarButtonItem *tweet = [[FBBarButtonItem alloc] initWithImage:twitterIcon style:UIBarButtonItemStylePlain target:shareHandler action:@selector(shareTapped:)];
    
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(20, 20), NO, 0.0);
	UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    tweet.container = prefs;
    tweet.shareText = shareText;
    
	[tweet setBackgroundImage:blank forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[prefs.navigationItem setRightBarButtonItem:tweet];

    
	[tweet release];
}

@interface FBWelcomeTwitterHandler : NSObject <UIAlertViewDelegate>
@property (nonatomic, retain) NSString *username;
@end

@implementation FBWelcomeTwitterHandler
@synthesize username;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index
{
    switch (alertView.tag)
    {
        case 1:
        {
            if (index == 1)
                [self dropMeAFollow];
            break;
        }
            
        case 2:
        {
            NSArray *accounts = objc_getAssociatedObject(alertView, @selector(description));
            
            if (index == 0)
                for (ACAccount *currentAccount in accounts)
                    [self followWithAccount:currentAccount];
            
            else
                [self followWithAccount:accounts[index - 1]];
            
            
            UIAlertView *followedAlert = [[UIAlertView alloc] initWithTitle:@"Done <3" message:@"Just moving around a few things aaaaaand..... hah! Just kidding. Thanks for following me. Enjoy the tweak! :)" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Will do!", nil];
            [followedAlert show];
            [followedAlert release];
            break;
        }
            
        default:
            break;
    }
}

- (void)dropMeAFollow
{
    ACAccountStore *accountStore = [ACAccountStore new];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        
        if (granted)
        {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            if ([accounts count] == 1)
            {
                [self followWithAccount:[accounts firstObject]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *followedAlert = [[UIAlertView alloc] initWithTitle:@"Done <3" message:@"Awesome. Thanks for following me ^-^" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"You're welcome <3", nil];
                    [followedAlert show];
                    [followedAlert release];
                });
            }
            else if ([accounts count] > 1)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertView *pickAccountAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Looks like you have multiple Twitter accounts on this device. Which one would you like to use?" delegate:self cancelButtonTitle:@"All!" otherButtonTitles:nil];
                    
                    for (ACAccount *account in accounts)
                        [pickAccountAlert addButtonWithTitle:account.username];
                    
                    pickAccountAlert.tag = 2;
                    
                    objc_setAssociatedObject(pickAccountAlert, @selector(show), self, OBJC_ASSOCIATION_RETAIN);
                    objc_setAssociatedObject(pickAccountAlert, @selector(description), accounts, OBJC_ASSOCIATION_RETAIN);
                    
                    [pickAccountAlert show];
                    [pickAccountAlert release];
                });
            }
            else if ([accounts count] < 1)
                FBOpenTwitterUsername(self.username);
        }
    }];
    
    [accountStore release];
}

- (void)followWithAccount:(ACAccount *)account
{
    NSDictionary *postParameters = [NSDictionary dictionaryWithObjectsAndKeys:self.username, @"screen_name", @"FALSE", @"follow", nil];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/friendships/create.json"] parameters:postParameters];
    
    [request setAccount:account];
    
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        /*if ([urlResponse statusCode] == 200)
         {
         NSError *error;
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
         NSLog(@"Twitter response: %@", dict);
         }
         else
         NSLog(@"Twitter error, HTTP response: %i", [urlResponse statusCode]);*/
    }];
}

- (void)dealloc
{
    self.username = nil;
    
    [super dealloc];
}

@end

@interface FBDonateHandler : NSObject <UIAlertViewDelegate>
@end

@implementation FBDonateHandler

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index
{
    if (index == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=S8D55T2Q6YK2W"]];
    }
}

- (void)dealloc
{
    [super dealloc];
}

@end

void FBShowTwitterFollowAlert(NSString *title, NSString *welcomeMessage, NSString *twitterUsername)
{
    FBWelcomeTwitterHandler *handler = [FBWelcomeTwitterHandler new];
    handler.username = twitterUsername;
    UIAlertView *welcomeAlert = [[UIAlertView alloc] initWithTitle:title
                                                           message:welcomeMessage ? welcomeMessage : @"Hey there! Thanks for installing my tweak! If you'd like to follow me on Twitter for more updates, tweak giveaways and other cool stuff, hit the button below!" delegate:handler cancelButtonTitle:@"No thanks!" otherButtonTitles:@"I'd love to!", nil];
    welcomeAlert.tag = 1;
    objc_setAssociatedObject(welcomeAlert, @selector(show), handler, OBJC_ASSOCIATION_RETAIN);
    [welcomeAlert show];
    
    [handler release];
    [welcomeAlert release];
}

void FBShowDonateAlert(NSString *title)
{
    FBDonateHandler *handler = [FBDonateHandler new];
    NSString *message = [NSString stringWithFormat:@"Hey there! %@ is free, if you like it, please consider a little donation :) It would be incredibly kind from you!", title];
    UIAlertView *donateAlert = [[UIAlertView alloc] initWithTitle:title
                                                           message:message delegate:handler cancelButtonTitle:@"No thanks!" otherButtonTitles:@"Sure!", nil];
    objc_setAssociatedObject(donateAlert, @selector(show), handler, OBJC_ASSOCIATION_RETAIN);
    [donateAlert show];
    
    [handler release];
    [donateAlert release];
}

void FBOpenTwitterUsername(NSString *username)
{
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

void FBOpenMailAddress(NSString *email)
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"mailto:" stringByAppendingString:email]]];
}
#pragma clang diagnostic pop

