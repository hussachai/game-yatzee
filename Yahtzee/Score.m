//
//  Score.m
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/16/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import "Score.h"

@interface Score()

@property (nonatomic) NSMutableArray *markedScores;

@end

@implementation Score

const int SCORE_TYPES = 13;

- (id) init {
    self = [super init];
    
    self.markedScores = [[NSMutableArray alloc] init];
    for(int i=0; i<SCORE_TYPES; i++){
        [self.markedScores addObject: [NSNumber numberWithInt: 0]];
    }
    
    [self clear];
    
    return self;
}

- (void) mark:(ScoreType)type {
    [self.markedScores replaceObjectAtIndex:type
        withObject:[NSNumber numberWithInt:1]];
}

- (BOOL) isMarked:(ScoreType) type {
    NSNumber *value = [self.markedScores objectAtIndex:type];
    if(value.intValue == 0) return false;
    return true;
}

- (void) setScore: (ScoreType) type value: (int) value{
    if(type == S_One) self.ones = value;
    else if(type == S_Two) self.twoes = value;
    else if(type == S_Three) self.threes = value;
    else if(type == S_Four) self.fours = value;
    else if(type == S_Five) self.fives = value;
    else if(type == S_Six) self.sixes = value;
    else if(type == S_ThreeOfAKind) self.threeOfAKind = value;
    else if(type == S_FourOfAKind) self.fourOfAKind = value;
    else if(type == S_FullHouse) self.fullHouse = value;
    else if(type == S_SmallStraight) self.smallStraight = value;
    else if(type == S_LargeStraight) self.largeStraight = value;
    else if(type == S_Yahtzee) self.yahtzee = value;
    else if(type == S_Chance) self.chance = value;
}

- (int) getScore: (ScoreType) type {
    if(type == S_One) return self.ones;
    else if(type == S_Two) return self.twoes;
    else if(type == S_Three) return self.threes;
    else if(type == S_Four) return self.fours;
    else if(type == S_Five) return self.fives;
    else if(type == S_Six) return self.sixes;
    else if(type == S_ThreeOfAKind) return self.threeOfAKind;
    else if(type == S_FourOfAKind) return self.fourOfAKind;
    else if(type == S_FullHouse) return self.fullHouse;
    else if(type == S_SmallStraight) return self.smallStraight;
    else if(type == S_LargeStraight) return self.largeStraight;
    else if(type == S_Yahtzee) return self.yahtzee;
    else if(type == S_Chance) return self.chance;
    return 0;
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

- (BOOL) isDone {
    BOOL done = YES;
    for(int i=0; i < SCORE_TYPES; i++){
        NSNumber *value = [self.markedScores objectAtIndex:i];
        if(value.intValue == 0){
            done = NO;
            break;
        }
    }
    return done;
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
    
    for(int i=0; i<SCORE_TYPES; i++){
        [self.markedScores replaceObjectAtIndex:i withObject: [NSNumber numberWithInt: 0]];
    }
}

@end
