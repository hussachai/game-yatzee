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


@property (nonatomic) Yahtzee *yahtzee;
@property (nonatomic) Score *score;
@property (nonatomic) NSArray *hScoreLbls;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.hScoreLbls = [NSArray arrayWithObjects: self.h1sLbl, self.h2sLbl,
                  self.h3sLbl, self.h4sLbl, self.h5sLbl, self.h6sLbl,
                  self.h3OfKLbl, self.h4OfKLbl, self.hFullHLbl,
                  self.hSmStrLbl, self.hLgStrLbl, self.hYahtzeeLbl,
                  self.hChanceLbl, self.hBonusLbl, self.hUTotalLbl,
                  self.hLTotalLbl, self.hTotalLbl, nil];
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
    
    [self resetDices];
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
    [self.dice1Btn setImage:Nil forState:UIControlStateNormal];
    [self.dice2Btn setImage:Nil forState:UIControlStateNormal];
    [self.dice3Btn setImage:Nil forState:UIControlStateNormal];
    [self.dice4Btn setImage:Nil forState:UIControlStateNormal];
    [self.dice5Btn setImage:Nil forState:UIControlStateNormal];
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
    [self.yahtzee saveScore: scoreType];
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
    [[self.hScoreLbls objectAtIndex: scoreType]
     setTextColor: [UIColor redColor]];
    self.rollBtn.enabled = YES;
    [self.rollBtn setTitle:@"Roll" forState:UIControlStateNormal];
    [self resetDices];
    NSLog(@"Updated score %i for type %i", [self.score getScore:scoreType], scoreType);
    
    if(!self.yahtzee.bot && [playerScore isDone]){
        NSString* title = @"Game Over";
        NSString* message = [NSString stringWithFormat: @"You finished the single player game with score: %i", [playerScore getTotal]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        [self stopGame];
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
    [self.rollBtn setTitle:@"Re-Roll" forState:UIControlStateNormal];
    self.score = [self.yahtzee rollDices];
    if(self.yahtzee.chances==0){
        sender.enabled = NO;
    }
    for(int i =1; i <= TOTAL_DICES; i++){
        [self setDiceFace: i];
    }
    
    Score *playerScore = [self.yahtzee getPlayerScore];
    
    for (int i = 0; i < SCORE_TYPES; i++){
        UILabel *label = [self.hScoreLbls objectAtIndex:i];
        if(![playerScore isMarked: i]){
            label.text = [NSString stringWithFormat:@"%i",
                      [self.score getScore:i]];
        }
    }
}

- (void) startGame {
    [self.rollBtn setEnabled:YES];
    [self.botSwitch setEnabled:NO];
    [self.gameBtn setTitle:@"Restart" forState:UIControlStateNormal];
}

- (void) stopGame {
    [self.rollBtn setEnabled:NO];
    [self.botSwitch setEnabled:YES];
    [self.gameBtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.rollBtn setTitle:@"Roll" forState:UIControlStateNormal];
    [self resetDices];
    for(UILabel *hScoreLbl in self.hScoreLbls){
        hScoreLbl.text = @"-";
        [hScoreLbl setTextColor:[UIColor blackColor]];
    }
    [self.yahtzee clear];
}

- (IBAction)gameClicked:(UIButton*)sender {
    if([sender.titleLabel.text isEqual: @"Start"]){
        [self startGame];
    }else{
        [self stopGame];
    }
}

- (IBAction)botChanged:(UISwitch*)sender {
    self.yahtzee.bot = sender.selected;
}



@end
