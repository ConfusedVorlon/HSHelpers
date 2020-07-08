//
//  String+filetypes.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 08/11/2018.
//

import Foundation

public struct Filetypes {
    
    public static let photo =  ["png", "jpg", "jpeg", "tiff", "bmp", "gif"]
    public static let raw = ["3fr","ari","arw","bay","crw","cr2","cr3","cap",
                      "dcs","dcr","dng","drf","eip","erf","fff","gpr","iiq",
                      "k25","kdc","mdc","mef","mos","mrw","nef","nrw","obm","orf",
                      "pef","ptx","pxn","r3d","raf","raw","rwl","rw2","rwz","sr2","srf","srw","tif","x3f"]
    public static let dynamic = ["heic"]//NB - not all heic are dynamic
    public static let movie = ["mp4","mkv","mov","mpg","webm","m4v","m2v"]
    public static let mmw = ["mmw"]
    
}
