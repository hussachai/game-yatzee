//
//  Yahtzee.m
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/15/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import "Yahtzee.h"
#import "Dice.h"
#import "Score.h"
@interface Yahtzee()

@property (nonatomic) int chances;
@property (nonatomic) int turn;
@property (nonatomic) Score *score;

@end

@implementation Yahtzee

const int MAX_CHANCES = 3;
const int TOTAL_DICES = 5;

- (id) init {
    
    self = [super init];
    
    self.dices = [NSArray arrayWithObjects:
                 [[[Dice alloc] init] initFace:1],
                 [[[Dice alloc] init] initFace:2],
                 [[[Dice alloc] init] initFace:3],
                 [[[Dice alloc] init] initFace:4],
                 [[[Dice alloc] init] initFace:5], nil];
    self.scores = [NSArray arrayWithObjects:
                   [[Score alloc] init],
                   [[Score alloc] init], nil];
    
    self.score = [[Score alloc] init];
    
    [self clear];
    
    return self;
}

- (int) chances {
    return _chances;
}

- (int) getTurn {
    return self.turn;
}

- (Score*) getPlayerScore {
    return [self.scores objectAtIndex:self.turn];
}

- (Dice*) getDice: (int) number {
    if(number < 1 || number > 5) number = 1;
    return [self.dices objectAtIndex: number-1 ];
}

- (void) saveScore:(ScoreType) type {
    
    Score* playerScore = [self.scores objectAtIndex: self.turn];
    [playerScore setScore:type value:
     [self.score getScore:type]];
    [playerScore mark:type];
    int uppers = playerScore.ones + playerScore.twoes + playerScore.threes +
        playerScore.fours + playerScore.fives + playerScore.sixes;
    if(uppers >= 63){
        playerScore.bonus = 35;
    }
    if(self.bot){
        //next player
        self.turn++;
        if(self.turn > ([self.scores count]-1) ){
            self.turn = 0;
        }
    }
    
    self.chances = MAX_CHANCES;
}


- (Score*) rollDices {
    
    if(self.chances == 0){
        return self.score;
    }
    
    self.chances--;
    
    for(Dice* dice in self.dices){
        [dice roll];
    }
    
    Score *score = self.score;
    [score clear];
    
    int n1 = 0;
    int n2 = 0;
    int n3 = 0;
    int n4 = 0;
    int n5 = 0;
    int n6 = 0;
    //calculate the upper scores and chance
    for(Dice* dice in self.dices){
        if(dice.face == 1){
            score.ones += 1;
            n1++;
        }else if(dice.face == 2){
            score.twoes += 2;
            n2++;
        }else if(dice.face == 3){
            score.threes += 3;
            n3++;
        }else if(dice.face == 4){
            score.fours += 4;
            n4++;
        }else if(dice.face == 5){
            score.fives += 5;
            n5++;
        }else if(dice.face == 6){
            score.sixes += 6;
            n6++;
        }
        score.chance += dice.face;
    }
    
    //calculate the lower scores
    //Three-Of-A-Kind
    if(n1 >= 3 || n2 >= 3 || n3 >= 3 ||
       n4 >= 3 || n5 >= 3 || n6 >= 3){
        score.threeOfAKind = score.chance;
    }
    
    //Four-Of-A-Kind
    if(n1 >= 4 || n2 >= 4 || n3 >= 4 ||
       n4 >= 4 || n5 >= 4 || n6 >= 4){
        score.fourOfAKind = score.chance;
    }
    
    //Full House
    BOOL fullHouse = (n1 == 3) &&
    (n2== 2 || n3 == 2 || n4 == 2 || n5 == 2 || n6 == 2);
    if(!fullHouse){
        fullHouse = (n2 == 3) &&
        (n1== 2 || n3 == 2 || n4 == 2 || n5 == 2 || n6 == 2);
    }
    if(!fullHouse){
        fullHouse = (n3 == 3) &&
        (n1== 2 || n2 == 2 || n4 == 2 || n5 == 2 || n6 == 2);
    }
    if(!fullHouse){
        fullHouse = (n4 == 3) &&
        (n1== 2 || n2 == 2 || n3 == 2 || n5 == 2 || n6 == 2);
    }
    if(!fullHouse){
        fullHouse = (n5 == 3) &&
        (n1== 2 || n2 == 2 || n3 == 2 || n4 == 2 || n6 == 2);
    }
    if(!fullHouse){
        fullHouse = (n6 == 3) &&
        (n1== 2 || n2 == 2 || n3 == 2 || n4 == 2 || n5 == 2);
    }
    if(fullHouse){
        score.fullHouse = 25;
    }
    
    //Small Straight
    BOOL smallStraight = (n1 == 1 && n2 == 1 && n3 == 1 && n4 == 1);
    if(!smallStraight){
        smallStraight = (n2 == 1 && n3 == 1 && n4 == 1 && n5 == 1);
    }
    if(!smallStraight){
        smallStraight = (n3 == 1 && n4 == 1 && n5 == 1 && n6 == 1);
    }
    if(smallStraight){
        score.smallStraight = 30;
    }
    
    //Large Straight
    BOOL largeStraight = (n1 == 1 && n2 == 1 && n3 == 1
                          && n4 == 1 && n5 == 1);
    if(!largeStraight){
        largeStraight = (n2 == 1 && n3 == 1 && n4 == 1
                         && n5 == 1 && n6 == 1);
    }
    if(largeStraight){
        score.largeStraight = 40;
    }
    
    if(n1 == 5 || n2 == 5 || n3 == 5 ||
       n4 == 5 || n5 == 5 || n6 == 5){
        score.yahtzee = 50;
    }
    
    return score;
}

- (void) clear {
    self.bot = NO;
    self.chances = MAX_CHANCES;
    for(Dice* dice in self.dices){
        [dice clear];
    }
    for(Score* score in self.scores){
        [score clear];
    }
    
    
    self.turn = 0;
    self.score = [[Score alloc] init];
}

@end













