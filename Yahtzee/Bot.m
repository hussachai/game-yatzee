//
//  Bot.m
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/18/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import "Bot.h"

/**
 * The (very) stupid default Bot.
 */
@implementation Bot

- (ScoreType) pick: (Score*) score{
    if(self.yahtzee==Nil) {
        NSLog(@"Bot cannot play");
        return 0;
    }
    
    Score *playerScore = [self.yahtzee getPlayerScore];
    
    int highest = 0;
    ScoreType type = 0;
    for(int i=0; i< SCORE_TYPES; i++){
        if(![playerScore isMarked: i]){
            int points = [score getPoints:i];
            if(points >= highest){
                highest = points;
                type = i;
            }
        }
    }
    NSLog(@"Bot picked score:%i ,type:%i", highest, type);
    return type;
}

@end
