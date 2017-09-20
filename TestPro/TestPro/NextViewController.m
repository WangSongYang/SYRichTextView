//
//  NextViewController.m
//  iOSPro
//
//  Created by 王颂阳 on 2017/6/26.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import "NextViewController.h"
#import "EFRSJSONResponseSerializer.h"

@interface NextViewController ()<UIGestureRecognizerDelegate>

/** Manager */
@property (nonatomic,strong) AFHTTPSessionManager *httpSessionManager;

@property (weak, nonatomic) IBOutlet UIImageView *userAvator;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Second";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.httpSessionManager = [AFHTTPSessionManager manager];

    EFRSJSONResponseSerializer *responseSerializer = [EFRSJSONResponseSerializer serializer];
    self.httpSessionManager.responseSerializer = responseSerializer;
    
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(panGestureAction:)];
    [self.view addGestureRecognizer:pan];
    UIPanGestureRecognizer * navPan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(panGestureAction:)];
    [self.navigationController.navigationBar addGestureRecognizer:navPan];
}

- (void)panGestureAction:(UIGestureRecognizer *)gesture {
    
    NSLog(@"侧滑啊啊啊");
    
}
// 登录
- (IBAction)loginInterfaceTest:(id)sender {
    
//    [MobClick event:@""];
    NSLog(@"----登录-----");
    
    NSString *validate_sign = @"fCCfjwXdf9T8UenQyrOd4wDYNxjM9iv7Rz9Zab/owFeLI/TZV01esHEaKaOOSsNRjxeQC+pOmPxWHUvheGE5GBTf2N1n/y88k0TSkUkgArOuSPAVzG7V7/BO3qZM2OhEdtFbNBQZxmh6lS1TWj3ASoEM6Fe7cl57Az1smvQNh8U=";

    NSString *urlString = @"https://ecnapptest.originecn.cn/appV/addVisitor?loginDoMain=client&firstVisitIp=192.168.2536.113&firstVisitTime=1498113884";
    
//    [self.httpSessionManager GET:urlString parameters:@{@"x_validate_sign":validate_sign} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"--登录成功--");
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"--登录失败--");
//
//    }];
    
    
    [self.httpSessionManager POST:urlString parameters:@{@"x_validate_sign":validate_sign} progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"--登录成功--");

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"--登录失败--");

    }];
    
}

// 注册
- (IBAction)registInterfaceText:(UIButton *)sender {
    
    NSLog(@"----接口-----");

//    [self.httpSessionManager GET:@"" parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"--注册成功--");
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"--注册失败--");
//        
//    }];
    
//    NSString *urlString = @"https://ecnapptest.originecn.cn/appV/addVisitor?loginDoMain=client&firstVisitIp=192.168.2536.113&firstVisitTime=1498113884";
//    
//    NSString *validate_sign = @"NrBNHz8ssTOpN4IG2jMgSrp1jJ8f9bESz4JltBvKHMH2KkfYBIxwAik2T4yW4VUEksN8uR+CeeyFrPaKwcXBu9GCMSVIzaFZR5jGRjUL9oyQ1Won6KXIH7E+d0mSGazbvSaXs9AMega8kszGYH3Hf32aONeWK7DbAmtTJUV9X3aaBPtCnzc2yoA8c32jsoOnxjiLfEh5pTRCb1irpMl/BQFBHdc4XlYEQ48wPslPSl+aO/gy/zG82TkEESXQDLvjK5YJ8gHrOuiaBvCsZtKMEXKnLkE2MhId+E9sqI024jytv7HHjZePn8OTjgDX3X6hP4kL63cItrHiaTkM0w5vrA==";
//    
//    [self.httpSessionManager.requestSerializer setValue:validate_sign forHTTPHeaderField:@"x_validate_sign"];
//    
//    [self.httpSessionManager POST:urlString parameters:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"--自注册成功--");
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"--自注册失败--");
//        
//    }];

    
    [self postWithURLSession];
    
}

- (void)postWithURLSession {
    
    // 自注册：https://ecnapptest.originecn.cn/appV/addVisitor?loginDoMain=client&firstVisitIp=192.168.2536.113&firstVisitTime=1498113884
    
    // 短信验证码：https://ecnapptest.originecn.cn/appCustomer/getAuthCode?codeType=1&phone=18236995771
    
    // 注册 ：https://ecnapptest.originecn.cn/appCustomer/registered?phone=18518772530&password=123456&code=110113&creatTime=1498113884&creatIp=1.2.13
    
    // 登录 https://ecnapptest.originecn.cn/login/login?phone=18236995771&password=123456&lastLoginTime=1498113884
    
    // 绑定邮箱 /appCustomer/getEmailCode?phone=123456&email=qw@q.com
    NSString *urlString = @"https://ecnapptest.originecn.cn/appCustomer/getUserInfo?uid=18236995771";
    
    //    NSString *validate_sign = @"Simu7kro4g/WAerRG8hmeS0oT7rYg+Df4RRSlrdIyGKt9518jSg4NKTbA9R0rh94a5K0ocShibaiEttREeHBHOIc7JuMKrxDKWLtPZ7/JOYXyiMaQ9a3osCGR+CGH10hMSoyvN6larHHBtM7igce1MisgdBLpwpLW3vbQq8nK5ApZTGO5Sjxo5D38APeO2BijaXryqDrGRVbA33/5KK3FSF85dUngrMKg5p1CqXMkT0l21PH/8UO+5iQo7FApYHXxp2onzZm1ls5STryqccSaS51YzB0E6PEUmVuFbEydd6v58s2EsvE3V1fq6OFIwbg6UtD95Spolce4WmpBG5W1w==";
    
    // 1.创建一个网络路径
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建一个网络请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    // 参数
//    NSString *args = [NSString stringWithFormat:@"x_validate_sign=%@",self.encryptStr];
    
    //    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:self.encryptStr forHTTPHeaderField:@"x_validate_sign"];
    
    // 获取回话对象
    NSURLSessionDataTask *sessionDataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 对服务器返回的数据进行相应的处理
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"%@",dict);
    }];
    
    // 开始执行任务（异步执行）
    [sessionDataTask resume];
    
}


- (void)getWithURLSession {
    
    // 1.创建一个网络路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.16.2.254/php/phonelogin?yourname=%@&yourpas=%@&btn=login",@"",@""]];
    // 2.创建一个网络请求
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4.根据会话对象，创建一个Task任务：
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
            NSLog(@"从服务器获取到数据");
        /*
            对从服务器获取到的数据data进行相应的处理：
        */
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
    
        NSLog(@"%@",dict);
        
    }];
        // 5.最后一步，执行任务（resume也是继续执行）:
    
        [sessionDataTask resume];
}



- (IBAction)otherInterfaceTest:(id)sender {
    
    NSLog(@"----其他-----");

    [self.httpSessionManager GET:@"" parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"--登录成功--");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"--登录失败--");
        
    }];
    
    [self.httpSessionManager POST:@"" parameters:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"--登录成功--");
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"--登录失败--");
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
