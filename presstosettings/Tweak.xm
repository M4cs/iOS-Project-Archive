@interface CCUILabeledRoundButton : UIView
@property (nonatomic, copy, readwrite) NSString *title;
@end

%hook CCUILabeledRoundButton

-(void)layoutSubviews {
%orig;

if ([self.title isEqualToString:[[NSBundle bundleWithPath:@"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey:@"CONTROL_CENTER_STATUS_WIFI_NAME" value:@"CONTROL_CENTER_STATUS_WIFI_NAME" table:@"Localizable"]] || [self.title isEqualToString:[[NSBundle bundleWithPath:@"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey:@"CONTROL_CENTER_STATUS_WLAN_NAME" value:@"CONTROL_CENTER_STATUS_WLAN_NAME" table:@"Localizable"]]) {
    //wifi module pressed
        //create long press gesture recognizer(gestureHandler will be triggered after gesture is detected)
        UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandler:)];
        //adjust time interval(floating value CFTimeInterval in seconds)
        [longPressGesture setMinimumPressDuration:6.0];
        //add gesture to view you want to listen for it(note that if you want whole view to "listen" for gestures you should add gesture to self.view instead)
        [self addGestureRecognizer:longPressGesture];
        [longPressGesture release];
    }
}
%new 
-(void)gestureHandler:(UISwipeGestureRecognizer *)gesture
{
    if(UIGestureRecognizerStateBegan == gesture.state)
    {//your code here
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"TestTitle" message:@"longpress success" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}

%end