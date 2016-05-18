Pod::Spec.new do |s| 
    # 名称 使用的时候pod search [name] 
    s.name = "IRRRRRRKit" 
    # 代码库的版本 
    s.version = "0.0.1" 
    # 简介 
    s.summary = "IRRRRRRKit s.summary." 
    # 主页  
    s.homepage = "https://github.com/NirvanAcN/IRRRRRRKit" 
    # 许可证书类型，要和仓库的LICENSE 的类型一致 
    s.license = "MIT" 
    # 作者名称 和 邮箱 
    s.author = { "iCe_Rabbit" => "mahaomeng@163.com" } 
    # 代码库最低支持的版本 
    s.platform = :ios, "8.0" 
    # 代码的Clone 地址 和 tag 版本 
    s.source = { :git => "https://github.com/NirvanAcN/IRRRRRRKit.git", :tag => "0.0.1", :commit => "0d6761feefccff1f7d8b7c7788ceb8e9cd1314ea"} 
    # 如果使用pod 需要导入哪些资源 
    s.source_files = "IRRRRRRKit/**/*.{swift}" 
    # 框架是否使用的ARC 
    s.requires_arc = true  
end