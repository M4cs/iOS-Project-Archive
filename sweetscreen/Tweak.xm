@interface NCNotificationCombinesListViewController
@end

@implementatiion UIScrollView

%hook NCNotificationCombinesListViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 250, 150)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.alpha = 0.65f;
    [self.view addSubview:scrollView];

    scrollView setContentSize:CGSizeMake(250 * 2, 150)

    [scrollView addSubview:visualEffectView];

}

%new

-(void)addButtonsToScrolLView {
    NSInteger buttonCount = 15;

    CGRect buttonFrame = CGRectMake(5.0f, 5.0f, self.scollView.frame.size.width-10.0f, 40.0f);

    for (int index = 0; index <buttonCount; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setFrame:buttonFrame];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:index+1];}

        NSString *title = [NSString stringWithFormat:@"Button %d",index+1];
        [button setTitle:title forState:UIControlStateNormal];

        [self.scrollView setContentSize:contentSize];
}

-(void)buttonPressed:(UIButton *)button {
    switch (button.tag){
      case 1:

        break;

      case 2:

        break;

      case 3:

        break;

      case 4:

        break;

      case 5:

        break;

      case 6:

        break;

      case 7:

        break;

      case 8:

        break;

      case 9:

        break;

      case 10:

        break;

      default:

        break;
    }
}

%end
