#include "PickPocketLSInfoListController.h"

@implementation PickPocketLSInfoListController

+ (NSString *)hb_specifierPlist {
    return @"LSInfo";
}

+ (UIColor *)hb_tintColor {
    return [UIColor colorWithRed:252.f / 255.f green:89.f / 255.f blue:121.f / 255.f alpha:1];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (void)userImage {
    UIAlertView *askImageType = [[UIAlertView alloc] initWithTitle:@"PickPocket" message:@"Choose your user image" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Take Photo", @"Choose Photo", @"Delete Photo", nil];
    [askImageType show];
    [askImageType release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;

    if (buttonIndex == 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if (buttonIndex == 2) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else if (buttonIndex == 3) {
        NSError *error = nil;
        NSString *imagePath = @"/var/mobile/Library/PickPocket/userImage.png";
        if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PickPocket"
                                                            message:@"No image has been chosen yet"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Dismiss"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        } else {
            [[NSFileManager defaultManager] removeItemAtPath:imagePath error:&error];
        }
    }

    if (buttonIndex == 1 || buttonIndex == 2) {
        [self.navigationController presentViewController:imagePicker animated:YES completion: nil];
        [imagePicker release];
    } else {
        [imagePicker release];
    }
}
#pragma clang diagnostic pop

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *picture = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImagePNGRepresentation(picture);
    [imageData writeToFile:@"/var/mobile/Library/PickPocket/userImage.png" atomically:YES];
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
