#define kName @"GlowBadge"
#import <Custom/defines.h>

#import <objc/runtime.h>

#import "thanks/PSListController.h"
#import "thanks/PSSpecifier.h"
#import "thanks/PSViewController.h"
#import "thanks/PSTableCell.h"
#import "thanks/TTTAttributedLabel.h"

@interface ThanksCell : PSTableCell <TTTAttributedLabelDelegate> {
    TTTAttributedLabel* mainLabel;
}
@end

@implementation ThanksCell

- (id)initWithSpecifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"thanksCell" specifier:specifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        int width = [[UIScreen mainScreen] bounds].size.width;
        
        CGRect frame = CGRectMake(10, 0, width - 10, 60);
        
        mainLabel = [[objc_getClass("TTTAttributedLabel") alloc] initWithFrame:frame];
        [mainLabel setNumberOfLines:0];
        mainLabel.lineBreakMode = NSLineBreakByWordWrapping;
        mainLabel.font = [UIFont systemFontOfSize:14];

        NSString* person1 = @"NoCommentOkay";

        [mainLabel setText:Xstr(@"Special thanks to @%@ for the icon!", person1)
            afterInheritingLabelAttributesAndConfiguringWithBlock:^(NSMutableAttributedString *mutableAttributedString) {
                //Make bold
                NSRange boldRange1 = [[mutableAttributedString string] rangeOfString:person1 options:NSCaseInsensitiveSearch];

                UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
                CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);

                if(font) {
                    [mutableAttributedString addAttribute:NSFontAttributeName value:(__bridge id)font range:boldRange1];
                    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:boldRange1];
                    //[mutableAttributedString addAttribute:NSUnderlineColorAttributeName value:[UIColor clearColor] range:boldRange1];
                    CFRelease(font);
                }
                
                return mutableAttributedString;
            }];

        mainLabel.textColor = [UIColor blackColor];
        mainLabel.delegate = self;

        //Add links
        NSRange r1 = [mainLabel.text rangeOfString:person1];
        [mainLabel addLinkToURL:[NSURL URLWithString:Xstr(@"action://twitter-%@", person1)] withRange:r1];
        
        [self.contentView addSubview:mainLabel];
    }
    
    return self;
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    NSString* sch = [url host];
    if([sch hasPrefix:@"twitter-"]) {
        NSString* twitter = [[sch componentsSeparatedByString:@"-"] objectAtIndex:1];
        XLog(Xstr(@"Opening url for %@...", twitter));
        Xurl(Xstr(@"http://twitter.com/%@", twitter));
    }
}

- (CGFloat)preferredHeightForWidth:(double)arg1 inTableView:(id)arg2 {
    return mainLabel.frame.size.height;
}

@end
