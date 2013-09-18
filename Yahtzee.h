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
extern const int TOTAL_DICES;

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

- (void) clear;

@end
