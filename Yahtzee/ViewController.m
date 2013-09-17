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
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
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
    NSString* title = @"Greeting";
    NSString* message = @"Welcome to Yahtzee! You are red and bot is blue";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    
    self.yahtzee = [[Yahtzee alloc] init];
    
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

- (IBAction)score1sClicked:(id)sender {
    [self.yahtzee saveScore: S_One];
    self.rollBtn.enabled = YES;
    [self.rollBtn setTitle:@"Roll" forState:UIControlStateNormal];
}
- (IBAction)score2sClicked:(id)sender {
    [self.yahtzee saveScore: S_Two];
}
- (IBAction)score3sClicked:(id)sender {
    [self.yahtzee saveScore: S_Three];
}
- (IBAction)score4sClicked:(id)sender {
    [self.yahtzee saveScore: S_Four];
}
- (IBAction)score5sClicked:(id)sender {
    [self.yahtzee saveScore: S_Five];
}
- (IBAction)score6sClicked:(id)sender {
    [self.yahtzee saveScore: S_Six];
}
- (IBAction)score3OfKClicked:(id)sender {
    [self.yahtzee saveScore: S_ThreeOfAKind];
}
- (IBAction)score4OfKClicked:(id)sender {
    [self.yahtzee saveScore: S_FourOfAKind];
}
- (IBAction)scoreFullHClicked:(id)sender {
    [self.yahtzee saveScore: S_FullHouse];
}
- (IBAction)scoreSmStrClicked:(id)sender {
    [self.yahtzee saveScore: S_SmallStraight];
}
- (IBAction)scoreLgStrClicked:(id)sender {
    [self.yahtzee saveScore: S_LargeStraight];
}
- (IBAction)scoreYahtzeeClicked:(id)sender {
    [self.yahtzee saveScore: S_Yahtzee];
}
- (IBAction)scoreChanceClicked:(id)sender {
    [self.yahtzee saveScore: S_Chance];
}

- (IBAction)rollClicked:(UIButton*)sender {
    [self.rollBtn setTitle:@"Re-Roll" forState:UIControlStateNormal];
    self.score = [self.yahtzee rollDices];
    if(self.yahtzee.chances==0){
        sender.enabled = NO;
    }
    [self setDiceFace: 1];
    [self setDiceFace: 2];
    [self setDiceFace: 3];
    [self setDiceFace: 4];
    [self setDiceFace: 5];
    self.h1sLbl.text = [NSString stringWithFormat:@"%i", self.score.ones];
    self.h2sLbl.text = [NSString stringWithFormat:@"%i", self.score.twoes];
    self.h3sLbl.text = [NSString stringWithFormat:@"%i", self.score.threes];
    self.h4sLbl.text = [NSString stringWithFormat:@"%i", self.score.fours];
    self.h5sLbl.text = [NSString stringWithFormat:@"%i", self.score.fives];
    self.h6sLbl.text = [NSString stringWithFormat:@"%i", self.score.sixes];
    self.h3OfKLbl.text = [NSString stringWithFormat:@"%i", self.score.threeOfAKind];
    self.h4OfKLbl.text = [NSString stringWithFormat:@"%i", self.score.fourOfAKind];
    self.hFullHLbl.text = [NSString stringWithFormat:@"%i", self.score.fullHouse];
    self.hSmStrLbl.text = [NSString stringWithFormat:@"%i", self.score.smallStraight];
    self.hLgStrLbl.text = [NSString stringWithFormat:@"%i", self.score.largeStraight];
    self.hYahtzeeLbl.text = [NSString stringWithFormat:@"%i", self.score.yahtzee];
    self.hChanceLbl.text = [NSString stringWithFormat:@"%i", self.score.chance];
    
}

- (IBAction)gameClicked:(UIButton*)sender {
    if([sender.titleLabel.text isEqual: @"Start"]){
        [self.botSwitch setEnabled:NO];
        [sender setTitle:@"Restart" forState:UIControlStateNormal];
    }else{
        [self.botSwitch setEnabled:YES];
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (IBAction)botChanged:(UISwitch*)sender {
    self.yahtzee.bot = sender.selected;
}



@end
