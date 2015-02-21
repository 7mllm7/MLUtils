//
//  AsyncLoadImageView.h
//
//  Created by ML on 24/12/14.
//  Copyright (c) 2014 YawningMonkey. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  Callback block to be called upon image async load result.
 *
 *  @param image UIImage that was loaded or nil.
 *  @param error NSError that occured or nil.
 */
typedef void (^AsyncLoadImageViewImageResultBlock)(UIImage *image, NSError *error);

/**
 *  Loads an image from given url and displays it with a fade.
 *  The loading is cancelled in case of dealloc.
 */
@interface AsyncLoadImageView : UIImageView


/**
 *  Loads given url, shows the loaded image with fade and calls a completion block if given.
 *
 *  @param url             NSURL for image to load.
 *  @param completionBlock Result block to be called when the image was presented or nil.
 */
-(void)loadURLInBackground:(NSURL *)url completion:(AsyncLoadImageViewImageResultBlock)completionBlock;

@end
