@interface _SFTabStateData : NSObject
@end

%hook _SFTabStateData

-(void)setPrivateBrowsing:(BOOL)privateBrowsing {
  if (privateBrowsing == YES) {
    UIAlertController *confirmationAlertController = [UIAlertController
                alertControllerWithTitle:@"Test"
                message:@"Test"
                preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction* confirmNo = [UIAlertAction
                actionWithTitle:@"ok"
                style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * action)
                {
                  //do nothing lmao
                }];

                [confirmationAlertController addAction:confirmNo];

                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:confirmationAlertController animated:YES completion:NULL];
              }
              return %orig;
}


%end
