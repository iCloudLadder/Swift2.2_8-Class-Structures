//
//  ViewController.swift
//  VSClassAndStructuresStudy
//
//  Created by cooperLink on 16/3/14.
//  Copyright © 2016年 VS. All rights reserved.
//

import UIKit

/*
    
Swift 中类和结构体有很多共同点。共同处在于:
• 定义属性用于存储值
• 定义方法用于提供功能
• 定义附属脚本用于访问值
• 定义构造器用于生成初始化值
• 通过扩展以增加默认实现的功能 
• 实现协议以提供某种标准功能


与结构体相比,类还有如下的附加功能:
• 继承允许一个类继承另一个类的特征
• 类型转换允许在运行时检查和解释一个类实例的类型 
• 解构器允许一个类实例释放任何其所被分配的资源
• 引用计数允许对一个类的多次引用

结构体总是通过被复制的方式在代码中传递,不使用引用计数。


定义类使用关键字 class, 语法
class SomeClass{
<#properties and methods#>
}

定义结构体使用关键字 struct, 语法
struct SomeStruct {
<#properties and methods#>
}

在定义class，struct 等定义一个新的 swift 类型类型时，其名字使用 每个单词首字母大写的驼峰式
在定义属性和方法时，第一个单词小写，其他单词首字母大写的格式


*/

class ViewController: UIViewController {
    
    // 存储属性是被捆绑和存储在类或结构体中的常量或变量。
    // struct Resolution, 包含两个存储属性width & height，当这两个属性 被初始化为整数 0 的时候,它们会被推断为 Int 类型。
    struct Resolution {
        var width = 0
        var height = 0
    }

    // class VideoMode
    // name 初始值为 nil，可选类型
    class VideoMode {
        var resolution = Resolution() // struct Resolution类型 存储属性 分辨率，初始值 {0, 0}
        var interlaced = false // Bool 类型
        var frameRate = 0.0 // double 类型
        var name : String? // name 初始值为 nil，可选类型
    }
    
    
    /*
    结构体和类都使用构造器语法来生成新的实例。
    构造器语法的最简单形式是在结构体或者类的类型名称后跟随一 对空括号,如 Resolution() 或 VideoMode() 。
    通过这种方式所创建的类或者结构体实例,其属性均会被初始化为 默认值。
    */
    // 结构体实例
    let someResolution = Resolution()
    // 类实例
    let someVideoMode = VideoMode()
    
    
    // 属性访问使用 点(.) 语法
    // 也可以使用 点(.) 语法 给变量属性赋值
    func dotSyntax(){
        print("someVideoMode ->resolution , width = \(someVideoMode.resolution.width), height = \(someVideoMode.resolution.height)")
        
        // 与 Objective-C 语言不同的是,Swift 允许直接设置结构体属性的子属性。
        someVideoMode.resolution.width = 1080
        print("someVideoMode ->resolution , width = \(someVideoMode.resolution.width), height = \(someVideoMode.resolution.height)")
    }
    
    
    // 结构体的成员逐一构造器
    // 与结构体不同,类实例没有默认的成员逐一构造器
    let someResolution1 = Resolution(width: 1024, height: 768)
    
    // 在 Swift 中,所有的结构体和枚举类型都是值类型
    // 值类型被赋予给一个变量、常量或者被传递给一个函数的时候,其值会被拷贝。
    // 在 Swift 中,所有的基本类型:整数(Integer)、浮 点数(floating-point)、布尔值(Boolean)、字符串(string)、数组(array)和字典(dictionary),都是 值类型
    // Objective-C 中 NSString , NSArray 和 NSDictionary 类型均以类的形式实现,而并非结构体。它们在被赋值或 者被传入函数或方法时,不会发生值拷贝,而是传递现有实例的引用。
    
    // 对于值类型， 拷贝行为看起来似乎总会发生。
    // 然而,Swift 在幕后只在绝对必要时才执行实际的拷贝。
    // Swift 管理所有的值拷贝以确保性能最优化,所以你没必要去回 避赋值来保证性能最优化。
    func testValueType(){
        var otherResolution = someResolution1
        print("<< someResolution1.width = \(someResolution1.width), otherResolution,width = \(otherResolution.width)")
        otherResolution.width = 1048
        print(">> someResolution1.width = \(someResolution1.width), otherResolution,width = \(otherResolution.width)")
    }

    
    
    // 类 是引用类型
    // 与值类型不同,引用类型在被赋予到一个变量、常量或者被传递到一个函数时,其值不会被拷贝, 而是增加类实例的引用计数。
    func testReferenceType(){
        let vm = VideoMode()
        vm.resolution = Resolution(width: 2048, height: 1536)
        vm.name = "VM"
        print("<< vm.resolution.width = \(vm.resolution.width), vm.name = \(vm.name!)")

        let otherVM = vm
        otherVM.resolution.width = 1024
        otherVM.name = "otherVM"
        print(">> vm.resolution.width = \(vm.resolution.width), vm.name = \(vm.name!)")

    }
    
    
    // 恒等运算符  用于判定两个常量或者变量是否引用同一个类实例将
    // 因为类是引用类型,有可能有多个常量和变量在幕后同时引用同一个类实例。(对于结构体和枚举来说,这并不成立。因为它们作为值类型,在被赋予到常量、变量或者传递到函数时,其值总是会被拷贝。)
    // • 等价于(===)
    // • 不等价于(!==)
    
    /*
    “等价于”(用三个等号表示, === )与“等于”(用两个等号表示, == )的不同: 
    • “等价于”表示两个类类型(class type)的常量或者变量引用同一个类实例。
    • “等于”表示两个实例的值“相等”或“相同”,判定时要遵照设计者定义的评判标准,因此相对于“相 等”来说,这是一种更加合适的叫法
    */
    func testIdentical(){
        let vm1 = VideoMode()
        let vm2 = vm1
        let vm3 = VideoMode()
        if vm1 === vm2{
            print("vm1 === vm2")
        }else{
            print("vm1 !== vm2")
        }
        
        if vm1 === vm3{
            print("vm1 === vm3")
        }else{
            print("vm1 !== vm3")
        }
        
        if vm3 !== vm2{
            print("vm3 !== vm2")
        }else{
            print("vm3 === vm2")
        }
        
    }
    
    
    
    // 类 和 结构体 的选择
    /*
    结构体实例总是通过值传递,类实例总是通过引用传递。
    
    按照通用的准则,当符合一条或多条以下条件时,请考虑构建结构体:
    • 该数据结构的主要目的是用来封装少量相关简单数据值。
    • 有理由预计该数据结构的实例在被赋值或传递时,封装的数据将会被拷贝而不是被引用。
    • 该数据结构中储存的值类型属性,也应该被拷贝,而不是被引用。
    • 该数据结构不需要去继承另一个既有类型的属性或者行为。
    
    
    
    绝大部分的自定义数据构造都应该是类,而非结构体
    因一个类,生成一个它的实例,是通过引用来管理和传递
    
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dotSyntax()
        testValueType()
        testReferenceType()
        
        testIdentical()
    }

    
    
    
    
    
    
    
    
    
    


}

