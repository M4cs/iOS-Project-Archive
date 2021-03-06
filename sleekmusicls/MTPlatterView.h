/*
* This header is generated by classdump-dyld 0.1
* on Wednesday, September 20, 2017 at 9:49:25 PM Eastern European Summer Time
* Operating System: Version 11.0 (Build 15A372)
* Image Source: /System/Library/PrivateFrameworks/MaterialKit.framework/MaterialKit
* classdump-dyld is free of use, Copyright Â© 2013 by Elias Limneos.
*/

#import <MaterialKit/MaterialKit-Structs.h>
#import <UIKit/UIView.h>
#import <MaterialKit/MTMaterialSettingsObserving.h>
#import <MaterialKit/MTPlatterInternal.h>
#import <MaterialKit/MTPlatter.h>

@class UIImageView, UIView, MTMaterialView, NSString;

@interface MTPlatterView : UIView <MTMaterialSettingsObserving, MTPlatterInternal, MTPlatter> {

	long long _recipe;
	unsigned long long _options;
	UIImageView* _shadowView;
	UIView* _mainContainerView;
	MTMaterialView* _mainOverlayView;
	UIView* _customContentView;
	bool _hasShadow;
	bool _backgroundBlurred;
	bool _usesBackgroundView;
	UIView* _backgroundView;
	double _cornerRadius;

}

@property (nonatomic,readonly) longlong recipe; 
@property (nonatomic,readonly) unsignedlonglong options; 
@property (nonatomic,readonly) MTMaterialView* backgroundMaterialView; 
@property (assign,nonatomic) double cornerRadius; 
@property (assign,getter=isHighlighted,nonatomic) bool highlighted; 
@property (readonly) unsignedlonglong hash; 
@property (readonly) Class superclass; 
@property (copy,readonly) NSString* description; 
@property (copy,readonly) NSString* debugDescription; 
@property (assign,nonatomic) double cornerRadius;                                         //@synthesize cornerRadius=_cornerRadius - In the implementation block
@property (assign,nonatomic) bool usesBackgroundView;                                     //@synthesize usesBackgroundView=_usesBackgroundView - In the implementation block
@property (nonatomic,retain) UIView* backgroundView;                                      //@synthesize backgroundView=_backgroundView - In the implementation block
@property (nonatomic,copy) NSString* groupName; 
@property (nonatomic,readonly) UIView* customContentView;                                 //@synthesize customContentView=_customContentView - In the implementation block
@property (assign,nonatomic) bool hasShadow;                                              //@synthesize hasShadow=_hasShadow - In the implementation block
@property (assign,getter=isBackgroundBlurred,nonatomic) bool backgroundBlurred;           //@synthesize backgroundBlurred=_backgroundBlurred - In the implementation block
+(id)_shadowImageMask;
+(CGRect)_shadowImage:(id)arg1 frameForPlatterViewBounds:(CGRect)arg2 ;
-(id)initWithFrame:(CGRect)arg1 ;
-(void)setCornerRadius:(double)arg1 ;
-(double)cornerRadius;
-(void)layoutSubviews;
-(void).cxx_destruct;
-(void)dealloc;
-(void)setHighlighted:(bool)arg1 ;
-(bool)isHighlighted;
-(void)setGroupName:(id)arg1 ;
-(void)setBackgroundView:(id)arg1 ;
-(id)backgroundView;
-(unsigned long long)options;
-(id)groupName;
-(void)settings:(id)arg1 changedValueForKey:(id)arg2 ;
-(bool)hasShadow;
-(void)setHasShadow:(bool)arg1 ;
-(id)customContentView;
-(long long)recipe;
-(void)_configureMainOverlayView;
-(void)_configureBackgroundView:(id)arg1 ;
-(unsigned long long)_optionsForBackgroundWithBlur:(bool)arg1 ;
-(id)_newDefaultBackgroundView;
-(void)_configureMainContainerViewIfNecessary;
-(void)_configureShadowViewIfNecessary;
-(void)_configureMainOverlayViewIfNecessary;
-(void)_configureCustomContentView;
-(void)setUsesBackgroundView:(bool)arg1 ;
-(void)_willRemoveCustomContent:(id)arg1 ;
-(bool)usesBackgroundView;
-(CGSize)sizeThatFitsContentWithSize:(CGSize)arg1 ;
-(CGSize)contentSizeForSize:(CGSize)arg1 ;
-(bool)isBackgroundBlurred;
-(void)setBackgroundBlurred:(bool)arg1 ;
-(void)_configureCustomContentViewIfNecessary;
-(id)vibrantStylingProvider;
-(void)_configureBackgroundViewIfNecessary;
-(id)initWithRecipe:(long long)arg1 options:(unsigned long long)arg2 ;
-(id)backgroundMaterialView;
@end
