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
    _label = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(labelPadding, 0,
                                                       self.bounds.size.width - labelPadding * 2,
                                                       self.bounds.size.height))];
    _label.opaque = NO;
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.lineBreakMode = NSLineBreakByTruncatingTail;

    _label.numberOfLines = 1;
    _label.textColor =  [UIColor colorWithRed:137.f/255.f green:137.f/255.f blue:137.f/255.f alpha:1.f];
    _label.font = [UIFont fontWithName:fontName size:15];
    if ([_photo respondsToSelector:@selector(caption)]) {
        _label.text = [_photo caption] ? [_photo caption] : @" ";
    }
    
    [self addSubview:_label];
}

@end
