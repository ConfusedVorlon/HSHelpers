//
//  CGDirectDisplayID+HS.swift
//  Brightness
//
//  Created by Rob Jonson on 24/11/2020.
//

import Foundation


extension CGDirectDisplayID {
    
    /// Return service for display
    /// Release the returned srvice with IOObjectRelease(ioServ)
    /// - Returns: io_service_t
    func getIOService() -> io_service_t? {
        var serialPortIterator = io_iterator_t()
        var ioServ: io_service_t = 0
        
        let thisVendorNumber = CGDisplayVendorNumber(self)
        let thisModelNumber = CGDisplayModelNumber(self)
        let thisSerialNumber = CGDisplaySerialNumber(self)
        
        let matching = IOServiceMatching("IODisplayConnect")

        let kernResult = IOServiceGetMatchingServices(kIOMasterPortDefault, matching, &serialPortIterator)
        if KERN_SUCCESS == kernResult && serialPortIterator != 0 {
            ioServ = IOIteratorNext(serialPortIterator)
            
            defer {
                IOObjectRelease(serialPortIterator)
            }

            while ioServ != 0 {
                
                let info = IODisplayCreateInfoDictionary(ioServ, UInt32(kIODisplayOnlyPreferredName)).takeRetainedValue() as NSDictionary as! [String: AnyObject]
                
                //print("found: \(info)")
                
                let venderID = info[kDisplayVendorID] as? UInt32
                let productID = info[kDisplayProductID] as? UInt32
                let serialNumber = info[kDisplaySerialNumber] as? Int32 ?? 0

                let uSerial = UInt32(bitPattern: serialNumber)
                print("uSerial: \(uSerial)")


                    if thisVendorNumber == venderID &&
                        thisModelNumber == productID &&
                        thisSerialNumber == uSerial {
                        print("found the target io_service_t")
                        break
                    }


                IOObjectRelease(ioServ)
                ioServ = IOIteratorNext(serialPortIterator)
            }
        }

        if ioServ == 0 {
            return nil
        }
        
        return ioServ
    }
}
