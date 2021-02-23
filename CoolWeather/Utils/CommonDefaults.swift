//
//  CommonDefaults.swift
//  CoolWeather
//
//  Created by ardwang on 2021/2/9.
//

import UIKit

class CommonDefaults {
    
    //private let queue = DispatchQueue(label: "SaveDataQueue")
    
    //let userDefaults = UserDefaults()
    
    static let shared = CommonDefaults()
    
    private init() {}
}


extension CommonDefaults{
    
    func saveValue(_ value: String?, forKey key:String?){
        UserDefaults.standard.setValue(value, forKey: key ?? "")
    }
    
    func getValue(_ key: String?) -> String?{
        UserDefaults.standard.string(forKey: key ?? "")
    }
}

extension String{
    var getValue: String?{
        UserDefaults.standard.string(forKey: self)
    }
}
