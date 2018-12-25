#import <Preferences/Preferences.h>

#import "GroupTableView.h"

#define kName @"ConvoProtect"
#import <Custom/defines.h>

#define kSettingsPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.sassoty.convoprotect.plist"]

@interface LockedWhatsAppListController: PSViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *tabView;
    NSMutableArray *whatsappArray;
    int indexPathToUse;
    NSMutableDictionary *prefs;
}
@end

@implementation LockedWhatsAppListController

- (void)viewDidLoad {

    tabView = [[UITableView alloc] initWithFrame:kBounds];
    //cpNavBar = [[UINavigationBar alloc] init];

    tabView.delegate = self;
    tabView.dataSource = self;
    [tabView setAlwaysBounceVertical:YES];

    prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:kSettingsPath];
    if(!prefs) prefs = [[NSMutableDictionary alloc] init];
    
    whatsappArray = prefs[@"WhatsAppLockedConvos"];
    if(!whatsappArray)
        whatsappArray = [[NSMutableArray alloc] init];

    [self.view addSubview:tabView];
    [tabView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];

}

- (NSInteger)tableView:(UITableView* )tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0) return 1;
    return [whatsappArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView* )tableView{
    return 2;
}

- (NSString* )tableView:(UITableView* )tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) return @"Add";
    return @"Settings";
}

- (void)tableView:(UITableView* )tableView didSelectRowAtIndexPath:(NSIndexPath* )indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if(indexPath.section == 0) {

        if(indexPath.row == 0) {

            UIAlertView* alert = [[UIAlertView alloc] 
            initWithTitle:@"ConvoProtect"
            message:@"Please enter the name exactly as it appears on WhatsApp:"
            delegate:self
            cancelButtonTitle:@"Cancel"
            otherButtonTitles:@"Save", nil];

            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];

            UITextField* user = [alert textFieldAtIndex:0];
            [user setPlaceholder:@"Name"];

            [alert setTag:1];
            [alert show];
            //[alert release];

        }

    }

    if(indexPath.section == 1) {

        indexPathToUse = indexPath.row;

        UIAlertView* alert = [[UIAlertView alloc] 
            initWithTitle:@"ConvoProtect"
            message:@"Edit name:"
            delegate:self
            cancelButtonTitle:@"Cancel"
            otherButtonTitles:@"Save", nil];

        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];

        UITextField* user = [alert textFieldAtIndex:0];
        [user setPlaceholder:@"Name"];
        [user setText:[whatsappArray objectAtIndex:indexPath.row]];

        [alert setTag:2];
        [alert show];
        //[alert release];

    }

}

- (void)alertView:(UIAlertView* )alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) return;

    NSString* whatsapp = [alertView textFieldAtIndex:0].text;
    
    prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:kSettingsPath];
    if (alertView.tag == 1 && buttonIndex == 1) {

        [whatsappArray addObject:whatsapp];

        prefs[@"WhatsAppLockedConvos"] = whatsappArray;
        [prefs writeToFile:kSettingsPath atomically:YES];

        [tabView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];

        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.sassoty.convoprotect/preferencechanged"),
            NULL,
            NULL,
            true
            );

    }

    if(alertView.tag == 2) {
        if(buttonIndex == 1) {

            [whatsappArray removeObjectAtIndex:indexPathToUse];
            [whatsappArray insertObject:whatsapp atIndex:indexPathToUse];

            prefs[@"WhatsAppLockedConvos"] = whatsappArray;
            [prefs writeToFile:kSettingsPath atomically:YES];

            [tabView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];

            CFNotificationCenterPostNotification(
                CFNotificationCenterGetDarwinNotifyCenter(),
                CFSTR("com.sassoty.convoprotect/preferencechanged"),
                NULL,
                NULL,
                true
                );

        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 1) return YES;
	return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if(editingStyle == UITableViewCellEditingStyleDelete) {

        NSString* logLog = [NSString stringWithFormat:@"Deleting... %@", [whatsappArray objectAtIndex:indexPath.row]];
        XLog(logLog);

		[whatsappArray removeObjectAtIndex:indexPath.row];

        prefs[@"WhatsAppLockedConvos"] = whatsappArray;
        [prefs writeToFile:kSettingsPath atomically:YES];

        [tabView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];

        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.sassoty.convoprotect/preferencechanged"),
            NULL,
            NULL,
            true
            );

	}
}

- (UITableViewCell* )tableView:(UITableView* )tableView cellForRowAtIndexPath:(NSIndexPath* )indexPath
{
    
    static NSString* CellIdentifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", str];

    if(indexPath.section == 1) cell.textLabel.text = [whatsappArray objectAtIndex:indexPath.row];
    if(indexPath.section == 0) {
        if(indexPath.row == 0) cell.textLabel.text = @"Add Name";
    }

    return cell;
    
}

@end
