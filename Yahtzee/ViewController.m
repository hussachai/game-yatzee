//
//  ViewController.m
//  Yahtzee
//
//  Created by Hussachai Puripunpinyo on 9/8/13.
//  Copyright (c) 2013 Hussachai Puripunpinyo. All rights reserved.
//

#import "ViewController.h"
#import "Dice.h"
#import "Yahtzee.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *gameBtn;
@property (weak, nonatomic) IBOutlet UISwitch *botSwitch;
@property (weak, nonatomic) IBOutlet UIButton *s1sBtn;
@property (weak, nonatomic) IBOutlet UIButton *s2sBtn;
@property (weak, nonatomic) IBOutlet UIButton *s3sBtn;
@property (weak, nonatomic) IBOutlet UIButton *s4sBtn;
@property (weak, nonatomic) IBOutlet UIButton *s5sBtn;
@property (weak, nonatomic) IBOutlet UIButton *s6sBtn;
@property (weak, nonatomic) IBOutlet UIButton *l3okBtn;
@property (weak, nonatomic) IBOutlet UIButton *l4okBtn;
@property (weak, nonatomic) IBOutlet UIButton *lfhBtn;
@property (weak, nonatomic) IBOutlet UIButton *lssBtn;
@property (weak, nonatomic) IBOutlet UIButton *llsBtn;
@property (weak, nonatomic) IBOutlet UIButton *lyBtn;
@property (weak, nonatomic) IBOutlet UIButton *lcBtn;

@property (weak, nonatomic) IBOutlet UIButton *dice1Btn;
@property (weak, nonatomic) IBOutlet UIButton *dice2Btn;
@property (weak, nonatomic) IBOutlet UIButton *dice3Btn;
@property (weak, nonatomic) IBOutlet UIButton *dice4Btn;
@property (weak, nonatomic) IBOutlet UIButton *dice5Btn;

@property (nonatomic) Yahtzee *yahtzee;

- (void) toggleDice: (int) number button: (UIButton*) button;

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

- (void) toggleDice: (int) number button: (UIButton*) button {
    UIImage* image = Nil;
    Dice* dice = [self.yahtzee getDice: number];
    if(dice.fixed){
        image = [UIImage imageNamed: [NSString stringWithFormat:
                                      @"Spots%i.png", number]];
        dice.fixed = NO;
    }else{
        image = [UIImage imageNamed: [NSString stringWithFormat:
                                      @"Spots%i_Fixed.png", number]];
        dice.fixed = YES;
    }
    [button setImage:image forState:UIControlStateNormal];
}


- (IBAction) dice1Clicked:(UIButton*)sender {
//    [self toggleDice:1 button: self.dice1Btn];
    Dice* dice = [self.yahtzee getDice: 1];
    if(dice.fixed){
        UIImage * normImg = [UIImage imageNamed:@"Spots01.png"];
        [self.dice1Btn setImage:normImg forState:UIControlStateNormal];
        dice.fixed = NO;
    }else{
        UIImage * fixedImg = [UIImage imageNamed:@"Spots01_Fixed.png"];
        [self.dice1Btn setImage:fixedImg forState:UIControlStateNormal];
        dice.fixed = YES;
    }
}

- (IBAction)dice2Clicked:(UIButton*)sender {
    Dice* dice = [self.yahtzee getDice: 2];
    if(dice.fixed){
        UIImage * fixedImg = [UIImage imageNamed:@"Spots02.png"];
        [self.dice2Btn setImage:fixedImg forState:UIControlStateNormal];
        dice.fixed = NO;
    }else{
        UIImage * normImg = [UIImage imageNamed:@"Spots02_Fixed.png"];
        [self.dice2Btn setImage:normImg forState:UIControlStateNormal];
        dice.fixed = YES;
    }
}

- (IBAction)dice3Clicked:(UIButton*)sender {
    Dice* dice = [self.yahtzee getDice: 3];
    if(dice.fixed){
        UIImage * fixedImg = [UIImage imageNamed:@"Spots03.png"];
        [self.dice3Btn setImage:fixedImg forState:UIControlStateNormal];
        dice.fixed = NO;
    }else{
        UIImage * normImg = [UIImage imageNamed:@"Spots03_Fixed.png"];
        [self.dice3Btn setImage:normImg forState:UIControlStateNormal];
        dice.fixed = YES;
    }
}

- (IBAction)dice4Clicked:(UIButton*)sender {
    Dice* dice = [self.yahtzee getDice: 4];
    if(dice.fixed){
        UIImage * fixedImg = [UIImage imageNamed:@"Spots04.png"];
        [self.dice4Btn setImage:fixedImg forState:UIControlStateNormal];
        dice.fixed = NO;
    }else{
        UIImage * normImg = [UIImage imageNamed:@"Spots04_Fixed.png"];
        [self.dice4Btn setImage:normImg forState:UIControlStateNormal];
        dice.fixed = YES;
    }
}

- (IBAction)dice5Clicked:(UIButton*)sender {
    Dice* dice = [self.yahtzee getDice: 5];
    if(dice.fixed){
        UIImage * fixedImg = [UIImage imageNamed:@"Spots05.png"];
        [self.dice5Btn setImage:fixedImg forState:UIControlStateNormal];
        dice.fixed = NO;
    }else{
        UIImage * normImg = [UIImage imageNamed:@"Spots05_Fixed.png"];
        [self.dice5Btn setImage:normImg forState:UIControlStateNormal];
        dice.fixed = YES;
    }
}

- (IBAction)rollClicked:(UIButton*)sender {
    
}

- (void) setGameButtonsEnabled: (BOOL) enabled {
    [self.s1sBtn setEnabled:enabled];
    [self.s2sBtn setEnabled:enabled];
    [self.s3sBtn setEnabled:enabled];
    [self.s4sBtn setEnabled:enabled];
    [self.s5sBtn setEnabled:enabled];
    [self.s6sBtn setEnabled:enabled];
    [self.l3okBtn setEnabled:enabled];
    [self.l4okBtn setEnabled:enabled];
    [self.lfhBtn setEnabled:enabled];
    [self.llsBtn setEnabled:enabled];
    [self.llsBtn setEnabled:enabled];
    [self.lyBtn setEnabled:enabled];
    [self.lcBtn setEnabled:enabled];
}

- (IBAction)gameClicked:(UIButton*)sender {
    if([sender.titleLabel.text isEqual: @"Start"]){
        [self.botSwitch setEnabled:NO];
        [self setGameButtonsEnabled:YES];
        [sender setTitle:@"Restart" forState:UIControlStateNormal];
    }else{
        [self.botSwitch setEnabled:YES];
        [self setGameButtonsEnabled:NO];
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (IBAction)botChanged:(UISwitch*)sender {
    self.yahtzee.bot = sender.selected;
}



@end
