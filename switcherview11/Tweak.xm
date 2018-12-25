@interface SBDeckSwitcherViewController : UIViewController
@end


@interface CCUIControlCenterContainerView : UIView
@end

@interface FBSystemService : NSObject
+(id)sharedInstance;
-(void)exitAndRelaunch:(bool)arg1;
@end


// CGFloat fadeDuration = 0.2f;

static BOOL miniSettingsViewExists = NO;
static BOOL buttonScrollViewExists = NO;
UIView *miniSettingsView;
CGFloat buttonWidth = 50;
NSInteger numbersPerPage = 4;
NSInteger multiple;

// NSInteger buttonPerPage;


CGFloat btnFrameX = 10.0;

%hook SBDeckSwitcherViewController
-(void)viewWillLayoutSubviews {
	if (!miniSettingsViewExists) {
		// CGFloat miniViewWidth = (10+(buttonWidth+20)*4)
		CGFloat miniViewWidth = 280;
		miniSettingsView = [[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - (miniViewWidth/2), 495, miniViewWidth, 72)]; // 320, 96 both * 0.75
		[miniSettingsView setBackgroundColor:[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1]];
		[[miniSettingsView layer] setCornerRadius:25.0f]; //35 for sicccckk circle dock
		miniSettingsView.tag = 420;
		[self.view addSubview:miniSettingsView];
		miniSettingsView.alpha = 1;
		miniSettingsViewExists = YES;
	}
	if (!buttonScrollViewExists) {

		UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, miniSettingsView.frame.size.width, miniSettingsView.frame.size.height)];
		[scrollView setPagingEnabled: YES];
		scrollView.tag = 421;

		  int x = 0;
		  CGRect frame;
		  for (int i = 0; i < 10; i++) {

		    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		    if (i == 0)
			frame = CGRectMake(10, 10, buttonWidth, buttonWidth);
		    else
		    	frame = CGRectMake((i * buttonWidth) + (i*20) + 10, 10, buttonWidth, buttonWidth);
		    button.frame = frame;
		    button.layer.cornerRadius = 0.5 * button.bounds.size.width;
		    [button setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
		    [button setTag:i];
		    if (i==0) {
			    UIImage *respringImage = [UIImage imageNamed:@"image.png"];
			    [button setImage:respringImage forState:UIControlStateNormal];
			} else
		    	[button setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]];
		    [button addTarget:self action:@selector(tonysGarbageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		    [scrollView addSubview:button];

		    if (i == 9) {
		      x = CGRectGetMaxX(button.frame);
		    }

		  }

		  CGSize contentSize = scrollView.frame.size;
		 while(multiple * numbersPerPage < 10)
		  	multiple++;
		 contentSize.width = ((multiple * numbersPerPage) * buttonWidth) + ((multiple * numbersPerPage)*20);
		  scrollView.contentSize = contentSize;
		  [miniSettingsView addSubview:scrollView];
		  buttonScrollViewExists = YES;
	}
	%orig;
}
%new 
-(void)tonysGarbageButtonPressed:(id)sender{
	switch (sender.tag) {
      case 0:
        [[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
        break;
      case 1:
        //second button
        break;
      case 2:
        //third button
        break;
      case 3:
        //fourth button
        break;
      case 4:
        //fifth button
        break;
      case 5:
        //sixth button
        break;
      default:
        //button tag not found
        break;
   }
}
%end

%hook SBDeckSwitcherPageView

-(id)initWithFrame:(CGRect)arg1 {
	CGRect r = arg1;
	return %orig(CGRectMake(r.origin.x, r.origin.y, r.size.width * 0.70, r.size.height * 0.70));
}

%end

%hook SBAppSwitcherPageView

-(void)setCornerRadius:(double)arg1 {
	%orig(40);
}

%end