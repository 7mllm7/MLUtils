//
//  ActivityIndicatorView.m
//
//  Created by ML on 10/6/14.
//  Copyright (c) 2014 YawningMonkey. All rights reserved.
//

#import "ActivityIndicatorView.h"


static NSTimeInterval const kFadeAnimationDuration = 0.3;

@interface ActivityIndicatorView ()

/**
 *  Internal activity indicator view.
 */
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

/**
 *  Title label.
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  Subtitle label.
 */
@property (nonatomic, strong) UILabel *subtitleLabel;

@end

@implementation ActivityIndicatorView

-(id)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    }
    return self;
}

-(void)startInView:(UIView *)superView title:(NSString *)title
{
    [self startInView:superView title:title subtitle:nil];
}

-(void)startInView:(UIView *)superView title:(NSString *)title subtitle:(NSString *)subtitle
{
    [self setFrame:superView.window.bounds];
    
    // setup indicator
    if (_activityIndicatorView == nil)
    {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.hidesWhenStopped = NO;
        [self addSubview:_activityIndicatorView];
    }
    [_activityIndicatorView setFrame:self.frame];
    
    // setup title (required)
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
        [self addSubview:_titleLabel];
    }
    [_titleLabel setText:title];
    [_titleLabel sizeToFit];
    [_titleLabel setFrame:CGRectMake(self.frame.size.width / 2 - _titleLabel.frame.size.width / 2, self.bounds.size.height * 0.4, _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
    
    // setup subtitle (optional)
    if (subtitle)
    {
        [self setSubtitle:subtitle];
    }
    
    // we want to dispatch async, in case this method was called from a sensitive UI stage.
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setAlpha:0.0];
        [superView.window addSubview:self];
        [_activityIndicatorView startAnimating];
        
        [UIView transitionWithView:self
                          duration:kFadeAnimationDuration
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [self setAlpha:1.0];
                        } completion:nil];
    });
    
}


-(void)setSubtitle:(NSString *)subtitle
{
    if (_subtitleLabel == nil)
    {
        _subtitleLabel = [[UILabel alloc] init];
        [_subtitleLabel setTextColor:_titleLabel.textColor];
        [_subtitleLabel setFont:_titleLabel.font];
        [self addSubview:_subtitleLabel];
    }

    [_subtitleLabel setText:subtitle];
    [_subtitleLabel sizeToFit];
    [_subtitleLabel setFrame:CGRectMake(self.frame.size.width / 2 - _subtitleLabel.frame.size.width / 2, self.bounds.size.height * 0.55, _subtitleLabel.frame.size.width, _subtitleLabel.frame.size.height)];
}

-(void)stopAndRemove
{
    // dispatch async in case this method was called from a sensitive UI stage
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self
                          duration:kFadeAnimationDuration
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [self setAlpha:0.0];
                        } completion:^(BOOL finished) {
                            [_activityIndicatorView stopAnimating];
                            [self removeFromSuperview];
                        }];

    });
    
}



@end
