@interface UIDevice : NSObject
-(long long)batteryState

%hook UIDevice

- (void)_setBatteryState:(UIDeviceBatteryState)state{
	if (state == 1) {
		//unplugged
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"UnPlugged"
		message:@"Your device has stopped charging." preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
		[alertController addAction:actionOk];
		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
	}
	else {
		return nil;
	}
}

%end
