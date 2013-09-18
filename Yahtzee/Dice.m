//
//  Dice.m
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/15/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import "Dice.h"

@implementation Dice

- (void) roll {
    if(!self.fixed) {
        self.face = arc4random() % 6 + 1;
    }
}

- (Dice*) initFace:(int) face {
    self.face = face;
    return self;
}

- (void) clear {
    self.face = 0;
    self.fixed = NO;
}

@end
