//
//  CommonDefaults.swift
//  CoolWeather
//
//  Created by ardwang on 2021/2/9.
//

import UIKit

class CommonDefaults {
    
    private let queue = DispatchQueue(label: "SaveDataQueue")
    
    let userDefaults = UserDefaults()
    
    static let shared = CommonDefaults()
    
    private init() {}
}


extension CommonDefaults{
    
    func saveValue(_ value: String?, forKey key:String?){
        self.queue.async {
            if value != nil && key != nil {
                self.userDefaults.setValue(value, forKey: key ?? "")
                self.userDefaults.synchronize()
            }
        }
    }
    
    func getValue(_ key: String?) -> String?{
        var value = ""
        if key != nil && !(key?.isEqual("") ?? false) {
            value = self.userDefaults.string(forKey: key ?? "") ?? ""
            //return value
        }
        return value
    }
}
