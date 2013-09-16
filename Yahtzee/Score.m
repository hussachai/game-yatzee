//
//  Score.m
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/16/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import "Score.h"

@implementation Score

- (id) init {
    self = [super init];
    [self clear];
    return self;
}

- (int) getUpperTotal {
    return self.ones + self.twoes + self.threes
    + self.fours + self.fives + self.sixes
    + self.bonus;
}

- (int) getLowerTotal {
    return self.threeOfAKind + self.fourOfAKind
    + self.fullHouse + self.smallStraight
    + self.largeStraight + self.yahtzee
    + self.chance;
}

- (int) getTotal {
    return [self getUpperTotal] + [self getLowerTotal];
}

- (void) clear {
    self.ones = 0;
    self.twoes = 0;
    self.threes = 0;
    self.fours = 0;
    self.fives = 0;
    self.sixes = 0;
    self.bonus = 0;
    self.threeOfAKind = 0;
    self.fourOfAKind = 0;
    self.fullHouse = 0;
    self.smallStraight = 0;
    self.largeStraight = 0;
    self.yahtzee = 0;
    self.chance = 0;
}

@end
