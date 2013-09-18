//
//  Dice.h
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/15/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dice : NSObject

@property (nonatomic) BOOL fixed;

@property (nonatomic) int face;

- (void) roll;

- (Dice*) initFace: (int) face;

- (void) clear;

@end
