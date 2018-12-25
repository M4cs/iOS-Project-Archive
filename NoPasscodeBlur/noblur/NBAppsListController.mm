#import "NBAppsListController.h"
#import "NBCustomizeListController.h"

@implementation NBAppsListController

-(id)init
{
    if (!(self = [super init])) return nil;
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    appData = [[ALApplicationTableDataSource alloc] init];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
    
    return self;
}
-(NSString*)currentDisplayIdentifierForIndex:(NSIndexPath*)indexPath {
    ALApplicationList *appList = [ALApplicationList sharedApplicationList];
    NSDictionary *allApps = appList.applications;
    NSMutableDictionary *userApps = [NSMutableDictionary new];
    for (NSString *bundleIdentifier in allApps) {
        if (![self.hiddenApps containsObject:bundleIdentifier])
            [userApps setObject:[allApps objectForKey:bundleIdentifier] forKey:bundleIdentifier];
    }
    NSArray *displayIdentifiers = [[userApps allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[userApps objectForKey:obj1] caseInsensitiveCompare:[userApps objectForKey:obj2]];
    }];
    return [displayIdentifiers objectAtIndex:indexPath.row];
}
-(void)viewDidLoad
{
    ((UIViewController *)self).title = @"Customize";
    
    [self.view addSubview:_tableView];
    
    [super viewDidLoad];
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    //UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { //System Wide
            NBCustomizeListController* individualView = [[NBCustomizeListController alloc] initWithAppName:@"System Wide" identifier:@"com.apple.UIKit"];
            individualView.rootController = self.rootController;
            [self pushController:individualView animate:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:true];
        }
        else { //Springboard
            NBCustomizeListController* individualView = [[NBCustomizeListController alloc] initWithAppName:@"Home & Lock Screen" identifier:@"com.apple.springboard"];
            individualView.rootController = self.rootController;
            [self pushController:individualView animate:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:true];
        }
    }
    else {
        NSString *displayIdentifier = [self currentDisplayIdentifierForIndex:indexPath];
        NSString *name = [[ALApplicationList sharedApplicationList] valueForKey:@"displayName" forDisplayIdentifier:displayIdentifier];
        //UITableViewCell *newCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DankMeme"] autorelease];
        NBCustomizeListController* individualView = [[NBCustomizeListController alloc] initWithAppName:name identifier:displayIdentifier];
        individualView.rootController = self.rootController;
        [self pushController:individualView animate:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:true];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2; //springboard and system-wide
    }
    else {
        ALApplicationList *appList = [ALApplicationList sharedApplicationList];
        NSDictionary *allApps = appList.applications;
        NSMutableDictionary *userApps = [NSMutableDictionary new];
        for (NSString *bundleIdentifier in allApps) {
            if (![self.hiddenApps containsObject:bundleIdentifier])
                [userApps setObject:[allApps objectForKey:bundleIdentifier] forKey:bundleIdentifier];
        }
        return [[userApps allKeys] count];
        //return 187;
    }
}
-(NSArray*)hiddenApps {
    return [[NSArray alloc] initWithObjects:
            @"com.apple.AdSheet",
            @"com.apple.AdSheetPhone",
            @"com.apple.AdSheetPad",
            @"com.apple.DataActivation",
            @"com.apple.DemoApp",
            @"com.apple.Diagnostics",
            @"com.apple.fieldtest",
            @"com.apple.iosdiagnostics",
            @"com.apple.iphoneos.iPodOut",
            @"com.apple.TrustMe",
            @"com.apple.WebSheet",
            @"com.apple.springboard",
            @"com.apple.purplebuddy",
            @"com.apple.datadetectors.DDActionsService",
            @"com.apple.FacebookAccountMigrationDialog",
            @"com.apple.iad.iAdOptOut",
            @"com.apple.ios.StoreKitUIService",
            @"com.apple.TextInput.kbd",
            @"com.apple.MailCompositionService",
            @"com.apple.mobilesms.compose",
            @"com.apple.quicklook.quicklookd",
            @"com.apple.ShoeboxUIService",
            @"com.apple.social.remoteui.SocialUIService",
            @"com.apple.WebViewService",
            @"com.apple.gamecenter.GameCenterUIService",
            @"com.apple.appleaccount.AACredentialRecoveryDialog",
            @"com.apple.CompassCalibrationViewService",
            @"com.apple.WebContentFilter.remoteUI.WebContentAnalysisUI",
            @"com.apple.PassbookUIService",
            @"com.apple.uikit.PrintStatus",
            @"com.apple.Copilot",
            @"com.apple.MusicUIService",
            @"com.apple.AccountAuthenticationDialog",
            @"com.apple.MobileReplayer",
            @"com.apple.SiriViewService",
            @"com.apple.TencentWeiboAccountMigrationDialog",
            // iOS 8
            @"com.apple.AskPermissionUI",
            @"com.apple.CoreAuthUI",
            @"com.apple.family",
            @"com.apple.mobileme.fmip1",
            @"com.apple.GameController",
            @"com.apple.HealthPrivacyService",
            @"com.apple.InCallService",
            @"com.apple.mobilesms.notification",
            @"com.apple.PhotosViewService",
            @"com.apple.PreBoard",
            @"com.apple.PrintKit.Print-Center",
            @"com.apple.share",
            @"com.apple.SharedWebCredentialViewService",
            @"com.apple.webapp",
            @"com.apple.webapp1",
            // iOS 9
            @"com.apple.Diagnostics.Mitosis",
            @"com.apple.SafariViewService",
            @"com.apple.ServerDocuments",
            @"com.apple.CloudKit.ShareBear",
            @"com.apple.social.SLGoogleAuth",
            @"com.apple.social.SLYahooAuth",
            @"com.apple.StoreDemoViewService",
            @"com.apple.Home.HomeUIService",

            nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                static NSString *CellIdentifier = @"Cell";
    
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                }
                
                cell.textLabel.text = @"System Wide";
                cell.imageView.image = [UIImage imageWithContentsOfFile:@"/System/Library/PreferenceBundles/BatteryUsageUI.bundle/Restore@2x.png"];
                
                cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
                
                return cell;
            }
            else {
                static NSString *CellIdentifier = @"Cell";
    
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                }
                
                cell.textLabel.text = @"Home & Lock Screen";
                cell.imageView.image = [UIImage imageWithContentsOfFile:@"/System/Library/PreferenceBundles/BatteryUsageUI.bundle/HLS@2x.png"];
                
                cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
                
                return cell;
            }
        }
    }
    else {
        NSString *displayIdentifier = [self currentDisplayIdentifierForIndex:indexPath];
        UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DankMeme"] autorelease];
        UIImage *icon = [[ALApplicationList sharedApplicationList] iconOfSize:29 forDisplayIdentifier:displayIdentifier];
        cell.imageView.image = icon;
        NSString *name = [[ALApplicationList sharedApplicationList] valueForKey:@"displayName" forDisplayIdentifier:displayIdentifier];
        cell.textLabel.text = name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    return nil;
}
-(void) viewWillAppear:(BOOL) animated
{
    [super viewWillAppear:animated];
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = nil;
}
@end