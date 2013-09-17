//
//  Yahtzee.h
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/15/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"
#import "Score.h"

@interface Yahtzee : NSObject

//The maximum number of chances to roll dices per round
extern const int MAX_CHANCES;

typedef enum {
    S_One, S_Two, S_Three, S_Four, S_Five, S_Six,
    S_ThreeOfAKind, S_FourOfAKind, S_FullHouse,
    S_SmallStraight, S_LargeStraight, S_Yahtzee,
    S_Chance
}ScoreType;



//We can change bot from BOOL to Int the number of bots
//but we don't have enough space in the screen :(
@property (nonatomic) BOOL bot;
@property (nonatomic) NSArray *dices;
//The 0 index score is human
@property (nonatomic) NSArray *scores;

- (int) chances;

- (int) getTurn;

- (Score*) getPlayerScore;

- (Dice*) getDice: (int) number;

- (void) saveScore:(ScoreType) type;

- (Score*) rollDices;

@end
