//: Playground - noun: a place where people can play

import UIKit

// one example
public class Preferences {
    public var hogeValue: Int {
        get {
            return UserDefaults.standard.integer(forKey: "hoge")
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "hoge")
        }
    }
    
    public var someSettingValue: Int {
        get {
            return UserDefaults.standard.integer(forKey: "someSettingValue")
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "someSettingValue")
        }
    }
}



public class Preferences2 {
    public var hogeValue: Int = 0
    public var otherHogeValue: Int = 42
}

public class Sample: NSObject {
    public var sampleInt = 32
    public var sampleString = "sample"
}
let mirror = Mirror(reflecting: Sample())
print(mirror.displayStyle)
print(mirror.subjectType)
print(mirror.superclassMirror)
mirror.children.map{ print($0) }

let p = Preferences2()
let m = Mirror(reflecting: p)



print()

for c in m.children {
    print(c.label ?? "" + "=>" + String(describing: c.value))
}

public class Preferences3: NSObject {
    @objc public dynamic var someIntegervalue: Int = 0
    @objc public dynamic var someStringValue: NSString = ""
    @objc public dynamic var someOptionalArrayValue: NSArray?
    
    override init() {
        super.init()
        for child in Mirror(reflecting: self).children {
            guard let key = child.label else { continue }
            self.setValue(UserDefaults.standard.object(forKey: key), forKey: key)
            self.addObserver(self, forKeyPath: key, options: .new, context: nil)
        }
    }
    
    deinit {
        for child in Mirror(reflecting: self).children {
            guard let key = child.label else { continue }
            self.removeObserver(self, forKeyPath: key)
        }
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        var found = false
        for child in Mirror(reflecting: self).children {
            guard let key = child.label else { continue }
            if (key == keyPath) {
                UserDefaults.standard.set(change?[NSKeyValueChangeKey.newKey], forKey: key)
                found = true
                break
            }
            
            if !found {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
         }
    }
}
