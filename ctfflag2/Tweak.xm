@interface SBHomeScreenViewController : UIViewController
@end

%hook SBHomeScreenViewController

- (void)viewWillLayoutSubviews{
  //  if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.jugojuarez.killyourself"] == YES){

  //  } else {
        %orig;
        UIAlertController *alert =   [UIAlertController
                                alertControllerWithTitle:@"Aesir Piracy Protection"
                                message:@"Congrats you have gotten the second flag! The key is Keemstar"
                                preferredStyle:UIAlertControllerStyleAlert];


        UIAlertAction *okAction = [UIAlertAction
                                actionWithTitle:@"Open Cydia to Uninstall"
                                style:UIAlertActionStyleCancel
                                handler:^(UIAlertAction *action)
                                {
                                    %orig;
                                }];

        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
}
//}

%end
