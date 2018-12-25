#import <Preferences/Preferences.h>
#import <AppList/AppList.h>

@interface ALApplicationTableDataSource (Private)
- (void)sectionRequestedSectionReload:(id)section animated:(BOOL)animated;
@end

@interface ALApplicationList (Private)
- (NSInteger)applicationCount;
-(NSArray*)_hiddenDisplayIdentifiers;
- (BOOL)applicationWithDisplayIdentifierIsHidden:(NSString *)displayIdentifier;
@end

@interface ALLinkCell : ALValueCell
@end

@implementation ALLinkCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
  self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return self;
}
@end

@interface PSViewController (NoBlurBlacklist)
-(UINavigationController*)navigationController;
-(void)viewDidLoad;
-(void)viewWillDisappear:(BOOL)animated;
-(void)viewWillAppear:(BOOL)animated;
-(void)setTitle:(NSString*)title;
-(void)pushController:(id)arg1 animate:(BOOL)arg2;
-(void)setRootController:(id)arg1;
@end

@interface NBAppsListController : PSViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView* _tableView;
    ALApplicationTableDataSource* appData;
    UIWindow *settingsView;
}
-(NSString*)currentDisplayIdentifierForIndex:(NSIndexPath*)indexPath;
@end
