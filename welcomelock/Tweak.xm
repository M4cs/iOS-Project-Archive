@interface SBLockScreenDateViewController : UIViewController
@property (retain, nonatomic) UILabel *firstLabel;
@end

%hook SBLockScreenDateViewController
%property (retain, nonatomic) UILabel *firstLabel;
-(void)viewDidLoad {
  self.view.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
  self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(-20, 85, [[UIScreen mainScreen] bounds].size.width, 20)];
  self.firstLabel.text = @"Welcome Macs";
  self.firstLabel.textColor = [UIColor whiteColor];
  self.firstLabel.backgroundColor = [UIColor clearColor];
  self.firstLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 20.0f];
  self.firstLabel.alpha = 1.0;
  self.firstLabel.textAlignment = NSTextAlignmentCenter;

  [self.view addSubview:self.firstLabel];

}

%end
