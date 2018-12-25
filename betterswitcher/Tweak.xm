static BOOL miniSettingsViewExists = NO;
static BOOL buttonScrollViewExists = NO;
UIView *miniSettingsView;

@interface SBDeckSwitcherViewController : UIViewController
@end


%hook SBDeckSwitcherViewController
-(void)viewWillLayoutSubviews {
	if (!miniSettingsViewExists) {
		miniSettingsView = [[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 120, 495, 240, 72)]; // 320, 96 both * 0.75
		[miniSettingsView setBackgroundColor:[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1]];
		[[miniSettingsView layer] setCornerRadius:25.0f]; //35 for sicccckk circle dock
		miniSettingsView.tag = 420;
		[self.view addSubview:miniSettingsView];
		miniSettingsViewExists = YES;
	}
	if (miniSettingsViewExists && !buttonScrollViewExists) {

		UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, miniSettingsView.frame.size.width, miniSettingsView.frame.size.height)];
		[scrollView setPagingEnabled: YES];
		scrollView.tag = 421;

		  int x = 0;
		  CGRect frame;
		  for (int i = 0; i < 10; i++) {

		    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		    if (i == 0) {
		      frame = CGRectMake(10, 10, 50, 50);
		    } else {
		      frame = CGRectMake((i * 50) + (i*20) + 10, 10, 50, 50);
		    }
		    button.frame = frame;
		    button.layer.cornerRadius = 0.5 * button.bounds.size.width;
		    // [button setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
		    [button setTag:i];
		    [button setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]];
		    [button addTarget:self action:@selector(onClickofFilter:) forControlEvents:UIControlEventTouchUpInside];
		    [scrollView addSubview:button];

		    if (i == 9) {
		      x = CGRectGetMaxX(button.frame);
		    }

		  }

		  scrollView.contentSize = CGSizeMake(x, scrollView.frame.size.height);
		  [miniSettingsView addSubview:scrollView];
		  buttonScrollViewExists = YES;
	}
	%orig;
}

%end
