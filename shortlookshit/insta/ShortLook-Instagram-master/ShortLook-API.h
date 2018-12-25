//
//  WARNING:
//  This file contains the required headers to compile a tweak that
//  interacts with ShortLook's contact photo API. Do not modify the
//  headers within, or it could lead to unexpected behaviour.
//
//  ---
//
//  ShortLook-API.h
//
//  Created by AppleBetas on 2018-05-18.
//  Copyright © 2018 Dynastic Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NCNotificationRequest, UNNotificationContent;

/// A ShortLook-displayable notification representing a real user notification sent by an application to the system.
@interface DDUserNotification : NSObject
/// A custom notification title, separate from the application's title.
@property (nonatomic, retain, readonly) NSString *notificationTitle;

/// A dictionary of any extra information included by ShortLook.
@property (nonatomic, retain) NSDictionary *userInfo;

/// The system notification request that created this notification.
@property (nonatomic, readonly, retain) NCNotificationRequest *request;

/// The user notification's content, sent by the application.
- (UNNotificationContent *)content;

/// A dictionary of any extra information provided by the application sending the notification.
- (NSDictionary *)applicationUserInfo;

/// The bundle identifier of the application this notification represents.
- (NSString *)senderIdentifier;
@end

/// An object representing settings for the photo to be provided by a promise.
@interface DDNotificationContactPhotoSettings: NSObject
/// The background colour to show for the contact photo view if the provided image contains any transparency.
@property (nonatomic, retain) UIColor *backgroundColor;

/// Whether or not ShortLook should automatically cache icons returned by your provider with the same photo identifier for the same application.
@property (nonatomic, assign) BOOL usesCaching;
@end

/// A promise representing a commitment to providing a contact icon for a notification.
@interface DDNotificationContactPhotoPromise: NSObject
/// An object holding the settings pertaining to the photo to be displayed.
@property (nonatomic, retain) DDNotificationContactPhotoSettings *settings;

/// Whether or not this promise has already been resolved or rejected.
@property (nonatomic, readonly, assign) BOOL isComplete;

// MARK: - Provider methods

/// Resolve this promise with the provided image, notifying ShortLook that you have received your image.
/// - NOTE: This method should only be ran from within `addResolver:`.
- (void)resolveWithImage:(UIImage *)image;

/// Reject this promise, notifying ShortLook that you failed to receive an image.
/// - NOTE: This method should only be ran from within `addResolver:`.
- (void)reject;
@end

/// An offer to fulfill a promise representing a commitment to providing a contact icon for a notification.
@interface DDNotificationContactPhotoPromiseOffer: NSObject
/// A unique identifier for the photo that will be provided by this promise.
@property (nonatomic, readonly, retain) NSString *photoIdentifier;

/// A string to replace the notification's title with, if it is required for your provider's context.
@property (nonatomic, retain) NSString *titleOverride;

/// Initialize a promise with the provided photo identifier.
- (instancetype)initWithPhotoIdentifier:(NSString *)photoIdentifier;

/// Create a promise offer that will return the image at the provided URL, if needed.
+ (instancetype)offerDownloadingPromiseWithPhotoIdentifier:(NSString *)photoIdentifier fromURL:(NSURL *)url;

/// Create a promise offer that will return the image at the provided URL, if needed, with custom settings.
+ (instancetype)offerDownloadingPromiseWithPhotoIdentifier:(NSString *)photoIdentifier fromURL:(NSURL *)url withSettings:(DDNotificationContactPhotoSettings *)settings;

/// Create a promise offer that will instantly return the provided image.
+ (instancetype)offerInstantlyResolvingPromiseWithPhotoIdentifier:(NSString *)photoIdentifier image:(UIImage *)image;

/// Create a promise offer that will instantly return the provided image with custom settings.
+ (instancetype)offerInstantlyResolvingPromiseWithPhotoIdentifier:(NSString *)photoIdentifier image:(UIImage *)image withSettings:(DDNotificationContactPhotoSettings *)settings;

/// Add the block that will run if your image is needed (as it will not be in some cases, such as if your image is already cached by ShortLook).
/// If your provider does any long-running or asynchronous operations, they should be done using this method.
/// Any code run inside the provider block will be performed on a background thread.
- (void)fulfillWithBlock:(void (^)(DDNotificationContactPhotoPromise *promise))block;
@end

/// An object that can provide contact photos for ShortLook notifications.
@protocol DDNotificationContactPhotoProviding <NSObject>
@required
/// Returns an offer to fulfill a promise to provide a contact photo for a notification.
- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification;
@end
