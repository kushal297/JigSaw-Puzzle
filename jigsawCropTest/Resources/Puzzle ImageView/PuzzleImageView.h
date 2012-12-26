//
//  PuzzleImageView.h
//  jigsawCropTest
//
//  Created by Kushal on 20/12/12.
//  Copyright (c) 2012 emx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class PuzzleImageView;

@protocol puzzleImageViewDelegate <NSObject>

@required

- (void) passCallWhenImageViewIsTapped: (PuzzleImageView *) imageView;

- (void) movePuzzlePieceToBG: (PuzzleImageView *) imageView;

@end

@interface PuzzleImageView : UIImageView

- (void) shakeImage:(UIImageView *) imageView value: (BOOL) on;

@property (nonatomic, retain) id <puzzleImageViewDelegate> pDelegate;

@property (nonatomic , assign) CGRect originRect;

@end
