## 2016-01-27 

  [这是 原项目 地址](https://github.com/NikantVohra/HackerNewsClient-iOS)  	
  		
  	在网上 发现一个 Swift Demo, 打开 发现 好像是 Swift 1.1 版本, 改了下
  	
  	我当前版本
    	Mac			10.11.3 
    	Xcode 		7.2
    	Swift		2.1.1
    	iOS			9.2
    	CocoaPods	0.39.0
    	
`使用 CocoaPods 遇到 一个问题`
	
	Alamofire 这个 Swift 框架, 原项目 是直接 拖进去的, 应该是 已经过时了, 所以 我使用 pods 管理
	
	但是 需要 在 Podfile 加 这么 一句: use_frameworks!
	
	导致 桥接 文件 导入的 头文件 报错: file not found (奇怪的是 在模拟器上 正常)
	
	解决方法:  哪里用到 就导入 一下, 桥接文件 已作废
	
	😳 这个项目 第一次打开 会闪退, 再打开就好了 😄
