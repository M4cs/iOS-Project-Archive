#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#include <spawn.h>

@interface ExcitantWindow : UIWindow
@end

@interface ExcitantView : UIView
@end

@interface UIStatusBarWindow : UIWindow
-(void)check;
@end

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString * bundleIdentifier;                                                                                         //@synthesize bundleIdentifier=_bundleIdentifier - In the implementation block
@property (nonatomic,readonly) NSString * displayName;
-(BOOL)isNowPlayingApplication;

@end

@interface SBMediaController : NSObject
+(id)sharedInstance;
-(BOOL)changeTrack:(int)arg1;
-(void)increaseVolume;
-(void)decreaseVolume;
-(void)_changeVolumeBy:(float)arg1 ;
-(float)volume;
-(void)setVolume:(float)arg1 ;
-(BOOL)isApplicationActivityActive;
-(SBApplication *)nowPlayingApplication;
-(BOOL)isPlaying;
-(BOOL)togglePlayPause;
+(BOOL)applicationCanBeConsideredNowPlaying:(id)arg1 ;

@end

@interface SBVolumeHardwareButtonActions : NSObject
-(void)addVolumePressBandit:(id)arg1 ;
-(void)removeVolumePressBandit:(id)arg1 ;
-(void)cancelVolumePress;
-(void)volumeIncreasePressDown;
-(void)volumeIncreasePressUp;
-(void)volumeDecreasePressDown;
-(void)volumeDecreasePressUp;
-(BOOL)_handleVolumeButtonDownForIncrease:(BOOL)arg1 ;
-(BOOL)_handleVolumeButtonUpForIncrease:(BOOL)arg1 ;
-(BOOL)_sendVolumeButtonToSBUIControllerForIncrease:(BOOL)arg1 down:(BOOL)arg2 ;
-(BOOL)_handleVolumeIncreaseUp;
-(BOOL)_handleVolumeDecreaseUp;
-(void)_sendBanditsVolumeDecreased;
-(void)handleTimer:(NSTimer *)timer;
@end
