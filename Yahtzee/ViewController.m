//
//  ViewController.m
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/8/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import "ViewController.h"
#import "Dice.h"
#import "Score.h"
#import "Yahtzee.h"
#import "Bot.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *gameBtn;
@property (weak, nonatomic) IBOutlet UISwitch *botSwitch;
@property (weak, nonatomic) IBOutlet UIButton *rollBtn;

@property (weak, nonatomic) IBOutlet UIButton *dice1Btn;
@property (weak, nonatomic) IBOutlet UIButton *dice2Btn;
@property (weak, nonatomic) IBOutlet UIButton *dice3Btn;
@property (weak, nonatomic) IBOutlet UIButton *dice4Btn;
@property (weak, nonatomic) IBOutlet UIButton *dice5Btn;

@property (weak, nonatomic) IBOutlet UILabel *h1sLbl;
@property (weak, nonatomic) IBOutlet UILabel *h2sLbl;
@property (weak, nonatomic) IBOutlet UILabel *h3sLbl;
@property (weak, nonatomic) IBOutlet UILabel *h4sLbl;
@property (weak, nonatomic) IBOutlet UILabel *h5sLbl;
@property (weak, nonatomic) IBOutlet UILabel *h6sLbl;
@property (weak, nonatomic) IBOutlet UILabel *hBonusLbl;
@property (weak, nonatomic) IBOutlet UILabel *hUTotalLbl;
@property (weak, nonatomic) IBOutlet UILabel *h3OfKLbl;
@property (weak, nonatomic) IBOutlet UILabel *h4OfKLbl;
@property (weak, nonatomic) IBOutlet UILabel *hFullHLbl;
@property (weak, nonatomic) IBOutlet UILabel *hSmStrLbl;
@property (weak, nonatomic) IBOutlet UILabel *hLgStrLbl;
@property (weak, nonatomic) IBOutlet UILabel *hYahtzeeLbl;
@property (weak, nonatomic) IBOutlet UILabel *hChanceLbl;
@property (weak, nonatomic) IBOutlet UILabel *hLTotalLbl;
@property (weak, nonatomic) IBOutlet UILabel *hTotalLbl;

@property (weak, nonatomic) IBOutlet UILabel *b1sLbl;
@property (weak, nonatomic) IBOutlet UILabel *b2sLbl;
@property (weak, nonatomic) IBOutlet UILabel *b3sLbl;
@property (weak, nonatomic) IBOutlet UILabel *b4sLbl;
@property (weak, nonatomic) IBOutlet UILabel *b5sLbl;
@property (weak, nonatomic) IBOutlet UILabel *b6sLbl;
@property (weak, nonatomic) IBOutlet UILabel *bBonusLbl;
@property (weak, nonatomic) IBOutlet UILabel *bUTotalLbl;
@property (weak, nonatomic) IBOutlet UILabel *b3OfKLbl;
@property (weak, nonatomic) IBOutlet UILabel *b4OfKLbl;
@property (weak, nonatomic) IBOutlet UILabel *bFullHLbl;
@property (weak, nonatomic) IBOutlet UILabel *bSmStrLbl;
@property (weak, nonatomic) IBOutlet UILabel *bLgStrLbl;
@property (weak, nonatomic) IBOutlet UILabel *bYahtzeeLbl;
@property (weak, nonatomic) IBOutlet UILabel *bChanceLbl;
@property (weak, nonatomic) IBOutlet UILabel *bLTotalLbl;
@property (weak, nonatomic) IBOutlet UILabel *bTotalLbl;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

@property (nonatomic) Yahtzee *yahtzee;
@property (nonatomic) Score *score;
@property (nonatomic) Bot *bot;
@property (nonatomic) NSArray *hScoreLbls;
@property (nonatomic) NSArray *bScoreLbls;
@property (nonatomic) BOOL started;

@property (nonatomic) AVAudioPlayer *diceSound;
@property (nonatomic) AVAudioPlayer *clickSound;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSURL* diceSoundFile = [NSURL fileURLWithPath:
        [[NSBundle mainBundle] pathForResource:@ "ShakingDices" ofType:@"wav"]];
    self.diceSound = [[AVAudioPlayer alloc] initWithContentsOfURL:diceSoundFile error:nil];
    NSURL* clickSoundFile = [NSURL fileURLWithPath:
        [[NSBundle mainBundle] pathForResource:@ "MouseClick" ofType:@"wav"]];
    self.clickSound = [[AVAudioPlayer alloc] initWithContentsOfURL:clickSoundFile error:nil];
    
    self.hScoreLbls = [NSArray arrayWithObjects: self.h1sLbl, self.h2sLbl,
                  self.h3sLbl, self.h4sLbl, self.h5sLbl, self.h6sLbl,
                  self.h3OfKLbl, self.h4OfKLbl, self.hFullHLbl,
                  self.hSmStrLbl, self.hLgStrLbl, self.hYahtzeeLbl,
                  self.hChanceLbl, self.hBonusLbl, self.hUTotalLbl,
                  self.hLTotalLbl, self.hTotalLbl, nil];
    self.bScoreLbls = [NSArray arrayWithObjects: self.b1sLbl, self.b2sLbl,
                       self.b3sLbl, self.b4sLbl, self.b5sLbl, self.b6sLbl,
                       self.b3OfKLbl, self.b4OfKLbl, self.bFullHLbl,
                       self.bSmStrLbl, self.bLgStrLbl, self.bYahtzeeLbl,
                       self.bChanceLbl, self.bBonusLbl, self.bUTotalLbl,
                       self.bLTotalLbl, self.bTotalLbl, nil];
	// Do any additional setup after loading the view, typically from a nib.
    for(id obj in [self.view subviews]){
        if([obj isKindOfClass:[UILabel class]]){
            UILabel* label = ((UILabel *)obj);
            if([label.text isEqualToString: @"HH"]  ||
               [label.text isEqualToString: @"HHH"] ||
               [label.text isEqualToString: @"BB"]  ||
               [label.text isEqualToString: @"BBB"]){
                label.text = @"-";
            }
        }
    }
    
    self.yahtzee = [[Yahtzee alloc] init];
    self.bot = [[Bot alloc] init];
    self.bot.yahtzee = self.yahtzee;
    
    [self stopGame];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL) shouldAutorotate {
    return YES;
}

- (void) resetDices {
    for (int i = 1; i <= TOTAL_DICES; i++){
        Dice *dice = [self.yahtzee getDice: i];
        [dice clear];
    }
    UIImage *image = [UIImage imageNamed:@"Spots_Q.png"];
    [self.dice1Btn setImage:image forState:UIControlStateNormal];
    [self.dice2Btn setImage:image forState:UIControlStateNormal];
    [self.dice3Btn setImage:image forState:UIControlStateNormal];
    [self.dice4Btn setImage:image forState:UIControlStateNormal];
    [self.dice5Btn setImage:image forState:UIControlStateNormal];
}

- (void) diceClicked: (int) number {
    Dice* dice = [self.yahtzee getDice: number];
    if(dice.fixed) dice.fixed = NO;
    else dice.fixed = YES;
    [self setDiceFace: number];
}

- (IBAction) dice1Clicked:(UIButton*)sender {
    [self diceClicked: 1];
}

- (IBAction)dice2Clicked:(UIButton*)sender {
    [self diceClicked: 2];
}

- (IBAction)dice3Clicked:(UIButton*)sender {
    [self diceClicked: 3];
}

- (IBAction)dice4Clicked:(UIButton*)sender {
    [self diceClicked: 4];
}

- (IBAction)dice5Clicked:(UIButton*)sender {
    [self diceClicked: 5];
}

- (void) setDiceFace: (int) number {
    Dice *dice = [self.yahtzee getDice: number];
    NSString *imgName = Nil;
    if(dice.fixed){
        imgName = [NSString stringWithFormat:@"Spots0%i_Fixed.png", dice.face];
    }else{
        imgName = [NSString stringWithFormat:@"Spots0%i.png", dice.face];
    }
    
    UIImage * image = [UIImage imageNamed:imgName];
    UIButton *diceBtn = Nil;
    if(number == 1) diceBtn = self.dice1Btn;
    else if(number == 2) diceBtn = self.dice2Btn;
    else if(number == 3) diceBtn = self.dice3Btn;
    else if(number == 4) diceBtn = self.dice4Btn;
    else diceBtn = self.dice5Btn;
    
    [diceBtn setImage:image forState:UIControlStateNormal];
}


- (void) updateScore:(ScoreType)scoreType {
    //If it's not your turn, do nothing.
    if([self.yahtzee getTurn] != 0) {
        NSLog(@"It's not user turn");
        return;
    }
    if(![self.rollBtn.titleLabel.text isEqualToString:@"Re-Roll"]){
        //Don't do anything if user hasn't rolled dices yet.
        NSLog(@"User hasn't rolled dices yet");
        return;
    }
    Score *playerScore = [self.yahtzee getPlayerScore];
    if([playerScore isMarked:scoreType]){
        NSLog(@"ScoreType: %i has already been marked", scoreType);
        return;
    }
    [self.clickSound play];
    [self.yahtzee saveScore: scoreType];
    NSLog(@"Updated score %i for type %i", [self.score getPoints:scoreType], scoreType);
    [[self.hScoreLbls objectAtIndex: scoreType]
     setTextColor: [UIColor redColor]];
    
    for (int i = 0; i < SCORE_TYPES; i++){
        UILabel *label = [self.hScoreLbls objectAtIndex:i];
        if(![playerScore isMarked: i]){
            label.text = @"-";
        }
    }
    
    if(playerScore.bonus>0){
        [self.hBonusLbl setText: [NSString stringWithFormat:@"%i", playerScore.bonus]];
        [self.hBonusLbl setTextColor:[UIColor redColor]];
    }
    if([playerScore getUpperTotal]>0){
        [self.hUTotalLbl setText: [NSString stringWithFormat:@"%i", [playerScore getUpperTotal]]];
        [self.hUTotalLbl setTextColor:[UIColor redColor]];
    }
    if([playerScore getLowerTotal]>0){
        [self.hLTotalLbl setText: [NSString stringWithFormat:@"%i", [playerScore getLowerTotal]]];
        [self.hLTotalLbl setTextColor:[UIColor redColor]];
    }
    if([playerScore getTotal]>0){
        [self.hTotalLbl setText: [NSString stringWithFormat:@"%i", [playerScore getTotal]]];
        [self.hTotalLbl setTextColor:[UIColor redColor]];
    }
    
    //Bot interception
    if(self.yahtzee.bot){
        
        self.rollBtn.enabled = NO;
        
        self.score = [self.yahtzee rollDices];
        for(int i =1; i <= TOTAL_DICES; i++){
            [self setDiceFace: i];
        }
        
        ScoreType pickedScoreType = [self.bot pick: self.score];
        int botPoints = [self.score getPoints: pickedScoreType];
        UILabel *botScoreLbl = [self.bScoreLbls objectAtIndex:pickedScoreType];
        botScoreLbl.text = [NSString stringWithFormat:@"%i",botPoints];
        
        playerScore = [self.yahtzee getPlayerScore];
        
        [self.yahtzee saveScore:pickedScoreType];
        
        if(playerScore.bonus>0){
            [self.bBonusLbl setText: [NSString stringWithFormat:@"%i", playerScore.bonus]];
            [self.bBonusLbl setTextColor:[UIColor blueColor]];
        }
        if([playerScore getUpperTotal]>0){
            [self.bUTotalLbl setText: [NSString stringWithFormat:@"%i", [playerScore getUpperTotal]]];
            [self.bUTotalLbl setTextColor:[UIColor blueColor]];
        }
        if([playerScore getLowerTotal]>0){
            [self.bLTotalLbl setText: [NSString stringWithFormat:@"%i", [playerScore getLowerTotal]]];
            [self.bLTotalLbl setTextColor:[UIColor blueColor]];
        }
        if([playerScore getTotal]>0){
            [self.bTotalLbl setText: [NSString stringWithFormat:@"%i", [playerScore getTotal]]];
            [self.bTotalLbl setTextColor:[UIColor blueColor]];
        }
        
    }
    
    [self resetDices];
    
    self.rollBtn.enabled = YES;
    self.statusLbl.text = @"Roll Them!";
    
    [self.rollBtn setTitle:@"Roll" forState:UIControlStateNormal];
    
    if([self.yahtzee isGameOver]){
        NSString *title = @"Game Over";
        if(!self.yahtzee.bot){
            NSString *message = [NSString stringWithFormat: @"You finished the single player game with score: %i", [playerScore getTotal]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
            [self stopGame];
        }else{
            Score *hScore = [self.yahtzee.scores objectAtIndex:0];
            Score *bScore = [self.yahtzee.scores objectAtIndex:1];
            //It supports 2 players only for this version
            int hTotal = [hScore getTotal];
            int bTotal = [bScore getTotal];
            NSString *status = @"Sorry! You lose.";
            if(hTotal > bTotal){
               status = @"Congratulation! You win.";
            }
            NSString *message = [NSString stringWithFormat: @"%@ Your score: %i, Opponent's score: %i", status, hTotal, bTotal];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
            [self stopGame];
        }
    }
    
}

- (IBAction)score1sClicked:(UIButton*)sender {
    [self updateScore: S_One];
}
- (IBAction)score2sClicked:(UIButton*)sender {
    [self updateScore: S_Two];
}
- (IBAction)score3sClicked:(UIButton*)sender {
    [self updateScore: S_Three];
}
- (IBAction)score4sClicked:(UIButton*)sender {
    [self updateScore: S_Four];
}
- (IBAction)score5sClicked:(UIButton*)sender {
    [self updateScore: S_Five];
}
- (IBAction)score6sClicked:(UIButton*)sender {
    [self updateScore: S_Six];
}
- (IBAction)score3OfKClicked:(UIButton*)sender {
    [self updateScore: S_ThreeOfAKind];
}
- (IBAction)score4OfKClicked:(UIButton*)sender {
    [self updateScore: S_FourOfAKind];
}
- (IBAction)scoreFullHClicked:(UIButton*)sender {
    [self updateScore: S_FullHouse];
}
- (IBAction)scoreSmStrClicked:(UIButton*)sender {
    [self updateScore: S_SmallStraight];
}
- (IBAction)scoreLgStrClicked:(UIButton*)sender {
    [self updateScore: S_LargeStraight];
}
- (IBAction)scoreYahtzeeClicked:(UIButton*)sender {
    [self updateScore: S_Yahtzee];
}
- (IBAction)scoreChanceClicked:(UIButton*)sender {
    [self updateScore: S_Chance];
}

- (IBAction)rollClicked:(UIButton*)sender {
    if(!self.started){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello!" message:@"You have to click 'start' button to begin the game" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        return;
    }
    
    if([self.yahtzee getTurn] != 0) {
        NSLog(@"It's not user turn");
        return;
    }
    [self.diceSound play];
    [self.rollBtn setTitle:@"Re-Roll" forState:UIControlStateNormal];
    self.score = [self.yahtzee rollDices];
    if(self.yahtzee.chances==0){
        self.statusLbl.text = @"Enter Score";
        self.rollBtn.enabled = NO;
    }
    
    for(int i =1; i <= TOTAL_DICES; i++){
        [self setDiceFace: i];
    }
    
    Score *playerScore = [self.yahtzee getPlayerScore];
    if([self.yahtzee getTurn] == 0){
        //Human's turn
        for (int i = 0; i < SCORE_TYPES; i++){
            UILabel *label = [self.hScoreLbls objectAtIndex:i];
            if(![playerScore isMarked: i]){
                label.text = [NSString stringWithFormat:@"%i",
                          [self.score getPoints:i]];
            }
        }
    }
}

- (void) startGame {
    self.started = YES;
    self.statusLbl.text = @"Roll Them!";
    [self.botSwitch setEnabled:NO];
    [self.gameBtn setTitle:@"Restart" forState:UIControlStateNormal];
}

- (void) stopGame {
    self.started = NO;
    self.statusLbl.text = @"Click Start";
    [self.botSwitch setEnabled:YES];
    [self.gameBtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.rollBtn setTitle:@"Roll" forState:UIControlStateNormal];
    [self resetDices];
    for(UILabel *hScoreLbl in self.hScoreLbls){
        hScoreLbl.text = @"-";
        [hScoreLbl setTextColor:[UIColor blackColor]];
    }
    for(UILabel *bScoreLbl in self.bScoreLbls){
        bScoreLbl.text = @"-";
        [bScoreLbl setTextColor:[UIColor blueColor]];
    }
    [self.yahtzee clear];
}

-(void) alertView:(UIAlertView*) alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1){
        [self stopGame];
    }
}

- (IBAction)gameClicked:(UIButton*)sender {
    if([sender.titleLabel.text isEqual: @"Start"]){
        [self startGame];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Attention" message: @"Are you sure to restart the game?"
            delegate: self cancelButtonTitle:@"Cancel"
            otherButtonTitles:@"Yes", nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
}

- (IBAction)botChanged:(UISwitch*)sender {
    self.yahtzee.bot = sender.on;
}



@end
