//
//  CPLProblemCell.m
//  ProjectEuler
//
//  Created by Caio Lima on 2014-12-26.
//  Copyright (c) 2014 Caio Lima. All rights reserved.
//

#import "CPLProblemCell.h"

#define kActivityIndicatorTag 2453457

@implementation CPLProblemCell

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        [_label setBackgroundColor:[UIColor clearColor]];
        [_label setFont:[UIFont systemFontOfSize:30]];
        [_label setTextColor:[UIColor darkTextColor]];
        [_label setCenter:self.contentView.center];
        [_label setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
        [self.contentView addSubview:_label];
        [self.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.contentView.layer setBorderWidth:1];
        [self.contentView.layer setCornerRadius:5];
    }
    return _label;
}

- (void)setProblemNumber:(NSString *)text
{
    [self.label setText:text];
    [self.label sizeToFit];
    [self.label setCenter:self.contentView.center];
}

- (void)showActivityIndicator
{
    self.label.hidden = YES;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.label.frame];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicatorView setTag:kActivityIndicatorTag];
    [activityIndicatorView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
    [self.contentView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

// Remove activity indicator
- (void)hideActivityIndicator
{
    for (UIView *subView in [self.contentView subviews]) {
        if (subView.tag == kActivityIndicatorTag) {
            [subView removeFromSuperview];
            break;
        }
    }
    self.label.hidden = NO;
}

@end
