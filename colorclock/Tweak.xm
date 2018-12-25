@interface SBLockScreenDateViewController : UIViewController
@end

%hook SBLockscreenDateViewController

-(void)viewWillAppear {
	%orig
	self.setTint = [UIColor redColor];
}

%end