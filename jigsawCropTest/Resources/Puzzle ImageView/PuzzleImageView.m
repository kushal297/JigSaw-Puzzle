//
//  PuzzleImageView.m
//  jigsawCropTest
//
//  Created by Kushal on 20/12/12.
//  Copyright (c) 2012 emx. All rights reserved.
//

#import "PuzzleImageView.h"

@implementation PuzzleImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;

    }
    return self;
}

- (void) shakeImage:(UIImageView *) imageView value: (BOOL) on
{
    if(on==NO)
    {
          [imageView.layer removeAnimationForKey:@"shakeAnimation"];
    }
    else
    {
         CGFloat rotation = 0.05;
        
        CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
         shake.duration = 0.13;
         shake.autoreverses = YES;
         shake.repeatCount = 1000;
         shake.removedOnCompletion = NO;
         shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
         shake.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
         
         [imageView.layer addAnimation:shake forKey:@"shakeAnimation"];
    }
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  //  NSLog(@"touches began : %i",self.tag);
    
    if ([self.pDelegate respondsToSelector:@selector(passCallWhenImageViewIsTapped:)])
    {
        [self.pDelegate passCallWhenImageViewIsTapped:self];
    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
   // NSLog(@"touches cancelled");
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  //  NSLog(@"touches ended");
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   // NSLog(@"touches moved");
  //  NSLog(@"x: %f , y: %f",self.frame.origin.x,self.frame.origin.y);
    if ([touches count]==1) {
        
        UITouch *touch = [touches anyObject];
        CGPoint p0 = [touch previousLocationInView:self];
        CGPoint p1 = [touch locationInView:self];
        
        if (self.tag == 1)
        {
            if(CGRectContainsRect(self.originRect, self.frame))
            {
                self.frame = CGRectMake(70, 130, self.frame.size.width, self.frame.size.height);
                
                if ([self.pDelegate respondsToSelector:@selector(movePuzzlePieceToBG:)])
                {
                    [self.pDelegate movePuzzlePieceToBG:self];
                }
                
                return;
            }
            
            
        }
        else if (self.tag == 2)
        {
            if(CGRectContainsRect(self.originRect, self.frame))
            {
                self.frame = CGRectMake(123, 130, self.frame.size.width, self.frame.size.height);
                
                if ([self.pDelegate respondsToSelector:@selector(movePuzzlePieceToBG:)])
                {
                    [self.pDelegate movePuzzlePieceToBG:self];
                }
                
                return;
            }
        }
        else if (self.tag == 3)
        {
            if(CGRectContainsRect(self.originRect, self.frame))
            {
                self.frame = CGRectMake(160, 130, self.frame.size.width, self.frame.size.height);
                
                if ([self.pDelegate respondsToSelector:@selector(movePuzzlePieceToBG:)])
                {
                    [self.pDelegate movePuzzlePieceToBG:self];
                }
                
                return;
            }
        }
        else if (self.tag == 4)
        {
            if(CGRectContainsRect(self.originRect, self.frame))
            {
                self.frame = CGRectMake(70, 170, self.frame.size.width, self.frame.size.height);
                
                if ([self.pDelegate respondsToSelector:@selector(movePuzzlePieceToBG:)])
                {
                    [self.pDelegate movePuzzlePieceToBG:self];
                }
                
                return;
            }
        }
        else if (self.tag == 5)
        {
            if(CGRectContainsRect(self.originRect, self.frame))
            {
                self.frame = CGRectMake(107, 182, self.frame.size.width, self.frame.size.height);
                
                if ([self.pDelegate respondsToSelector:@selector(movePuzzlePieceToBG:)])
                {
                    [self.pDelegate movePuzzlePieceToBG:self];
                }
                
                return;
            }
        }
        else if (self.tag == 6)
        {
            if(CGRectContainsRect(self.originRect, self.frame))
            {
                self.frame = CGRectMake(180, 170, self.frame.size.width, self.frame.size.height);
                
                if ([self.pDelegate respondsToSelector:@selector(movePuzzlePieceToBG:)])
                {
                    [self.pDelegate movePuzzlePieceToBG:self];
                }
                
                return;
            }
        }
        else if (self.tag == 7)
        {
            if(CGRectContainsRect(self.originRect, self.frame))
            {
                self.frame = CGRectMake(70, 238, self.frame.size.width, self.frame.size.height);
                
                if ([self.pDelegate respondsToSelector:@selector(movePuzzlePieceToBG:)])
                {
                    [self.pDelegate movePuzzlePieceToBG:self];
                }
                
                return;
            }
        }
        else if (self.tag == 8)
        {
            if(CGRectContainsRect(self.originRect, self.frame))
            {
                self.frame = CGRectMake(120, 222, self.frame.size.width, self.frame.size.height);
                
                if ([self.pDelegate respondsToSelector:@selector(movePuzzlePieceToBG:)])
                {
                    [self.pDelegate movePuzzlePieceToBG:self];
                }
                
                return;
            }
        }
        else if (self.tag == 9)
        {
            if(CGRectContainsRect(self.originRect, self.frame))
            {
                self.frame = CGRectMake(166, 238, self.frame.size.width, self.frame.size.height);
                
                if ([self.pDelegate respondsToSelector:@selector(movePuzzlePieceToBG:)])
                {
                    [self.pDelegate movePuzzlePieceToBG:self];
                }
                return;
            }
        }
        
        
        CGPoint center = self.center;
        center.x += p1.x - p0.x;
        center.y += p1.y - p0.y;
        self.center = center;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
