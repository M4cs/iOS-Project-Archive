@interface DialerController : UIViewController
@end

%hook DialerController
-(void)_callButtonPressed:(id)arg1{

    UIView *dialerView = MSHookIvar<UIView *>(self, "_dialerView");
    UILabel *_lcd = MSHookIvar<UILabel *>(dialerView, "_lcd");
    NSString *numberToCall = [_lcd text];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ConfirmCall" message:[NSString stringWithFormat:@"Are you sure want to call %@", numberToCall] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yeah" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        // confirm call action example
        %orig;
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Nope" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        // do nothing
    }];

    [alert addAction:yesAction];
    [alert addAction:noAction];
     [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];

}
%end