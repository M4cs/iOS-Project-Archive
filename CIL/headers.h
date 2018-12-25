@interface IGDate : NSObject <NSCoding>
{
    NSDate *_date;
    long long _microseconds;
}
+ (id)date;
@property(readonly, nonatomic) long long microseconds; // @synthesize microseconds=_microseconds;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (unsigned long long)hash;
- (_Bool)isEqual:(id)arg1;
- (id)description;
@property(readonly, nonatomic) double timeIntervalSince1970;
@property(readonly, nonatomic) NSDate *date; // @synthesize date=_date;
- (id)initWithDate:(id)arg1;
- (id)initWithTimeInterval:(double)arg1;
- (id)initWithMicroseconds:(long long)arg1;
@end

@interface IGFeedItem : NSObject{
	_Bool _hasLiked;
}
@property(readonly) IGDate *takenAt; // @synthesize takenAtDate=_takenAtDate;
@property(readonly) IGDate *takenAtDate; // @synthesize takenAtDate=_takenAtDate;
@property(readonly) _Bool hasLiked; // @synthesize hasLiked=_hasLiked;
@end

@interface ConfirmLikeExtra : NSObject
+ (NSDate *)postDate:(IGFeedItem*)post;
@end

@interface IGPostItem : NSObject
@end

@interface IGFeedItemMediaCell : UICollectionViewCell
{
    NSArray *_defaultAccessibilityElements;
    // IGFeedItem *_post;
    // id <IGFeedItemMediaCellDelegate> _mediaCellDelegate;
    UINavigationController *_navigationController;
}
@end

@interface IGFeedItemPhotoCell : IGFeedItemMediaCell
{
    _Bool _hasShownSaveToCollectionUpsell;
    _Bool _hasLoggedSelectedImageSize;
    IGFeedItem *_post;
    // id <IGChainingImageLoadDelegate> _chainingImageDelegate;
    // IGFeedPhotoView *_photoView;
    // id <IGFeedItemPhotoCellDelegate> _photoCellDelegate;
    // id <IGZoomControllerZoomingDelegate> _zoomingDelegate;
    // IGZoomController *_zoomController;
}
@property(readonly, nonatomic) IGFeedItem *post; // @synthesize post=_post;
@end