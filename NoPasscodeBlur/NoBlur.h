@interface SBDockView
-(void)setBackgroundAlpha:(CGFloat)arg1;
@end

@interface _UIBackdropViewSettings : NSObject
@property(nonatomic)CGFloat blurRadius;
@property(nonatomic)CGFloat grayscaleTintAlpha;
-(void)setBlurRadius:(CGFloat)arg1 ;
-(void)setColorTintAlpha:(CGFloat)arg1 ;
-(void)setColorTintLevel:(CGFloat)arg1 ;
-(void)setGrayscaleTintLevel:(CGFloat)arg1;
-(void)setSaturationDeltaFactor:(CGFloat)arg1;
-(void)setScale:(CGFloat)arg1;
+(id)settingsForStyle:(long long)arg1 ;
+(id)settingsForStyle:(long long)arg1 graphicsQuality:(long long)arg2 ;
-(id)backdrop;
-(CGFloat)grayscaleTintAlpha;
-(CGFloat)grayscaleTintLevel;
-(CGFloat)colorTintAlpha;
@end

@interface _UIBackdropView : UIView
@property(retain, nonatomic) _UIBackdropViewSettings *inputSettings;
-(void)transitionToSettings:(id)arg1;
-(void)_setBlursBackground:(BOOL)arg1;
- (void)transitionToStyle:(int)style;
-(void)setColorMatrixGrayscaleTintAlpha:(CGFloat)arg1;
-(CGFloat)colorMatrixGrayscaleTintAlpha;
-(void)setBlurRadius:(CGFloat)arg1 ;
-(CGFloat)blurRadius;
-(int)style;
@end

@interface SBControlCenterContentContainerView : UIView
-(_UIBackdropView *)backdropView;
@end

@interface SBNotificationCenterViewController : UIViewController
-(_UIBackdropView *)backdropView;
@end

@interface SBBannerContextView : UIView
@property (nonatomic,retain,readonly) _UIBackdropView * backdrop;
@end

@interface _UINavigationBarBackground : UIView
-(_UIBackdropView *)_adaptiveBackdrop;
@end

@interface SBBackdropView : _UIBackdropView {

	double _transitionProgress;
	double _initialScale;
	double _finalScale;

}
-(void)applySettings:(id)arg1 ;
-(void)transitionIncrementallyToSettings:(id)arg1 weighting:(double)arg2 ;
-(void)transitionComplete;
@end

@interface SBUIPasscodeLockViewBase : UIView
@property (assign,nonatomic) double backgroundAlpha;
@end

@interface SBDashBoardBackgroundView : UIView {

	long long _style;
	long long _transitionStyle;
	BOOL _transitioning;
	double _progress;
	SBBackdropView* _backdropView;
	UIView* _reduceTransparencyView;
	UIView* _sourceOverView;
	UIView* _darkenSourceOverView;
	UIView* _tintView;

}

@property (nonatomic,readonly) SBBackdropView * backdropView;                                                        //@synthesize backdropView=_backdropView - In the implementation block
@property (nonatomic,retain) NSString * groupName; 
@property (readonly) unsigned long long hash; 
@property (readonly) Class superclass; 
@property (copy,readonly) NSString * description; 
@property (copy,readonly) NSString * debugDescription; 
@property (assign,nonatomic) long long backgroundStyle;                                                              //@synthesize style=_style - In the implementation block
@property (getter=isTransitioningBackgroundStyle,nonatomic,readonly) BOOL transitioningBackgroundStyle;              //@synthesize transitioning=_transitioning - In the implementation block
-(void)beginTransitionToBackgroundStyle:(long long)arg1 ;
-(void)updateBackgroundStyleTransitionProgress:(double)arg1 ;
-(BOOL)isTransitioningBackgroundStyle;
-(void)completeTransitionToBackgroundStyle:(long long)arg1 ;
-(void)_updateAppearanceForBackgroundStyle:(long long)arg1 transitionToSettings:(BOOL)arg2 ;
-(void)_updateAppearanceForTransitionFromStyle:(long long)arg1 toStyle:(long long)arg2 withProgress:(double)arg3 ;
-(double)_darkenValueForBackgroundStyle:(long long)arg1 ;
-(void)_darkenWithProgress:(double)arg1 ;
-(double)_tintValueForBackgroundStyle:(long long)arg1 ;
-(void)_tintWithProgress:(double)arg1 ;
-(double)_reducedTransparencyValueForBackgroundStyle:(long long)arg1 ;
-(void)_reduceTransparencyWithProgress:(double)arg1 ;
-(double)_valueFromStart:(double)arg1 toEnd:(double)arg2 withFraction:(double)arg3 ;
-(id)_backgroundColorForDarkenAlpha:(double)arg1 andProgress:(double)arg2 ;
-(id)initWithFrame:(CGRect)arg1 ;
-(void)layoutSubviews;
-(long long)backgroundStyle;
-(void)setBackgroundStyle:(long long)arg1 ;
-(NSString *)groupName;
-(void)setGroupName:(NSString *)arg1 ;
-(SBBackdropView *)backdropView;
@end

@interface NCMaterialView : UIView {

	unsigned long long _styleOptions;
	_UIBackdropView* _backdropView;
	UIView* _lightOverlayView;
	UIView* _whiteOverlayView;
	UIView* _cutoutOverlayView;
	UIView* _colorInfusionView;
	double _colorInfusionViewAlpha;
	double _subviewsContinuousCornerRadius;

}

@property (assign,setter=_setColorInfusionViewAlpha:,getter=_colorInfusionViewAlpha,nonatomic) double colorInfusionViewAlpha;                                      //@synthesize colorInfusionViewAlpha=_colorInfusionViewAlpha - In the implementation block
@property (assign,setter=_setSubviewsContinuousCornerRadius:,getter=_subviewsContinuousCornerRadius,nonatomic) double subviewsContinuousCornerRadius;              //@synthesize subviewsContinuousCornerRadius=_subviewsContinuousCornerRadius - In the implementation block
@property (nonatomic,copy) NSString * groupName; 
@property (nonatomic,retain) UIView * colorInfusionView;                                                                                                           //@synthesize colorInfusionView=_colorInfusionView - In the implementation block
@property (assign,nonatomic) double grayscaleValue; 
+(id)materialViewWithStyleOptions:(unsigned long long)arg1 ;
-(void)dealloc;
-(NSString *)groupName;
-(void)setGroupName:(NSString *)arg1 ;
-(UIView *)colorInfusionView;
-(void)setColorInfusionView:(UIView *)arg1 ;
-(id)initWithStyleOptions:(unsigned long long)arg1 ;
-(void)_configureIfNecessary;
-(void)_reduceTransparencyStatusDidChange;
-(void)_configureColorInfusionViewIfNecessary;
-(void)_configureBackdropViewIfNecessary;
-(void)_configureLightOverlayViewIfNecessary;
-(void)_configureWhiteOverlayViewIfNecessary;
-(void)_configureCutoutOverlayViewIfNecessary;
-(void)_setSubviewsContinuousCornerRadius:(double)arg1 ;
-(void)_setColorInfusionViewAlpha:(double)arg1 ;
-(double)grayscaleValue;
-(void)setGrayscaleValue:(double)arg1 ;
-(double)_colorInfusionViewAlpha;
-(double)_subviewsContinuousCornerRadius;
@end