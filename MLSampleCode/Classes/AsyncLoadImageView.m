//
//  AsyncLoadImageView.m
//
//  Created by ML on 24/12/14.
//  Copyright (c) 2014 YawningMonkey. All rights reserved.
//

#import "AsyncLoadImageView.h"

@interface AsyncLoadImageView ()

/**
 *  Used to load the given url.
 */
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation AsyncLoadImageView


-(void)loadURLInBackground:(NSURL *)url completion:(AsyncLoadImageViewImageResultBlock)completionBlock
{
    // use default current session
    NSURLSession *u = [NSURLSession sharedSession];
    
    // ref weakly to self to avoid loop retain inside block
    __weak AsyncLoadImageView *weakSelf = self;
    
    // cancel existing loading if exists
    if (_dataTask)
    {
        [self cancelLoadInBackground];
    }
    
    // init a new data task and start loading
    _dataTask = [u dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data)
        {
            [weakSelf loadImageData:data completion:completionBlock];
            
            // let go of the data task
            weakSelf.dataTask = nil;
        }
        else
        {
            if (completionBlock)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(nil, error);                    
                });
            }
        }
    }];
    
    // resume actually starts the loading
    [_dataTask resume];
}


/**
 *  Called when image data (NSData) is ready to be presented.
 *
 *  @param data            NSData of image.
 *  @param completionBlock Block to call when image is presented.
 */
-(void)loadImageData:(NSData *)data completion:(AsyncLoadImageViewImageResultBlock)completionBlock
{
    __weak AsyncLoadImageView *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) , ^{
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView transitionWithView:weakSelf
                              duration:1.0f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                [weakSelf setImage:image];
                            } completion:nil];
        });
        
        if (completionBlock)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(image, nil);
            });
        }
    });
}

/**
 *  Cancel current loading.
 */
-(void)cancelLoadInBackground
{
    if (_dataTask)
    {
        [_dataTask cancel];
        _dataTask = nil;
    }
}


-(void)dealloc
{
    [self cancelLoadInBackground];
}



@end
