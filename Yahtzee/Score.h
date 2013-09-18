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

extern const int SCORE_TYPES;
extern const int BONUS_SCORE;

typedef enum {
    S_One = 0, S_Two, S_Three, S_Four, S_Five, S_Six,
    S_ThreeOfAKind, S_FourOfAKind, S_FullHouse,
    S_SmallStraight, S_LargeStraight, S_Yahtzee,
    S_Chance
}ScoreType;

- (void) mark: (ScoreType) type;

- (BOOL) isMarked: (ScoreType) type;

- (void) setScore: (ScoreType) type value: (int) value;

- (int) getScore: (ScoreType) type;

- (int) getUpperTotal;

- (int) getLowerTotal;

- (int) getTotal;

- (BOOL) isDone;

- (void) clear;

@end
