//
//  ViewController.m
//  TestSupportEnvDemo
//
//  Created by chenting on 2021/6/29.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.label];
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
        _label.text = @"test env";
        _label.font = [UIFont systemFontOfSize:22.];
        _label.textColor = [UIColor blueColor];
    }
    return _label;
}


@end
