@interface SBLockScreenDateView : SBLockScreenDateViewController
@end

%hook SBLockScreenDateView

-(void)viewDidLoad {
  %orig;
  CGRect oldFrame = self.frame;
  oldFrame.origin.x = 15
  oldframe.origin.y = 350
  self.frame = oldframe

}

%end 
