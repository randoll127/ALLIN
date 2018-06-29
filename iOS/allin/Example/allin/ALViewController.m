#import "ALViewController.h"
#import <allin/ALBase.h>
#import <allin/ALNetworkPath.h>

@interface ALViewController ()

@end

@implementation ALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ALNetworkPath* path = [[ALNetworkPath alloc]initWithPath:@"/hello/{hi}/s"];
    NSLog(@"%@",[path parseParams]);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
