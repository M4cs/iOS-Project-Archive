@interface SBDeckSwitcherViewController
{
    NSMutableArray *_displayItems;
}
@property(retain, nonatomic) NSArray *displayItems; // @synthesize displayItems=_displayItems;
- (void)_layoutDisplayItem:(id)arg1;
-(void)setDisplayItems:(NSArray*)items;
-(void)killDisplayItemOfContainer:(id)arg1 withVelocity:(CGFloat)arg2;
-(id)_itemContainerForDisplayItem:(id)arg1;
@end


static BOOL miniSettingsViewExists = NO;
UIView *miniSettingsView;


%hook SBDeckSwitcherViewController
-(void)viewDidLoad {
    if (!miniSettingsViewExists) {
        miniSettingsView = [[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.height/2 - 240, 480, 240, 72)]; // 320, 96 both * 0.75
        [miniSettingsView setBackgroundColor:[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1]];
        [[miniSettingsView layer] setCornerRadius:25.0f]; //35 for sicccckk circle dock
        miniSettingsView.tag = 420;
        [self.view addSubview:miniSettingsView];
        miniSettingsViewExists = YES;
    }
    %orig;
}

%end

//%hook SBDeckSwitcherPageView

//-(id)initWithFrame:(CGRect)arg1 {
//    CGRect r = arg1;
//    return %orig(CGRectMake(r.origin.x, r.origin.y, r.size.width * 0.70, r.size.height * 0.70));
//}
//
//%end
//
//%hook SBAppSwitcherPageView
//
//-(void)setCornerRadius:(double)arg1 {
//    %orig(40);
//}

//%end