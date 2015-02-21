//
//  ViewController.m
//  MLSampleCode
//
//  Created by ML on 20/2/15.
//  Copyright (c) 2015 YawningMonkey. All rights reserved.
//

#import "ViewController.h"
#import "ActivityIndicatorView.h"
#import "AlertViewController.h"
#import "AsyncLoadImageView.h"
#import "VideoController.h"


@interface ViewController ()

@property (nonatomic, strong) VideoController *videoController;
@property (nonatomic, strong) ActivityIndicatorView *activityIndicatorView;
@property (nonatomic, assign) NSUInteger activityPercents;
@property (nonatomic, strong) AlertViewController *alertViewController;
@property (nonatomic, strong) AsyncLoadImageView *asyncLoadImageView;

@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // init alert vc here as it's useful or the whole app
    self.alertViewController = [AlertViewController new];
    self.activityIndicatorView = [ActivityIndicatorView new];
}

-(IBAction)activityIndicatorButtonDidPress:(id)sender
{
    [self.activityIndicatorView startInView:self.view title:@"Example!" subtitle:@"Subtitle..."];
    
    self.activityPercents = 0;
    [self updateSubtitle];
}

-(void)updateSubtitle
{
    if (++self.activityPercents <= 100)
    {
        [self.activityIndicatorView setSubtitle:[NSString stringWithFormat:@"%d%%", self.activityPercents]];
        __weak ViewController *weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf updateSubtitle];
        });
    }
    else
    {
        [self.activityIndicatorView stopAndRemove];
    }
}

-(IBAction)alertViewControllerButtonDidPress:(id)sender
{
    __weak ViewController *weakSelf = self;
    [self.alertViewController showOKAlertWithTitle:@"Example!" message:@"This is a lovely example" result:^(NSInteger buttonIndex) {
        [weakSelf.alertViewController showOKAlertWithTitle:@"Another example!" message:@"Last one, I promise..." result:nil];
    }];
}

-(IBAction)asyncLoadImageViewButtonDidPress:(id)sender
{
    __weak ViewController *weakSelf = self;
    [self.alertViewController showOKAlertWithTitle:@"So..." message:@"We'll load some image from the web, present it and remove it after 5 seconds" result:^(NSInteger buttonIndex) {
        [weakSelf loadImage];
    }];
}

-(void)loadImage
{
    
    self.asyncLoadImageView = [[AsyncLoadImageView alloc] initWithFrame:self.view.frame];
    [self.asyncLoadImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.activityIndicatorView startInView:self.view title:@"Loading image..."];
    __weak ViewController *weakSelf = self;
    [self.asyncLoadImageView loadURLInBackground:[NSURL URLWithString:@"http://img.wallpaperstock.net:81/amazing-sunset-wallpapers_24806_1920x1200.jpg"] completion:^(UIImage *image, NSError *error) {
        [weakSelf.activityIndicatorView stopAndRemove];
        if (!error)
        {
            [weakSelf.view addSubview:weakSelf.asyncLoadImageView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.asyncLoadImageView removeFromSuperview];
                weakSelf.asyncLoadImageView = nil;
            });
        }
        else
        {
            [weakSelf.alertViewController showOKAlertWithTitle:@"Oops.." message:@"Image not found" result:nil];
        }
    }];
}

-(IBAction)videoControllerButtonDidPress:(id)sender
{
    __weak ViewController *weakSelf = self;
    [self.alertViewController showOKAlertWithTitle:@"So..." message:@"We'll play repeatedly and then stop automatically after 15 seconds" result:^(NSInteger buttonIndex) {
        [weakSelf startVideo];
    }];
}

-(void)startVideo
{
    self.videoController = [[VideoController alloc] initWithVideoUrl:[[NSBundle mainBundle] URLForResource:@"vid" withExtension:@"mp4"]];
    
    [self.videoController playInView:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.videoController stopAndRemove];
        self.videoController = nil;
    });
}

@end
