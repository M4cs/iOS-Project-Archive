%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
    %orig;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"TestTitle" message:@"TestMessage" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"tonysucks" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

%end