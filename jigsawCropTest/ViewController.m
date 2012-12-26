//
//  ViewController.m
//  jigsawCropTest
//
//  Created by Kushal on 20/12/12.
//  Copyright (c) 2012 emx. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>


@interface ViewController ()

@end

@implementation ViewController


//
//- (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count
//{
//    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
//    
//    // First get the image into your data buffer
//    CGImageRef imageRef = [image CGImage];
//    NSUInteger width = CGImageGetWidth(imageRef);
//    NSUInteger height = CGImageGetHeight(imageRef);
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
//    NSUInteger bytesPerPixel = 4;
//    NSUInteger bytesPerRow = bytesPerPixel * width;
//    NSUInteger bitsPerComponent = 8;
//    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
//                                                 bitsPerComponent, bytesPerRow, colorSpace,
//                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//    CGColorSpaceRelease(colorSpace);
//    
//    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
//    CGContextRelease(context);
//    
//    // Now your rawData contains the image data in the RGBA8888 pixel format.
//    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
//    for (int ii = 0 ; ii < count ; ++ii)
//    {
//        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
//        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
//        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
//        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
//        
//        
//        byteIndex += 4;
//        
//        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
//        
//        NSLog(@"%@",acolor);
//        
//        [result addObject:acolor];
//    }
//    CGContextRef ctx = CGBitmapContextCreate(rawData,
//                                CGImageGetWidth( imageRef ),
//                                CGImageGetHeight( imageRef ),
//                                8,
//                                CGImageGetBytesPerRow( imageRef ),
//                                CGImageGetColorSpace( imageRef ),
//                                kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//
//      imageRef = CGBitmapContextCreateImage(ctx);
//       UIImage* rawImage = [UIImage imageWithCGImage:imageRef];
//    
//     previewIV.image = rawImage;
//    
//    free(rawData);
//    
//    return result;
//}

- (IBAction) testImage
{
    CGRect myImageArea = CGRectMake (96, 108, 84, 72);
    
    CGImageRef mySubimage = CGImageCreateWithImageInRect (mainImageIV.image.CGImage, myImageArea);
    
     UIImage *kFilterImg = [UIImage imageWithCGImage:mySubimage];
    
     CGImageRef maskRef = [UIImage imageNamed:@"nMask_180_9.png"].CGImage;
    
     CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                                              CGImageGetHeight(maskRef),
                                                              CGImageGetBitsPerComponent(maskRef),
                                                              CGImageGetBitsPerPixel(maskRef),
                                                              CGImageGetBytesPerRow(maskRef),
                                                              CGImageGetDataProvider(maskRef), NULL, false);
    
     CGImageRef masked = CGImageCreateWithMask(kFilterImg.CGImage, mask);
    
     UIImage *mainImage = [[UIImage alloc] initWithCGImage:masked];
    
     CALayer *layer2 = [CALayer layer] ;
     layer2.contents = (id) mainImage.CGImage;
     layer2.backgroundColor = [UIColor clearColor].CGColor;
    layer2.frame = CGRectMake(0, 0, 82, 74);
   // layer2.bounds = previewIV.bounds;//CGRectMake(0, 0, 82, 74);
    // layer2.position = previewIV.center;
     
     //--------------------------------------------------------
     
    // [[previewIV layer] addSublayer:layer2];
    
    UIGraphicsBeginImageContext(previewIV.layer.bounds.size);
    [layer2 renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *saver = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
 
    previewIV.image = saver;//kFilterImg;//[UIImage imageWithCGImage:mySubimage];
    
    NSLog(@"%f , %f", saver.size.height, saver.size.width);
    
    const UInt8 *pixels = CFDataGetBytePtr(CGDataProviderCopyData(CGImageGetDataProvider(previewIV.image.CGImage)));
    UInt8 blackThreshold = 10; // or some value close to 0
    int bytesPerPixel = 4;
    for(int x = 0; x < previewIV.image.size.width; x++) {
        for(int y = 0; y < previewIV.image.size.height; y++) {
            int pixelStartIndex = (x + (y * previewIV.image.size.width)) * bytesPerPixel;
            UInt8 alphaVal = pixels[pixelStartIndex]; // can probably ignore this value
            UInt8 redVal = pixels[pixelStartIndex + 1];
            UInt8 greenVal = pixels[pixelStartIndex + 2];
            UInt8 blueVal = pixels[pixelStartIndex + 3];
            
            if (y%2 == 0)
            {
                if (alphaVal == 0) 
                    self.value2 = true;
                else
                    self.value2 = false;
            }
            else
            {
                if (alphaVal == 0)
                {
                    self.value1 = true;
                }
                else
                    self.value1 = false;
            }
            
           
            if (self.value1 == true && self.value2 == true)
            {
                NSLog(@"found");
            }
          //  NSLog(@"alpha: %i", alphaVal);
            
            if (alphaVal == 0 && x == y+1)
            {
                NSLog(@"alpha == 0 x: %i  y: %i ", x, y);
            }
            
            if(redVal < blackThreshold && blueVal < blackThreshold && greenVal < blackThreshold) {
                //This pixel is close to black...do something with it
                
           //     NSLog(@"yes");
            }
            else
            {
              //  NSLog(@"no");
            }
        }
    }
    
    //NSArray *obj = [self getRGBAsFromImage:saver atX:0 andY:0 count:saver.size.width * saver.size.height];

}

- (IBAction) pixelDataOfImage
{
    NSLog(@"%@",previewIV.image);
    
    UIImage* image = previewIV.image;//[UIImage imageNamed:@"inviTest.png"]; // An image
    
    NSData* pixelData = (__bridge NSData *) CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    
    unsigned char* pixelBytes = (unsigned char *)[pixelData bytes];
    
    NSLog(@"%i ",[pixelData length] );
    NSLog(@"%@",[pixelData bytes] );
    
    // Take away the red pixel, assuming 32-bit RGBA
    for(int i = 0; i < [pixelData length]; i += 4) {
        pixelBytes[i] = pixelBytes[i]; // red
        pixelBytes[i+1] = pixelBytes[i+1]; // green
        pixelBytes[i+2] = pixelBytes[i+2]; // blue
        pixelBytes[i+3] = pixelBytes[i+3]; // alpha
        
        NSLog(@"r: %i g: %i b: %i a: %i",pixelBytes[i],pixelBytes[i+1],pixelBytes[i+2],pixelBytes[i+3]);
    }
}

- (void) movePuzzlePieceToBG: (PuzzleImageView *) imageView
{
    NSLog(@"moved");
    [self.view insertSubview:imageView aboveSubview:bgIV];
}

- (void) passCallWhenImageViewIsTapped: (PuzzleImageView *) imageView
{
    [self.view bringSubviewToFront:imageView];
}

- (void) preparePuzzleImages
{
    for (PuzzleImageView *obj in self.view.subviews)
    {
      //  NSLog(@"%@",obj);
        if ([obj isKindOfClass:[PuzzleImageView class]])
        {
            [obj removeFromSuperview];
        }
    
    }
    
    for (int i = 1; i <= 9; i ++) {
        
        NSString *maskImageName = [NSString stringWithFormat:@"nMask_180_%i.png",i];
        
        UIImage *maskImage = [UIImage imageNamed:maskImageName];
        
        if (i == 1)
        {
            CGRect myImageArea = CGRectMake (0, 0, maskImage.size.width, maskImage.size.height);
            
            CGImageRef mySubimage = CGImageCreateWithImageInRect (mainImageIV.image.CGImage, myImageArea);
            
            
            CGImageRef maskRef = maskImage.CGImage;
            
            CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                                CGImageGetHeight(maskRef),
                                                CGImageGetBitsPerComponent(maskRef),
                                                CGImageGetBitsPerPixel(maskRef),
                                                CGImageGetBytesPerRow(maskRef),
                                                CGImageGetDataProvider(maskRef), NULL, false);
            
            CGImageRef masked = CGImageCreateWithMask(mySubimage, mask);
            
            puzzleImage1 = [UIImage imageWithCGImage:masked];
            
            puzzleImageV1 = [[PuzzleImageView alloc] initWithFrame:CGRectMake(70, 130, maskImage.size.width, maskImage.size.height)];
            puzzleImageV1.originRect = CGRectMake(68, 128, maskImage.size.width+5, maskImage.size.height+5);
            puzzleImageV1.image = puzzleImage1;
            puzzleImageV1.tag = 1;
            puzzleImageV1.pDelegate = self;
            [self.view addSubview:puzzleImageV1];
        }
        else if (i == 2)
        {
           // NSLog(@"%@",maskImageName);
            
            CGRect myImageArea = CGRectMake (53, 0, maskImage.size.width, maskImage.size.height);
            
            CGImageRef mySubimage = CGImageCreateWithImageInRect (mainImageIV.image.CGImage, myImageArea);
            
            CGImageRef maskRef = maskImage.CGImage;
            
            CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                                CGImageGetHeight(maskRef),
                                                CGImageGetBitsPerComponent(maskRef),
                                                CGImageGetBitsPerPixel(maskRef),
                                                CGImageGetBytesPerRow(maskRef),
                                                CGImageGetDataProvider(maskRef), NULL, false);
            
            CGImageRef masked = CGImageCreateWithMask(mySubimage, mask);
            
            puzzleImage2 = [UIImage imageWithCGImage:masked];
          
            puzzleImageV2 = [[PuzzleImageView alloc] initWithFrame:CGRectMake(123, 130, maskImage.size.width, maskImage.size.height)];
            puzzleImageV2.originRect = CGRectMake(121, 128, maskImage.size.width+5, maskImage.size.height+5);
            puzzleImageV2.image = puzzleImage2;
            puzzleImageV2.tag = 2;
            puzzleImageV2.pDelegate = self;
            [self.view addSubview:puzzleImageV2];
        }
        else if (i == 3)
        {
            CGRect myImageArea = CGRectMake (90, 0, maskImage.size.width, maskImage.size.height);
           // NSLog(@"%@",myImageArea);
            CGImageRef mySubimage = CGImageCreateWithImageInRect (mainImageIV.image.CGImage, myImageArea);
            
            CGImageRef maskRef = maskImage.CGImage;
            
            CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                                CGImageGetHeight(maskRef),
                                                CGImageGetBitsPerComponent(maskRef),
                                                CGImageGetBitsPerPixel(maskRef),
                                                CGImageGetBytesPerRow(maskRef),
                                                CGImageGetDataProvider(maskRef), NULL, false);
            
            CGImageRef masked = CGImageCreateWithMask(mySubimage, mask);
            
            puzzleImage3 = [UIImage imageWithCGImage:masked];
            
            puzzleImageV3 = [[PuzzleImageView alloc] initWithFrame:CGRectMake(160, 130, maskImage.size.width, maskImage.size.height)];
            puzzleImageV3.originRect = CGRectMake(158, 128, maskImage.size.width+5, maskImage.size.height+5);
            puzzleImageV3.image = puzzleImage3;
            puzzleImageV3.tag = 3;
            puzzleImageV3.pDelegate = self;
            [self.view addSubview:puzzleImageV3];
        }
        else if (i == 4)
        {
            CGRect myImageArea = CGRectMake (0, 40, maskImage.size.width, maskImage.size.height);
            
            CGImageRef mySubimage = CGImageCreateWithImageInRect (mainImageIV.image.CGImage, myImageArea);
            
            CGImageRef maskRef = maskImage.CGImage;
            
            CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                                CGImageGetHeight(maskRef),
                                                CGImageGetBitsPerComponent(maskRef),
                                                CGImageGetBitsPerPixel(maskRef),
                                                CGImageGetBytesPerRow(maskRef),
                                                CGImageGetDataProvider(maskRef), NULL, false);
            
            CGImageRef masked = CGImageCreateWithMask(mySubimage, mask);
            
            puzzleImage4 = [UIImage imageWithCGImage:masked];
            
            puzzleImageV4 = [[PuzzleImageView alloc] initWithFrame:CGRectMake (70, 170, maskImage.size.width, maskImage.size.height)];
            puzzleImageV4.originRect = CGRectMake(68, 168, maskImage.size.width+5, maskImage.size.height+5);
            puzzleImageV4.image = puzzleImage4;
            puzzleImageV4.tag = 4;
            puzzleImageV4.pDelegate = self;
            [self.view addSubview:puzzleImageV4];
        }
        else if (i == 5)
        {
            CGRect myImageArea = CGRectMake (37, 52, maskImage.size.width, maskImage.size.height);
            
            CGImageRef mySubimage = CGImageCreateWithImageInRect (mainImageIV.image.CGImage, myImageArea);
            
            CGImageRef maskRef = maskImage.CGImage;
            
            CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                                CGImageGetHeight(maskRef),
                                                CGImageGetBitsPerComponent(maskRef),
                                                CGImageGetBitsPerPixel(maskRef),
                                                CGImageGetBytesPerRow(maskRef),
                                                CGImageGetDataProvider(maskRef), NULL, false);
            
            CGImageRef masked = CGImageCreateWithMask(mySubimage, mask);
            
            puzzleImage5 = [UIImage imageWithCGImage:masked];
            
            puzzleImageV5 = [[PuzzleImageView alloc] initWithFrame:CGRectMake (107, 182, maskImage.size.width, maskImage.size.height)];
            puzzleImageV5.originRect = CGRectMake(105, 180, maskImage.size.width+5, maskImage.size.height+5);
            puzzleImageV5.tag = 5;
            puzzleImageV5.pDelegate = self;
            puzzleImageV5.image = puzzleImage5;
            [self.view addSubview:puzzleImageV5];
        }
        else if (i == 6)
        {
            CGRect myImageArea = CGRectMake (108, 38, maskImage.size.width, maskImage.size.height);
            
            CGImageRef mySubimage = CGImageCreateWithImageInRect (mainImageIV.image.CGImage, myImageArea);
            
            CGImageRef maskRef = maskImage.CGImage;
            
            CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                                CGImageGetHeight(maskRef),
                                                CGImageGetBitsPerComponent(maskRef),
                                                CGImageGetBitsPerPixel(maskRef),
                                                CGImageGetBytesPerRow(maskRef),
                                                CGImageGetDataProvider(maskRef), NULL, false);
            
            CGImageRef masked = CGImageCreateWithMask(mySubimage, mask);
            
            puzzleImage6 = [UIImage imageWithCGImage:masked];
            
            puzzleImageV6 = [[PuzzleImageView alloc] initWithFrame:CGRectMake (180, 170, maskImage.size.width, maskImage.size.height)];
            puzzleImageV6.originRect = CGRectMake(178, 168, maskImage.size.width+5, maskImage.size.height+5);
            puzzleImageV6.tag = 6;
            puzzleImageV6.pDelegate = self;
            puzzleImageV6.image = puzzleImage6;
            [self.view addSubview:puzzleImageV6];
        }
        else if (i == 7)
        {
            CGRect myImageArea = CGRectMake (0, 108, maskImage.size.width, maskImage.size.height);
            
            CGImageRef mySubimage = CGImageCreateWithImageInRect (mainImageIV.image.CGImage, myImageArea);
            
            CGImageRef maskRef = maskImage.CGImage;
            
            CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                                CGImageGetHeight(maskRef),
                                                CGImageGetBitsPerComponent(maskRef),
                                                CGImageGetBitsPerPixel(maskRef),
                                                CGImageGetBytesPerRow(maskRef),
                                                CGImageGetDataProvider(maskRef), NULL, false);
            
            CGImageRef masked = CGImageCreateWithMask(mySubimage, mask);
            
            puzzleImage7 = [UIImage imageWithCGImage:masked];
            
            puzzleImageV7 = [[PuzzleImageView alloc] initWithFrame: CGRectMake (70, 238, maskImage.size.width, maskImage.size.height)];
            puzzleImageV7.originRect = CGRectMake(68, 236, maskImage.size.width+5, maskImage.size.height+5);
            puzzleImageV7.tag = 7;
            puzzleImageV7.pDelegate = self;
            puzzleImageV7.image = puzzleImage7;
            [self.view addSubview:puzzleImageV7];
        }
        else if (i == 8)
        {
            CGRect myImageArea = CGRectMake (50, 92, maskImage.size.width, maskImage.size.height);
            
            CGImageRef mySubimage = CGImageCreateWithImageInRect (mainImageIV.image.CGImage, myImageArea);
            
            CGImageRef maskRef = maskImage.CGImage;
            
            CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                                CGImageGetHeight(maskRef),
                                                CGImageGetBitsPerComponent(maskRef),
                                                CGImageGetBitsPerPixel(maskRef),
                                                CGImageGetBytesPerRow(maskRef),
                                                CGImageGetDataProvider(maskRef), NULL, false);
            
            CGImageRef masked = CGImageCreateWithMask(mySubimage, mask);
            
            puzzleImage8 = [UIImage imageWithCGImage:masked];
            
            puzzleImageV8 = [[PuzzleImageView alloc] initWithFrame: CGRectMake (120, 222, maskImage.size.width, maskImage.size.height)];
            puzzleImageV8.originRect = CGRectMake(118, 220, maskImage.size.width+5, maskImage.size.height+5);
            puzzleImageV8.tag = 8;
            puzzleImageV8.pDelegate = self;
            puzzleImageV8.image = puzzleImage8;
            [self.view addSubview:puzzleImageV8];
        }
        else if (i == 9)
        {
            CGRect myImageArea = CGRectMake (96, 108, maskImage.size.width, maskImage.size.height);
            
            CGImageRef mySubimage = CGImageCreateWithImageInRect (mainImageIV.image.CGImage, myImageArea);
            
            CGImageRef maskRef = maskImage.CGImage;
            
            CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                                CGImageGetHeight(maskRef),
                                                CGImageGetBitsPerComponent(maskRef),
                                                CGImageGetBitsPerPixel(maskRef),
                                                CGImageGetBytesPerRow(maskRef),
                                                CGImageGetDataProvider(maskRef), NULL, false);
            
            CGImageRef masked = CGImageCreateWithMask(mySubimage, mask);
            
            puzzleImage9 = [UIImage imageWithCGImage:masked];
            
            puzzleImageV9 = [[PuzzleImageView alloc] initWithFrame: CGRectMake (166, 238, maskImage.size.width, maskImage.size.height)];
            puzzleImageV9.originRect = CGRectMake(164, 236, maskImage.size.width+5, maskImage.size.height+5);
            puzzleImageV9.tag = 9;
            puzzleImageV9.pDelegate = self;
            puzzleImageV9.image = puzzleImage9;
            [self.view addSubview:puzzleImageV9];
        }
        
        
    }
    
    mainImageIV.hidden = YES;
    
    previewIV.image = puzzleImage9;

    puzzleObj = [[PuzzleImageView alloc] init];
   
    [puzzleObj shakeImage:puzzleImageV1 value:YES];
    [puzzleObj shakeImage:puzzleImageV2 value:YES];
    [puzzleObj shakeImage:puzzleImageV3 value:YES];
    [puzzleObj shakeImage:puzzleImageV4 value:YES];
    [puzzleObj shakeImage:puzzleImageV5 value:YES];
    [puzzleObj shakeImage:puzzleImageV6 value:YES];
    [puzzleObj shakeImage:puzzleImageV7 value:YES];
    [puzzleObj shakeImage:puzzleImageV8 value:YES];
    [puzzleObj shakeImage:puzzleImageV9 value:YES];
    
    [self performSelector:@selector(randomMovement:) withObject:puzzleImageV1 afterDelay:2.0f];
    [self performSelector:@selector(randomMovement:) withObject:puzzleImageV2 afterDelay:2.0f];
    [self performSelector:@selector(randomMovement:) withObject:puzzleImageV3 afterDelay:2.0f];
    [self performSelector:@selector(randomMovement:) withObject:puzzleImageV4 afterDelay:2.0f];
    [self performSelector:@selector(randomMovement:) withObject:puzzleImageV5 afterDelay:2.0f];
    [self performSelector:@selector(randomMovement:) withObject:puzzleImageV6 afterDelay:2.0f];
    [self performSelector:@selector(randomMovement:) withObject:puzzleImageV7 afterDelay:2.0f];
    [self performSelector:@selector(randomMovement:) withObject:puzzleImageV8 afterDelay:2.0f];
    [self performSelector:@selector(randomMovement:) withObject:puzzleImageV9 afterDelay:2.0f];
    
}

- (void) randomMovement: (PuzzleImageView *) movementImageV
{
    CGPoint point1 = CGPointMake(arc4random() % 260 , arc4random() % 380);
    
    [UIView animateWithDuration:2.0f animations:^{
        movementImageV.frame = CGRectMake(point1.x, point1.y, movementImageV.frame.size.width, movementImageV.frame.size.height);
    } completion:^(BOOL finished) {
        
        if (CGRectIntersectsRect(CGRectMake(70, 130, 180, 180), movementImageV.frame)) {
            [self randomMovement:movementImageV];
        }
        else
        {
            [puzzleObj shakeImage:movementImageV value:NO];
        }
        
        [puzzleObj shakeImage:puzzleImageV1 value:NO];
        
        
    }];

}
/*
- (void) randomMovement
{
    CGPoint point1 = CGPointMake(arc4random() % 260 , arc4random() % 380);
    CGPoint point2 = CGPointMake(arc4random() % 260 , arc4random() % 380);
    CGPoint point3 = CGPointMake(arc4random() % 260 , arc4random() % 380);
    CGPoint point4 = CGPointMake(arc4random() % 260 , arc4random() % 380);
    CGPoint point5 = CGPointMake(arc4random() % 260 , arc4random() % 380);
    CGPoint point6 = CGPointMake(arc4random() % 260 , arc4random() % 380);
    CGPoint point7 = CGPointMake(arc4random() % 260 , arc4random() % 380);
    CGPoint point8 = CGPointMake(arc4random() % 260 , arc4random() % 380);
    CGPoint point9 = CGPointMake(arc4random() % 260 , arc4random() % 380);
    
    [UIView animateWithDuration:2.0f animations:^{
        puzzleImageV1.frame = CGRectMake(point1.x, point1.y, puzzleImageV1.frame.size.width, puzzleImageV1.frame.size.height);
        puzzleImageV2.frame = CGRectMake(point2.x, point2.y, puzzleImageV2.frame.size.width, puzzleImageV2.frame.size.height);
        puzzleImageV3.frame = CGRectMake(point3.x, point3.y, puzzleImageV3.frame.size.width, puzzleImageV3.frame.size.height);
        puzzleImageV4.frame = CGRectMake(point4.x, point4.y, puzzleImageV4.frame.size.width, puzzleImageV4.frame.size.height);
        puzzleImageV5.frame = CGRectMake(point5.x, point5.y, puzzleImageV5.frame.size.width, puzzleImageV5.frame.size.height);
        puzzleImageV6.frame = CGRectMake(point6.x, point6.y, puzzleImageV6.frame.size.width, puzzleImageV6.frame.size.height);
        puzzleImageV7.frame = CGRectMake(point7.x, point7.y, puzzleImageV7.frame.size.width, puzzleImageV7.frame.size.height);
        puzzleImageV8.frame = CGRectMake(point8.x, point8.y, puzzleImageV8.frame.size.width, puzzleImageV8.frame.size.height);
        puzzleImageV9.frame = CGRectMake(point9.x, point9.y, puzzleImageV9.frame.size.width, puzzleImageV9.frame.size.height);
    } completion:^(BOOL finished) {
        [puzzleObj shakeImage:puzzleImageV1 value:NO];
        [puzzleObj shakeImage:puzzleImageV2 value:NO];
        [puzzleObj shakeImage:puzzleImageV3 value:NO];
        [puzzleObj shakeImage:puzzleImageV4 value:NO];
        [puzzleObj shakeImage:puzzleImageV5 value:NO];
        [puzzleObj shakeImage:puzzleImageV6 value:NO];
        [puzzleObj shakeImage:puzzleImageV7 value:NO];
        [puzzleObj shakeImage:puzzleImageV8 value:NO];
        [puzzleObj shakeImage:puzzleImageV9 value:NO];
        
        [self.view bringSubviewToFront:testBtn];
    }];
}
*/

- (IBAction) maskingTestAction
{
    [self preparePuzzleImages];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
