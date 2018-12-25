#import "NBPreViewController.h"
#import <dlfcn.h>
#define springBoardPath @"/var/mobile/Library/SpringBoard/"
static NSString *const NBPrefsPath = @"/var/mobile/Library/Preferences/com.xtm3x.noblur.plist";

@implementation NBBackdropView

@end

static void WSLog(NSString* string) {
    NSString *directoryToWrite = @"/var/mobile/Library/Preferences";
    NSString *documentPath = [directoryToWrite stringByAppendingPathComponent:@"Log.txt"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:documentPath])
    {
        //If no file exists, create it and write the first line to it
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [@"beginning of file\n" writeToFile:documentPath atomically:NO];
        #pragma clang diagnostic pop   
        WSLog(string); 
    }
    else {
        NSDate *someDateInUTC = [NSDate date];
        NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
        NSDate *dateInLocalTimezone = [someDateInUTC dateByAddingTimeInterval:timeZoneSeconds];
        //If a file does exist, insert a break and append it.
        NSString *textToWrite = [NSString stringWithFormat:@"[%@] %@\n", dateInLocalTimezone, string];
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:documentPath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[textToWrite dataUsingEncoding:NSUTF8StringEncoding]];
    }
}

@implementation NBPreViewController
-(NSArray*)specifiers {
    return nil;
}
- (void)setSpecifier:(PSSpecifier*)specifier {
    WSLog([specifier propertyForKey:@"setterKey"]);
    WSLog([specifier propertyForKey:@"mode"]);
    key = (CFStringRef)[specifier propertyForKey:@"setterKey"];
    mode = [[specifier propertyForKey:@"mode"] intValue];
    [super setSpecifier:specifier];
}
-(UIImage*)getWallpaper {
    void *appsupport = dlopen("/System/Library/PrivateFrameworks/AppSupport.framework/AppSupport", 2);
    CFArrayRef (*nb_CPBitmapCreateImagesFromData)(CFDataRef cpbitmap, void*, int, void*);
    *(void **)(&nb_CPBitmapCreateImagesFromData) = dlsym(appsupport, "CPBitmapCreateImagesFromData");
    
    NSString *imagePath = [springBoardPath stringByAppendingPathComponent:@"HomeBackground.cpbitmap"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath])
        imagePath = [springBoardPath stringByAppendingPathComponent:@"LockBackground.cpbitmap"];

    NSArray *wallpapers = (__bridge NSArray *)(nb_CPBitmapCreateImagesFromData((__bridge CFDataRef)([NSData dataWithContentsOfFile:imagePath]), NULL, 1, NULL));
    [wallpapers retain];
    [wallpapers retain];
    return [UIImage imageWithCGImage:(CGImageRef)[wallpapers objectAtIndex:0]];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:NBPrefsPath];
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
    slider = [[UISlider alloc] init];
    [slider addTarget:self action:@selector(updateBackdrop) forControlEvents:UIControlEventValueChanged];
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    UINavigationItem *navItem = self.navigationItem;
    navItem.titleView = slider;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.getWallpaper];
    blurView = [[NBBackdropView alloc] initWithStyle:2060];
    _UIBackdropViewSettings *settings = blurView.inputSettings;
    [settings setBlurRadius:0.0];
    if (mode == 0) {
        slider.value = [dict objectForKey:@"utintf"] ? [[dict objectForKey:@"utintf"] floatValue] : 0.4;
        [settings setGrayscaleTintAlpha:slider.value];
        [settings setColorTintAlpha:slider.value];
        if ([[dict objectForKey:@"oLevel"] boolValue]) {
        	[settings setGrayscaleTintLevel:[[dict objectForKey:@"ulevelf"] floatValue]];
        }
    }
    else if (mode == 1) {
        slider.value = [[dict objectForKey:@"ulevelf"] floatValue];
        if ([[dict objectForKey:@"oTint"] boolValue]) {
        	[settings setGrayscaleTintAlpha:[dict objectForKey:@"utintf"] ? [[dict objectForKey:@"utintf"] floatValue] : 0.4];
        	[settings setColorTintAlpha:[dict objectForKey:@"utintf"] ? [[dict objectForKey:@"utintf"] floatValue] : 0.4];
        }
        [settings setGrayscaleTintLevel:slider.value];
    }
    [blurView transitionToSettings:settings];
    [blurView _setBlursBackground:NO];
    [imageView addSubview:blurView];
    [self.table setBackgroundView:imageView];
    [self.table setBackgroundColor:[UIColor clearColor]];
    if (slider.value <= 0.01) {
    	currentValue = [[NSString stringWithFormat:@"%f", slider.value] substringToIndex:1];
    }
    else {
    	currentValue = [[NSString stringWithFormat:@"%f", slider.value] substringToIndex:4];
    }
    valueButton = [[UIBarButtonItem alloc] initWithTitle:currentValue style:UIBarButtonItemStyleDone target:self action:@selector(inputValue)];
    NSDictionary *valueButtonDict = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    [valueButton setTitleTextAttributes:valueButtonDict forState:UIControlStateNormal];
    ((UINavigationItem*)self.navigationItem).rightBarButtonItem = valueButton;
    [dict release];
    [slider release];
    [imageView release];
    [blurView release];
    [valueButton release];
    // [UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [UIColor colorWithRed:43.0f/255.0f green:99.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
}
-(void)inputValue  {
    alert = [[UIAlertView alloc] initWithTitle:@"Enter Value"
                          message:[NSString stringWithFormat:@"Please enter a value between %.01f and %.01f.", slider.minimumValue, slider.maximumValue]
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Enter"
                          , nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 56732;
    [alert show];
    [[alert textFieldAtIndex:0] setDelegate:self];
    [[alert textFieldAtIndex:0] resignFirstResponder];
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    BOOL needsPoint = slider.maximumValue - slider.minimumValue <= 10;
    if( UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad && needsPoint) {
        UIToolbar* toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        UIBarButtonItem* pointButton = [[UIBarButtonItem alloc] initWithTitle:@"Point" style:UIBarButtonItemStylePlain target:self action:@selector(typePoint)];
        NSArray* buttons = [NSArray arrayWithObjects: pointButton, nil];
        [toolBar setItems:buttons animated:NO];
        [[alert textFieldAtIndex:0] setInputAccessoryView:toolBar];
    }
    [[alert textFieldAtIndex:0] becomeFirstResponder];
}
-(void)typePoint {
    if (alert) {
        NSString* text = [alert textFieldAtIndex:0].text;
        [alert textFieldAtIndex:0].text = [NSString stringWithFormat:@"%@.", text];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 56732) {
        if(buttonIndex == 1) {
            CGFloat value = [[alertView textFieldAtIndex:0].text floatValue];
            if (value <= slider.maximumValue && value >= slider.minimumValue) {
                slider.value = value;
                [self updateBackdrop];
                //CFPreferencesSetAppValue(CFSTR("utintf"), (__bridge CFNumberRef)[NSNumber numberWithFloat:slider.value], CFSTR("com.xtm3x.noblur~prefs"));
            }
            else {
                UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:@"Ensure you enter a valid value."
                                                                     delegate:self
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil
                                            , nil];
                errorAlert.tag = 678930;
                [errorAlert show];
                [errorAlert release];
            }
        }
        [[alertView textFieldAtIndex:0] resignFirstResponder];
    }
    else if (alertView.tag == 678930) {
        [self inputValue];
    }
}
-(void)updateBackdrop {
    _UIBackdropViewSettings *settings = blurView.inputSettings;
    if (mode == 0) {
        [settings setGrayscaleTintAlpha:slider.value];
        [settings setColorTintAlpha:slider.value];
    }
    else if (mode == 1) {
        [settings setGrayscaleTintLevel:slider.value];
    }
    if (slider.value <= 0.01) {
    	currentValue = [[NSString stringWithFormat:@"%f", slider.value] substringToIndex:1];
    }
    else {
    	currentValue = [[NSString stringWithFormat:@"%f", slider.value] substringToIndex:4];
    }
    [blurView transitionToSettings:settings];
    valueButton.title = currentValue;
    [self updatePreferences];
}
-(void)updatePreferences {
    CFPreferencesSetAppValue(key, (__bridge CFNumberRef)[NSNumber numberWithFloat:slider.value], CFSTR("com.xtm3x.noblur"));
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    settingsView = [[UIApplication sharedApplication] keyWindow];
    settingsView.tintColor = nil;
}
@end