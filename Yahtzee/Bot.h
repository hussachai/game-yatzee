//
//  Bot.h
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/18/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Yahtzee.h"


@interface Bot : NSObject

@property (nonatomic) Yahtzee *yahtzee;

- (ScoreType) pick: (Score*) score;

@end
