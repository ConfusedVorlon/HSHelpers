// From
//https://noahgilmore.com/blog/dark-mode-uicolor-compatibility/

#if canImport(UIKit)

import UIKit

@objcMembers
@objc 
public class ColorCompatibility: NSObject {
    public static var label: UIColor {
        if #available(iOS 13,tvOS 13.0, *) {
            return .label
        }
        return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    public static var secondaryLabel: UIColor {
        if #available(iOS 13, tvOS 13.0,*) {
            return .secondaryLabel
        }
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.6)
    }
    public static var tertiaryLabel: UIColor {
        if #available(iOS 13, tvOS 13.0,*) {
            return .tertiaryLabel
        }
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.3)
    }
    public static var quaternaryLabel: UIColor {
        if #available(iOS 13,tvOS 13.0, *) {
            return .quaternaryLabel
        }
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.18)
    }
    
    
    public static var systemFill: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .systemFill
        }
#endif
        return UIColor(red: 0.47058823529411764, green: 0.47058823529411764, blue: 0.5019607843137255, alpha: 0.2)
    }
    public static var secondarySystemFill: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .secondarySystemFill
        }
#endif
        return UIColor(red: 0.47058823529411764, green: 0.47058823529411764, blue: 0.5019607843137255, alpha: 0.16)
    }
    public static var tertiarySystemFill: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .tertiarySystemFill
        }
#endif
        return UIColor(red: 0.4627450980392157, green: 0.4627450980392157, blue: 0.5019607843137255, alpha: 0.12)
    }
    public static var quaternarySystemFill: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .quaternarySystemFill
        }
#endif
        return UIColor(red: 0.4549019607843137, green: 0.4549019607843137, blue: 0.5019607843137255, alpha: 0.08)
    }
    public static var placeholderText: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .placeholderText
        }
#endif
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.3)
    }
    public static var systemBackground: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .systemBackground
        }
#endif
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    public static var secondarySystemBackground: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .secondarySystemBackground
        }
#endif
        return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
    }
    
    public static var tertiarySystemBackground: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .tertiarySystemBackground
        }
#endif
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    public static var systemGroupedBackground: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .systemGroupedBackground
        }
#endif
        return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
    }
    public static var secondarySystemGroupedBackground: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .secondarySystemGroupedBackground
        }
#endif
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    
    
    public static var tertiarySystemGroupedBackground: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .tertiarySystemGroupedBackground
        }
#endif
        return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
    }
    
    
    public static var separator: UIColor {
        if #available(iOS 13,tvOS 13.0, *) {
            return .separator
        }
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.29)
    }
    public static var opaqueSeparator: UIColor {
        if #available(iOS 13,tvOS 13.0, *) {
            return .opaqueSeparator
        }
        return UIColor(red: 0.7764705882352941, green: 0.7764705882352941, blue: 0.7843137254901961, alpha: 1.0)
    }
    public static var link: UIColor {
        if #available(iOS 13,tvOS 13.0, *) {
            return .link
        }
        return UIColor(red: 0.0, green: 0.47843137254901963, blue: 1.0, alpha: 1.0)
    }
    public static var systemIndigo: UIColor {
        if #available(iOS 13,tvOS 13.0, *) {
            return .systemIndigo
        }
        return UIColor(red: 0.34509803921568627, green: 0.33725490196078434, blue: 0.8392156862745098, alpha: 1.0)
    }
    
    
    
    public static var systemGray2: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .systemGray2
        }
#endif
        return UIColor(red: 0.6823529411764706, green: 0.6823529411764706, blue: 0.6980392156862745, alpha: 1.0)
    }
    public static var systemGray3: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .systemGray3
        }
#endif
        return UIColor(red: 0.7803921568627451, green: 0.7803921568627451, blue: 0.8, alpha: 1.0)
    }
    public static var systemGray4: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .systemGray4
        }
#endif
        return UIColor(red: 0.8196078431372549, green: 0.8196078431372549, blue: 0.8392156862745098, alpha: 1.0)
    }
    public static var systemGray5: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .systemGray5
        }
#endif
        return UIColor(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.9176470588235294, alpha: 1.0)
    }
    public static var systemGray6: UIColor {
#if !os(tvOS)
        if #available(iOS 13, *) {
            return .systemGray6
        }
#endif
        return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
    }
    
}

#endif


