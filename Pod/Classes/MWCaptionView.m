//
//  MWCaptionView.m
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 30/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MWCommon.h"
#import "MWCaptionView.h"
#import "MWPhoto.h"
#import "UIImage+MWPhotoBrowser.h"

static const CGFloat labelPadding = 15;
static const CGFloat hintImageViewHeight = 44;

// Private
@interface MWCaptionView () {
    id <MWPhoto> _photo;
    UILabel *_label;
    UILabel *_secondLabel;
}
@end

@implementation MWCaptionView

- (id)initWithPhoto:(id<MWPhoto>)photo withFontName:(NSString *)fontName {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)]; // Random initial frame
    if (self) {
        self.userInteractionEnabled = NO;
        _photo = photo;
        
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextFillRect(context, rect);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self setBackgroundImage:image forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        self.tintColor = nil;
        self.barTintColor = nil;
        self.clipsToBounds = YES;
        //self.barStyle = UIBarStyleBlackTranslucent;
        //[self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self setupCaption:fontName];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, hintImageViewHeight);
}

- (void)setupCaption:(NSString *)fontName {
    NSArray <NSString *> *textArray = nil;
    NSString *text = @"";
    if ([_photo respondsToSelector:@selector(caption)]) {
        text = [_photo caption] ? [_photo caption] : @" ";
    }
    if (text && text.length>0) {
        textArray = [text componentsSeparatedByString:@"\n"];
    }
    if (textArray && textArray.count>0) {
        if (textArray.count>1) {
            _label = [self configureLabel:_label withText:textArray[0] topOffset:0 labelHeight:19 fontName:fontName];
            [self addSubview:_label];
            
            _secondLabel = [self configureLabel:_secondLabel withText:textArray[1] topOffset:_label.frame.size.height labelHeight:_label.frame.size.height fontName:fontName];
            [self addSubview:_secondLabel];
            
        } else {
            _label = [self configureLabel:_label withText:textArray[0] topOffset:0 labelHeight:self.bounds.size.height fontName:fontName];
            [self addSubview:_label];
        }
    }
}

- (UILabel *)configureLabel:(UILabel *)label withText:(NSString *)text topOffset:(CGFloat)topOffset labelHeight:(CGFloat)labelHeight fontName:(NSString *)fontName {
    label = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(labelPadding, topOffset,
                                                                     [[UIScreen mainScreen] bounds].size.width - labelPadding * 2,
                                                                     labelHeight))];
    label.text = text;
    label.opaque = NO;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.numberOfLines = 1;
    label.textColor =  [UIColor colorWithRed:137.f/255.f green:137.f/255.f blue:137.f/255.f alpha:1.f];
    label.font = [UIFont fontWithName:fontName size:15];
    return label;
}

@end
