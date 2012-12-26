//
//  ViewController.h
//  jigsawCropTest
//
//  Created by Kushal on 20/12/12.
//  Copyright (c) 2012 emx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PuzzleImageView.h"

@interface ViewController : UIViewController <puzzleImageViewDelegate>

{
    IBOutlet UIImageView *mainImageIV, *previewIV, *bgIV;
    
    UIImage *puzzleImage1 , *puzzleImage2 , *puzzleImage3 , *puzzleImage4 , *puzzleImage5 , *puzzleImage6 , *puzzleImage7 , *puzzleImage8 , *puzzleImage9;
    
    PuzzleImageView *puzzleImageV1 , *puzzleImageV2 , *puzzleImageV3 , *puzzleImageV4 , *puzzleImageV5 , *puzzleImageV6 , *puzzleImageV7 , *puzzleImageV8 , *puzzleImageV9;
    
    PuzzleImageView *puzzleObj;
    
    IBOutlet UIButton *testBtn;
    

}
@property (nonatomic, weak) id <puzzleImageViewDelegate> puzzleDelegate;
@property BOOL value1, value2;

- (IBAction) maskingTestAction;

@end
