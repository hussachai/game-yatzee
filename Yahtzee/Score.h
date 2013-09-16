//
//  Score.h
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/16/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

@property (nonatomic) int ones;
@property (nonatomic) int twoes;
@property (nonatomic) int threes;
@property (nonatomic) int fours;
@property (nonatomic) int fives;
@property (nonatomic) int sixes;
@property (nonatomic) int bonus;

@property (nonatomic) int threeOfAKind;
@property (nonatomic) int fourOfAKind;
@property (nonatomic) int fullHouse;
@property (nonatomic) int smallStraight;
@property (nonatomic) int largeStraight;
@property (nonatomic) int yahtzee;
@property (nonatomic) int chance;

- (int) getUpperTotal;

- (int) getLowerTotal;

- (int) getTotal;

- (void) clear;

@end
