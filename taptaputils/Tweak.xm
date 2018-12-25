#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <FrontBoardServices/FBSSystemService.h>
#import <spawn.h>
#import <notify.h>
#import <sys/wait.h>

/*
pid_t pid;
    									int status;
										const char* args[] = {"killall", "-9", "backboardd", NULL};
										posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
										waitpid(pid, &status, WEXITED);
*/

@interface UIStatusBarWindow : UIWindow
//-(void)respring;
-(void)check;
@end

@interface FBSystemService : NSObject
+(id)sharedInstance;
-(void)shutdownAndReboot:(BOOL)arg1;
@end

NSNumber* uicache;
NSNumber* respring;
NSNumber* rebootd;
NSNumber* safemode;
NSNumber* shutdownd;

%ctor{
	NSString *currentID = NSBundle.mainBundle.bundleIdentifier;
	NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:
  [NSString stringWithFormat:@"/var/mobile/Library/Preferences/com.clarke1234.taptaputilsprefs.plist"]];
	uicache = [settings objectForKey:@"uicache"];
	respring = [settings objectForKey:@"respring"];
	rebootd = [settings objectForKey:@"reboot"];
	safemode = [settings objectForKey:@"safemode"];
	shutdownd = [settings objectForKey:@"shutdown"];
	if ([currentID isEqualToString:@"com.apple.springboard"]) {
		int regToken;
		notify_register_dispatch("com.clarke1234.taptaprespring", &regToken, dispatch_get_main_queue(), ^(int token) {
			pid_t pid;
			int status;
			const char* args[] = {"killall", "-9", "backboardd", NULL};
			posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);
										
		});
		notify_register_dispatch("com.clarke1234.taptapuicache", &regToken, dispatch_get_main_queue(), ^(int token){
			pid_t pid;
			int status;
			const char* args[] = {"uicache", NULL, NULL, NULL};
			posix_spawn(&pid, "/usr/bin/uicache", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);
				CFRunLoopRunInMode(kCFRunLoopDefaultMode, 20.0, false);
		});
		notify_register_dispatch("com.clarke1234.taptapreboot", &regToken, dispatch_get_main_queue(), ^(int token){
			[[%c(FBSystemService) sharedInstance] shutdownAndReboot:YES];
		});
		notify_register_dispatch("com.clarke1234.taptapsafemode", &regToken, dispatch_get_main_queue(), ^(int token){
			pid_t pid;
			int status;
			const char* args[] = {"killall", "-SEGV", "SpringBoard", NULL};
			posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);
		});
		notify_register_dispatch("com.clarke1234.taptapshutdown", &regToken, dispatch_get_main_queue(), ^(int token){
			[[%c(FBSystemService) sharedInstance] shutdownAndReboot:NO];
		}); 
		
		
}
}

%hook UIStatusBarWindow

%new

-(void)check{
	UIAlertController *confirmationAlertController = [UIAlertController
                                    alertControllerWithTitle:@"TapTapUtils"
                                    message:@"Please pick an option"
                                    preferredStyle:UIAlertControllerStyleAlert];



        UIAlertAction* confirmRespring = [UIAlertAction
                                    actionWithTitle:@"Respring"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {	
                                        notify_post("com.clarke1234.taptaprespring");
                                    }];

        UIAlertAction* confirmUiCache = [UIAlertAction
                                    actionWithTitle:@"Uicache"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        notify_post("com.clarke1234.taptapuicache");
                                    }];

		UIAlertAction* confirmReboot = [UIAlertAction
									actionWithTitle:@"Reboot"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										notify_post("com.clarke1234.taptapreboot");
									}];
								
		UIAlertAction* confirmSafemode = [UIAlertAction
									actionWithTitle:@"Safemode"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										notify_post("com.clarke1234.taptapsafemode");
									}];
		
		UIAlertAction* confirmShutdown = [UIAlertAction
									actionWithTitle:@"Shutdown"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										notify_post("com.clarke1234.taptapshutdown");
									}];
		
		UIAlertAction* confirmCancel = [UIAlertAction
									actionWithTitle:@"Cancel"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										//Do nothing
									}];
		if ([uicache boolValue] == YES){
        	[confirmationAlertController addAction:confirmUiCache];
		}
		if ([respring boolValue] == YES){
	        [confirmationAlertController addAction:confirmRespring];
		}
		if ([rebootd boolValue] == YES){
			[confirmationAlertController addAction:confirmReboot];
		}
		if ([safemode boolValue] == YES){
			[confirmationAlertController addAction:confirmSafemode];
		}
		if ([shutdownd boolValue] == YES){
			[confirmationAlertController addAction:confirmShutdown];
		}
		[confirmationAlertController addAction:confirmCancel];

        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:confirmationAlertController animated:YES completion:NULL];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = %orig;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(check)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapRecognizer];
    
    return self;
}


%end

