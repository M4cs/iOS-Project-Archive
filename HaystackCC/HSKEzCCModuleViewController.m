#import "HSKEzCCModuleViewController.h"
#import <spawn.h>
#define colorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIApplication (PrivateMethods)
- (BOOL)launchApplicationWithIdentifier:(NSString *)identifier suspended:(BOOL)suspend;
@end
@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)respringImg inBundle:(NSBundle *)bundle;
@end


@implementation HSKEzCCModuleViewController

- (id)init {
	self = [super init];

	if (self) {
		self.height = 395;
		self.edgeinset = 11;

		/*self.mediaViewController = [[NSClassFromString(@"HSKSettingsCardViewController") alloc] init];*/
		[self.view addSubview:self.mediaViewController.view];

		[[NSNotificationCenter defaultCenter] addObserver:self
		         selector:@selector(controlCenterDismissed)
		         name:@"com.laughingquoll.haystack.controlCenterDismissed"
		         object:nil];

		 [[NSNotificationCenter defaultCenter] addObserver:self
		         selector:@selector(controlCenterInvoked)
		         name:@"com.laughingquoll.haystack.controlCenterInvoked"
		         object:nil];

		 CGSize screenSize = [[UIScreen mainScreen] bounds].size;
		     if (screenSize.height == 812)
		         self.whiteOverlayView.layer.cornerRadius = 39;

		UIImage *respringImg = [UIImage imageNamed:@"Resources/respring.png"];
		UIButton *respring=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	respring.frame= CGRectMake(50, 0, 100, 100);
			[respring setImage:respringImg forState:UIControlStateNormal];
    	[respring setTitle:@"Respring" forState:UIControlStateNormal];
    	[respring addTarget:self action:@selector(respringAction) forControlEvents:UIControlEventTouchUpInside];
    	[self.view addSubview:respring];

		UIButton *uicache=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	uicache.frame= CGRectMake(150, 0, 100, 100);
    	[uicache setTitle:@"UICache" forState:UIControlStateNormal];
    	[uicache addTarget:self action:@selector(uicache) forControlEvents:UIControlEventTouchUpInside];
    	[self.view addSubview:uicache];	 

		UIButton *apollo=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	apollo.frame= CGRectMake(250, 0, 100, 100);
    	[apollo setTitle:@"Apollo" forState:UIControlStateNormal];
    	[apollo addTarget:self action:@selector(apollo) forControlEvents:UIControlEventTouchUpInside];
    	[self.view addSubview:apollo];	 

		UIButton *cydia=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	cydia.frame= CGRectMake(50, 100, 100, 100);
    	[cydia setTitle:@"Cydia" forState:UIControlStateNormal];
    	[cydia addTarget:self action:@selector(cydia) forControlEvents:UIControlEventTouchUpInside];
    	[self.view addSubview:cydia];	 

		UIButton *discord=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	discord.frame= CGRectMake(150, 100, 100, 100);
    	[discord setTitle:@"discord" forState:UIControlStateNormal];
    	[discord addTarget:self action:@selector(discord) forControlEvents:UIControlEventTouchUpInside];
    	[self.view addSubview:discord];	 		

		UIButton *settings=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	settings.frame= CGRectMake(250, 100, 100, 100);
    	[settings setTitle:@"Settings" forState:UIControlStateNormal];
    	[settings addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    	[self.view addSubview:settings];	

		UIButton *safe=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	safe.frame= CGRectMake(50, 200, 100, 100);
    	[safe setTitle:@"Safe Mode" forState:UIControlStateNormal];
    	[safe addTarget:self action:@selector(safemode) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:safe];

		UIButton *icleaner=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	icleaner.frame= CGRectMake(150, 200, 100, 100);
    	[icleaner setTitle:@"iCleaner" forState:UIControlStateNormal];
    	[icleaner addTarget:self action:@selector(icleaner) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:icleaner];

		UIButton *youtube=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	youtube.frame= CGRectMake(250, 200, 100, 100);
    	[youtube setTitle:@"YouTube" forState:UIControlStateNormal];
    	[youtube addTarget:self action:@selector(youtube) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:youtube];

		UIButton *gauth=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	gauth.frame= CGRectMake(50, 300, 100, 100);
    	[gauth setTitle:@"Authenticator" forState:UIControlStateNormal];
    	[gauth addTarget:self action:@selector(gauth) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:gauth];

		UIButton *facetime=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	facetime.frame= CGRectMake(150, 300, 100, 100);
    	[facetime setTitle:@"FaceTime" forState:UIControlStateNormal];
    	[facetime addTarget:self action:@selector(facetime) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:facetime];

		UIButton *messages=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    	messages.frame= CGRectMake(250, 300, 100, 100);
    	[messages setTitle:@"iMessages" forState:UIControlStateNormal];
    	[messages addTarget:self action:@selector(messages) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:messages];
	} 
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)willBecomeActive {
}

- (void)willResignActive {
}

- (void)viewWillAppear:(BOOL)arg1 {
	self.mediaViewController.view.frame = CGRectMake(self.edgeinset, self.view.frame.size.height - self.height, self.view.frame.size.width - self.edgeinset*2, self.height);
}

- (void)viewWillLayoutSubviews {
	self.mediaViewController.view.frame = CGRectMake(self.edgeinset, self.view.frame.size.height - self.height, self.view.frame.size.width - self.edgeinset*2, self.height);
}

-(void)controlCenterDismissed {
  [self.mediaViewController setStyle:1];
  [self.mediaViewController _updateOnScreenForStyle:1];
}
-(void)controlCenterInvoked {
  [self.mediaViewController setStyle:3];
  [self.mediaViewController _updateOnScreenForStyle:3];
}

-(void)respringAction{
    pid_t pid;
    int status;
    const char* args[] = {"killall", "-9", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}


- (void)uicache {
    pid_t pid;
    int status;
    const char* args[] = {"uicache", NULL, NULL, NULL};
    posix_spawn(&pid, "/usr/bin/uicache", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
		CFRunLoopRunInMode(kCFRunLoopDefaultMode, 20.0, false);
	
}

- (void)apollo {
  NSString *bundleID = @"com.christianselig.Apollo";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];
		
}

- (void)cydia {
  NSString *bundleID = @"com.saurik.Cydia";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];
	
}

- (void)discord {
  NSString *bundleID = @"com.hammerandchisel.discord";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];
}

- (void)settings {
  NSString *bundleID = @"com.apple.Preferences";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];
}

- (void)safemode {
    pid_t pid;
    int status;
    const char* args[] = {"killall", "-SEGV", "SpringBoard", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}

- (void)icleaner {
  NSString *bundleID = @"com.exile90.icleanerpro";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];		
}

- (void)youtube {
  NSString *bundleID = @"com.google.ios.youtube";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];	
}

- (void)gauth {
  NSString *bundleID = @"com.google.Authenticator";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];
	
}

- (void)facetime {
  NSString *bundleID = @"com.apple.facetime";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];
		
}
- (void)messages {
  NSString *bundleID = @"com.apple.mobilesms";
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:FALSE];
		
}
@end



