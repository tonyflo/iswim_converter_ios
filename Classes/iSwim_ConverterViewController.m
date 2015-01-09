//
//  iSwim_ConverterViewController.m
//  iSwim Converter
//
//  Created by Tony Florida on 11/4/10.
//  Copyright 2010 Raddfood. All rights reserved.
//

#import "iSwim_ConverterViewController.h"

@implementation iSwim_ConverterViewController

@synthesize inputTime, segmentedControl, outputcourse, gender, finalTime;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[super viewDidLoad];	
	minute = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", nil ];
	second = [[NSArray alloc] initWithObjects:@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", nil];
	hundred = [[NSArray alloc] initWithObjects:@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", @"60", @"61", @"62", @"63", @"64", @"65", @"66", @"67", @"68", @"69", @"70", @"71", @"72", @"73", @"74", @"75", @"76", @"77", @"78", @"79", @"80", @"81", @"82", @"83", @"84", @"85", @"86", @"87", @"88", @"89", @"90", @"91", @"92", @"93", @"94", @"95", @"96", @"97", @"98", @"99", nil];
	stroke = [[NSArray alloc ] initWithObjects:@"50 Freestyle", @"100 Freestyle", @"200 Freestyle", @"400/500 Freestyle", @"800/1000 Freestyle", @"1500/1650 Freestyle", @"100 Butterfly", @"200 Butterfly", @"100 Backstroke", @"200 Backstroke", @"100 Breaststroke", @"200 Breaststroke", @"200 IM", @"400 IM", @"200 Freestyle Relay", @"400 Freestyle Relay", @"800 Freestye Relay", @"200 Medley Relay", @"400 Medley Relay", nil ];
}

//IDK
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	selectedUnit = segmentedControl.selectedSegmentIndex;
	selectedCourse = outputcourse.selectedSegmentIndex;
	selectedGender = gender.selectedSegmentIndex;
}



//SegmentedControl input course
- (IBAction)segmentedControlValueChanged {
	selectedUnit = segmentedControl.selectedSegmentIndex;
	
}

//SegmentedControl output course
- (IBAction) outputCourseControlValueChanged {
	selectedCourse = outputcourse.selectedSegmentIndex;
}

//SegmentedControl gender
- (IBAction) genderControlValueChange {
	selectedGender = gender.selectedSegmentIndex;
}


//Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 4;
}

//Picker width
-(CGFloat)pickerView:(UIPickerView *)pickerview widthForComponent:(NSInteger) component {
	if (component == 0 || component == 1 || component == 2) {
		return 35;
	}
	else {
		return 200;
	}
}

//Button
- (IBAction) sendButtonTapped: (id) sender 
{
	int min = [inputTime selectedRowInComponent:0] * 60;
	int sec = [inputTime selectedRowInComponent:1];
	double hun = ( double ) ( [inputTime selectedRowInComponent:2] ) / 100;
	double timeInSeconds = min + sec + hun;
	//	NSString* themessage = [NSString stringWithFormat:@"%f", timeInSeconds];
	double outputTimeInSeconds;
	
	//LC converstin factors (NCAA)
	double LC50FreeM = 0.870, LC50FreeF = 0.881;
	double LC100FreeM = 0.873, LC100FreeF = 0.884;
	double LC200FreeM = 0.875, LC200FreeF = 0.884;
	double LC400FreeM = 1.115, LC400FreeF = 1.122;
	double LC800FreeM = 1.115, LC800FreeF = 1.130;
	double LC1500FreeM = 0.975, LC1500FreeF = 0.985;
	double LC100FlyM = 0.878, LC100FlyF = 0.887;
	double LC200FlyM = 0.876, LC200FlyF = 0.891;
	double LC100BackM = 0.855, LC100BackF = 0.873;
	double LC200BackM = 0.869, LC200BackF = 0.877;
	double LC100BreastM = 0.866, LC100BreastF = 0.880;
	double LC200BreastM = 0.868, LC200BreastF = 0.888;
	double LC200IMM = 0.867, LC200IMF = 0.877;
	double LC400IMM = 0.875, LC400IMF = 0.886;
	double LC200FreeRM = 0.870, LC200FreeRF = 0.881;
	double LC400FreeRM = 0.873, LC400FreeRF = 0.884;
	double LC800FreeRM = 0.877, LC800FreeRF = 0.884;
	double LC200MedleyRM = 0.868, LC200MedleyRF = 0.879;
	double LC400MedleyRM = 0.866, LC400MedleyRF = 0.878;
	
	//SC converstion factors (NCAA)
	double allStrokes = 0.906;
	double yards400ToMeters500 = 1.153; // 400 meters to 500 yards AND 800 meters to 1000 yards
	double meters1500ToYards1650 = 1.013;
	
	
	//Male
	if (selectedGender == 0 ) {
		NSLog(@"Gender: Male");
		
		//input course SCY
		if ( selectedUnit == 0 ) {
			NSLog(@"Input Course: SCY");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY... same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 || 
					[inputTime selectedRowInComponent:3] == 13 ||
					[inputTime selectedRowInComponent:3] == 14 ||
					[inputTime selectedRowInComponent:3] == 15 || 
					[inputTime selectedRowInComponent:3] == 16 ||
					[inputTime selectedRowInComponent:3] == 17 || 
					[inputTime selectedRowInComponent:3] == 18)					
				{
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					NSLog(@"50 free");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					NSLog(@"100 free");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					NSLog(@"200 free");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					NSLog(@"400 free");					
					outputTimeInSeconds = ( timeInSeconds / yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					NSLog(@"800 free");					
					outputTimeInSeconds = ( timeInSeconds / yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					NSLog(@"1500 free");					
					outputTimeInSeconds = ( timeInSeconds / meters1500ToYards1650 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					NSLog(@"100 fly");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					NSLog(@"200 fly");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					NSLog(@"100 back");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					NSLog(@"200 back");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					NSLog(@"100 breast");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					NSLog(@"200 breast");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					NSLog(@"200 IM");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					NSLog(@"400 IM");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					NSLog(@"200 Free Relay");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					NSLog(@"400 Free Relay");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					NSLog(@"800 Free Relay");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					NSLog(@"200 Medley Relay");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Medly Relay
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					NSLog(@"400 Medley Relay");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					NSLog(@"50 free");
					outputTimeInSeconds = ( timeInSeconds / LC50FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					NSLog(@"100 free");
					outputTimeInSeconds = ( timeInSeconds / LC100FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					NSLog(@"200 free");					
					outputTimeInSeconds = ( timeInSeconds / LC200FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					NSLog(@"400 free");					
					outputTimeInSeconds = ( timeInSeconds / LC400FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}			
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					NSLog(@"800 free");					
					outputTimeInSeconds = ( timeInSeconds / LC800FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					NSLog(@"1500 free");					
					outputTimeInSeconds = ( timeInSeconds / LC1500FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					NSLog(@"100 fly");					
					outputTimeInSeconds = ( timeInSeconds / LC100FlyM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					NSLog(@"200 fly");					
					outputTimeInSeconds = ( timeInSeconds / LC200FlyM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					NSLog(@"100 back");					
					outputTimeInSeconds = ( timeInSeconds / LC100BackM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					NSLog(@"200 back");					
					outputTimeInSeconds = ( timeInSeconds / LC200BackM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					NSLog(@"100 breast");					
					outputTimeInSeconds = ( timeInSeconds / LC100BreastM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					NSLog(@"200 breast");					
					outputTimeInSeconds = ( timeInSeconds / LC200BreastM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					NSLog(@"200 IM");					
					outputTimeInSeconds = ( timeInSeconds / LC200IMM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					NSLog(@"400 IM");					
					outputTimeInSeconds = ( timeInSeconds / LC400IMM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					NSLog(@"200 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds / LC200FreeRM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					NSLog(@"400 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds / LC400FreeRM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					NSLog(@"800 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds / LC800FreeRM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					NSLog(@"200 Medley Relay");					
					outputTimeInSeconds = ( timeInSeconds / LC200MedleyRM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 Medley Realy
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					NSLog(@"400 Medley Relay");					
					outputTimeInSeconds = ( timeInSeconds / LC400MedleyRM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
			}
		}
		
		//input course SCM
		else if ( selectedUnit == 1 ) {
			NSLog (@"Input Course: SCM");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					NSLog(@"50 free");
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					NSLog(@"100 free");
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					NSLog(@"200 free");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					NSLog(@"400 free");					
					outputTimeInSeconds = ( timeInSeconds * yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					NSLog(@"800 free");					
					outputTimeInSeconds = ( timeInSeconds * yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					NSLog(@"1500 free");					
					outputTimeInSeconds = ( timeInSeconds * meters1500ToYards1650 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					NSLog(@"100 fly");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					NSLog(@"200 fly");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					NSLog(@"100 back");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					NSLog(@"200 back");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					NSLog(@"100 breast");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					NSLog(@"200 breast");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					NSLog(@"200 IM");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					NSLog(@"400 IM");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					NSLog(@"200 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					NSLog(@"400 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					NSLog(@"800 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					NSLog(@"200 Medley Relay");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					NSLog(@"400 Medley Relay");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM... same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 ||
					[inputTime selectedRowInComponent:3] == 13 ||
					[inputTime selectedRowInComponent:3] == 14 ||
					[inputTime selectedRowInComponent:3] == 15 || 
					[inputTime selectedRowInComponent:3] == 16 ||
					[inputTime selectedRowInComponent:3] == 17 || 
					[inputTime selectedRowInComponent:3] == 18)					
				{
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC50FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400FreeM/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC800FreeM/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}			
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC1500FreeM/meters1500ToYards1650) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100FlyM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FlyM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100BackM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200BackM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100BreastM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200BreastM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200IMM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400IMM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FreeRM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400FreeRM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC800FreeRM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200MedleyRM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400MedleyRM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);				
				}			
			}
		}
		
		//input course LCM
		else {
			NSLog(@"Input Course: LCM");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds * LC50FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds * LC800FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds * LC1500FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100FlyM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200FlyM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100BackM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200BackM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100BreastM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200BreastM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200IMM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400IMM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200FreeRM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400FreeRM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					outputTimeInSeconds = ( timeInSeconds * LC800FreeRM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200MedleyRM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400MedleyRM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC50FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC400FreeM/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC800FreeM/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC1500FreeM/meters1500ToYards1650) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100FlyM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200FlyM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100BackM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200BackM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100BreastM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200BreastM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200IMM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC400IMM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200FreeRM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC400FreeRM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC800FreeRM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200MedleyRM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC400MedleyRM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM...same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 ||
					[inputTime selectedRowInComponent:3] == 13 ||
					[inputTime selectedRowInComponent:3] == 14 ||
					[inputTime selectedRowInComponent:3] == 15 || 
					[inputTime selectedRowInComponent:3] == 16 ||
					[inputTime selectedRowInComponent:3] == 17 || 
					[inputTime selectedRowInComponent:3] == 18)					
				{
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}							
		}
	}
	
	
	//Female
	else {
		NSLog(@"Gender: Female");
		
		//input course SCY
		if ( selectedUnit == 0 ) {
			NSLog(@"Input Course: SCY");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY... same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 ||
					[inputTime selectedRowInComponent:3] == 13 ||
					[inputTime selectedRowInComponent:3] == 14 ||
					[inputTime selectedRowInComponent:3] == 15 || 
					[inputTime selectedRowInComponent:3] == 16 ||
					[inputTime selectedRowInComponent:3] == 17 || 
					[inputTime selectedRowInComponent:3] == 18)					
				{
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					NSLog(@"50 free");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					NSLog(@"100 free");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					NSLog(@"200 free");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					NSLog(@"400 free");					
					outputTimeInSeconds = ( timeInSeconds / yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					NSLog(@"800 free");					
					outputTimeInSeconds = ( timeInSeconds / yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					NSLog(@"1500 free");					
					outputTimeInSeconds = ( timeInSeconds / meters1500ToYards1650 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					NSLog(@"100 fly");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					NSLog(@"200 fly");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					NSLog(@"100 back");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					NSLog(@"200 back");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					NSLog(@"100 breast");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					NSLog(@"200 breast");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					NSLog(@"200 IM");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					NSLog(@"400 IM");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}			
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					NSLog(@"200 Free Relay");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					NSLog(@"400 Free Relay");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					NSLog(@"800 Free Relay");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					NSLog(@"200 Medley Relay");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Medly Relay
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					NSLog(@"400 Medley Relay");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}						
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds / LC50FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds / LC100FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds / LC200FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds / LC400FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds / LC800FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds / LC1500FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds / LC100FlyF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds / LC200FlyF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds / LC100BackF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds / LC200BackF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds / LC100BreastF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds / LC200BreastF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds / LC200IMF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds / LC400IMF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}							
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					NSLog(@"200 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds / LC200FreeRF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					NSLog(@"400 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds / LC400FreeRF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					NSLog(@"800 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds / LC800FreeRF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					NSLog(@"200 Medley Relay");					
					outputTimeInSeconds = ( timeInSeconds / LC200MedleyRF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 Medley Realy
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					NSLog(@"400 Medley Relay");					
					outputTimeInSeconds = ( timeInSeconds / LC400MedleyRF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
			}
		}
		
		//input course SCM
		else if ( selectedUnit == 1 ) {
			NSLog (@"Input Course: SCM");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY");				
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					NSLog(@"50 free");
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					NSLog(@"100 free");
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					NSLog(@"200 free");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					NSLog(@"400 free");					
					outputTimeInSeconds = ( timeInSeconds * yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					NSLog(@"800 free");					
					outputTimeInSeconds = ( timeInSeconds * yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					NSLog(@"1500 free");					
					outputTimeInSeconds = ( timeInSeconds * meters1500ToYards1650 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					NSLog(@"100 fly");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					NSLog(@"200 fly");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					NSLog(@"100 back");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					NSLog(@"200 back");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					NSLog(@"100 breast");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					NSLog(@"200 breast");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					NSLog(@"200 IM");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					NSLog(@"400 IM");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}			
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					NSLog(@"200 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					NSLog(@"400 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					NSLog(@"800 Free Relay");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					NSLog(@"200 Medley Relay");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					NSLog(@"400 Medley Relay");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM... same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 ||
					[inputTime selectedRowInComponent:3] == 13 ||
					[inputTime selectedRowInComponent:3] == 14 ||
					[inputTime selectedRowInComponent:3] == 15 || 
					[inputTime selectedRowInComponent:3] == 16 ||
					[inputTime selectedRowInComponent:3] == 17 || 
					[inputTime selectedRowInComponent:3] == 18)					
				{
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC50FreeF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100FreeF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FreeF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400FreeF/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC800FreeF/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC1500FreeF/meters1500ToYards1650) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100FlyF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FlyF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100BackF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200BackF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100BreastF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200BreastF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200IMF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400IMF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FreeRF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400FreeRF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC800FreeRF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200MedleyRF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400MedleyRF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);				
				}					
			}			
		}
		
		//input course LCM
		else {
			NSLog(@"Input Course: LCM");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds * LC50FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds * LC800FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds * LC1500FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100FlyF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200FlyF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100BackF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200BackF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100BreastF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200BreastF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200IMF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400IMF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200FreeRF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400FreeRF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					outputTimeInSeconds = ( timeInSeconds * LC800FreeRF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200MedleyRF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400MedleyRF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC50FreeF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100FreeF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200FreeF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC400FreeF / yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC800FreeF / yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC1500FreeF / meters1500ToYards1650) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100FlyF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200FlyF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100BackF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200BackF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100BreastF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200BreastF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200IMF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC400IMF / allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
				
				//200 Free Relay
				if ([inputTime selectedRowInComponent:3] == 14 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200FreeRF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 Free Relay
				if ([inputTime selectedRowInComponent:3] == 15 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC400FreeRF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 Free Relay
				if ([inputTime selectedRowInComponent:3] == 16 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC800FreeRF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 17 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200MedleyRF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 Medley Relay
				if ([inputTime selectedRowInComponent:3] == 18 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC400MedleyRF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM...same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 ||
					[inputTime selectedRowInComponent:3] == 13 ||
					[inputTime selectedRowInComponent:3] == 14 ||
					[inputTime selectedRowInComponent:3] == 15 || 
					[inputTime selectedRowInComponent:3] == 16 ||
					[inputTime selectedRowInComponent:3] == 17 || 
					[inputTime selectedRowInComponent:3] == 18)					
				{
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}							
		}
	}
	int m = 0;
	while ( outputTimeInSeconds >= 60.0 ) {
		outputTimeInSeconds -= 60.0;
		m++;
	}
	
	NSLog(@"minute: %i", m);	
	
	int s = outputTimeInSeconds;
	
	NSLog(@"second: %i", s);
	
	double hh = (outputTimeInSeconds - s);
	double h = hh * 100;
	
	NSLog(@"hundred: %f", h);	
	
	if ( h >= 99.5 ) {
		s += 1;
		h = 0;
	}
	
	if ( s >= 60 ) {
		m += 1;
		s = 0;
	}
	
	NSNumberFormatter *minuteFormat = [[NSNumberFormatter alloc] init];
	[minuteFormat setPositiveFormat:@"00:"];
	NSString *M = [minuteFormat stringForObjectValue:[NSNumber numberWithInt:m]];
	
	NSNumberFormatter *secondFormat = [[NSNumberFormatter alloc] init];
	[secondFormat setPositiveFormat:@"00."];
	NSString *S = [secondFormat stringForObjectValue:[NSNumber numberWithInt:s]];
	
	NSNumberFormatter *hundredFormat = [[NSNumberFormatter alloc] init];
	[hundredFormat setPositiveFormat:@"00"];
	NSString *H = [hundredFormat stringForObjectValue:[NSNumber numberWithDouble:h]];
	
	NSMutableString *done;
	done = [NSMutableString stringWithString: M];
	[done insertString: S atIndex: [done length]];
	[done insertString: H atIndex: [done length]];
	//	NSLog(done);
	
	finalTime.text = done;
	
	
	
}

//Picker
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component 
{
	if (component == 0) 
	{
		return [minute count];
	}
	else if (component == 1) 
	{
		return [second count];
	}
	else if (component == 2 )
	{
		return [hundred count];
	}
	else
	{
		return [stroke count];
	}
	
}


//Memory
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

//Picker
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent: (NSInteger)component{
	switch (component) {
		case 0:
			return [minute objectAtIndex:row];
		case 1:
			return [second objectAtIndex:row];
		case 2:
			return [hundred objectAtIndex:row];
		case 3:
			return [stroke objectAtIndex:row];
	}
	return nil;
}


//Memory
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

//Memory
- (void)dealloc 
{
	[inputTime release];
	[minute release];
	[second release];
	[hundred release];
	[stroke release];
	[segmentedControl release];
	[outputcourse release];
	[gender release];
	//	[timeFormat release];
    [super dealloc];
}

@end