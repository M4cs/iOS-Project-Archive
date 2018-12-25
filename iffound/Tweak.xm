static UIWindow *window = nil;

%hook SBLockScreenDateViewController

-(void)viewDidAppear {
  if (!window){

  window = [[UIWindow alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-175,150,350,400)];

            window.hidden = NO;
            window.windowLevel = UIWindowLevelStatusBar;
            window.layer.masksToBounds = YES;
            window.layer.cornerRadius = 30;
            [self addSubview:window];

  UIVisualEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
  UIVisualEffectView *vView = [[UIVisualEffectView alloc]initWithEffect:blur];

            vView.frame = window.bounds;
            [window addSubview:vView];

  UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-50,40,100,50)];
                    label.text = @"IfFound";
                    label.textColor = [UIColor greenColor];
                    [window addSubview:label];

//  UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self
//                                    action:@selector(tap)];
  //                                  [window addGestureRecognizer:gesture];
}

}

%end
