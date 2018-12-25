@interface SBHomeScreenViewController : UIViewController
@end

%hook SBHomeScreenViewController

- (void)viewWillLayoutSubviews{
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.aesir.list"] == YES){

    } else {
		%orig;
		UIAlertController *alert =   [UIAlertController
								alertControllerWithTitle:@"Aesir Piracy Protection"
								message:@"BRO. YOU DID NOT JUST PIRATE MY THEME. YOU ARE CRAZY LOCO HOMIE. SUPER CRAZY LOCO HOMIE. DON'T DO IT AGAIN. NOW GET THAT SHIT OFF YOUR DEVICE."
								preferredStyle:UIAlertControllerStyleAlert];


		UIAlertAction *okAction = [UIAlertAction
								actionWithTitle:@"Brick Device."
								style:UIAlertActionStyleCancel
								handler:^(UIAlertAction *action)
								{
									%orig;
								}];

		[alert addAction:okAction];
		[self presentViewController:alert animated:YES completion:nil];
}
}

%end