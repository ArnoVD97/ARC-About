//
//  main.m
//  ARC的运用
//
//  Created by zzy on 2023/3/13.
//
/*
 ARC的判断准则：只要没有强指针指向对象，就会释放对象
 指针分2种：
 1>强指针：默认情况下，所有指针都是强指针 __strong
 2>弱指针:  __weak
 在person.h中重写dealloc函数
 */
#import <Foundation/Foundation.h>
#import "Person.h"
//测试一：
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // insert code here...
//        NSLog(@"Hello, World!");
//        Person *p = [[Person alloc] init];//一个强指针，指向person对象
//        p = nil;//将p置为空，这行代码之后，清空指针对象，没有强指针指向的对象会被释放
//        NSLog(@"-----------");
//
//    }
//    return 0;
//}


//测试二：
/*int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[Person alloc] init];//有一个强指针指向的person对象
        Person *p2 = p;//p2也指向person对象，此时有两个强指针指向
        p = [[Person alloc] init];//创建一个新的对象来让p指向，但是另外一个person对象仍然有强指针指向
        NSLog(@"------");
    }
    //所以对象会在程序结束之后释放
    return 0;
}
*/




//测试三：接下来来看弱指针的指向
int main(int argc, const char * argv[]) {
    
        Person *p = [[Person alloc] init];
        __weak Person *p2 = p;//声明一个弱指针，指向person对象
    
        p = nil;//把强指针变为空，对象没有强指针指向就会被释放
    //只要强指针指向的对象不存在，ARC就会自动将指向该对象的弱指针清空，这样是防止野指针错误，该对象依然会被释放。不过好在，对象在被释放的同时，指向它的弱引用会自动被置nil，这个技术叫zeroing weak pointer。这样有效得防止无效指针、野指针的产生。__weak一般用在delegate关系中防止循环引用或者用来修饰指向由Interface Builder编辑与生成的UI控件。
    
        p2 = nil;//弱指针不能决定对象的释放
        NSLog(@"--------");
    //如果我们没有注释掉“强指针置空”，则会在程序结束前首先调用dealloc函数
    //如果注释掉，则在程序结束前调用dealloc函数
    
        return 0;
    
}
/*
 至于什么时候用strong 和weak？

 平时一般都是用strong，也就是默认不添加。
 __weak只有在避免循环引用的时候才会使用，至于循环引用就是两个对象互相持有，或者或互相强引用对方，所以两者永远不能被销毁。必须将其中一方的引用改成__weak的才能打破这种死循环，最常见的就是delegate模式和block情况下使用。
 1.当两个不同的对象各有一个强引用指向对方时就造成循环引用，会导致对象无法释放，例如我们常用的delegate
 */
