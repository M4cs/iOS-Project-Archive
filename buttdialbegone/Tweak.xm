@interface DialerController : PhoneViewController
@end

static BOOL isEnabled = YES;

%hook DialerController

-(void)viewWillAppear:(bool){
	if (isEnabled)
		UIAlertController *confirmationAlertController = [UIAlertController
									alertControllerWithTitle:@"Confirm Call"
									message:@"Are you sure you want to place this call?"
									preferredStyle:UIAlertControllerStyleAlert];



		UIAlertAction* confirmYes = [UIAlertAction
									actionWithTitle:@"Yes"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										//Go ahead and like the image
										%orig;
									}];

		UIAlertAction* confirmNo = [UIAlertAction
									actionWithTitle:@"No"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										//do nothing lmao
									}];

		[confirmationAlertController addAction:confirmNo];
		[confirmationAlertController addAction:confirmYes];

		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:confirmationAlertController animated:YES completion:NULL];

}

%end