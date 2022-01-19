//
//  FileManager.swift

//
//  Created by Rob Jonson on 19/07/2016.
//  Copyright © 2016 HobbyistSoftware. All rights reserved.
//

import Foundation

public extension FileManager {

    var documentsDirectory: URL {
        get {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
    }

    var cachesDirectory: URL {
        get {
            return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        }
    }

    /// Creates directory in NSTemporary directory
    /// - Parameter folderName: if present, creates subdirectory with given name e.g. tmp/uuid/folderName
    /// - Throws: createDirectory
    /// - Returns: url of new directory
    class func createTemporaryDirectory(folderName: String? = nil) throws -> URL {
        var url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        if let containingComponent = folderName {
            url = url.appendingPathComponent(containingComponent)
        }

        try self.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        return url
    }

    class func sizeOfFile(atPath path: String) -> Int64? {
        return try? (FileManager.default.attributesOfItem(atPath: path)[FileAttributeKey.size]! as AnyObject).longLongValue
    }

    class func sizeOfFile(atURL url: URL) -> Int64? {
        if !url.isFileURL {
            return nil
        }
        return self.sizeOfFile(atPath: url.path)
    }

    class func modificationDateOfFile(atPath path: String) -> Date? {
        let fm = FileManager.default

        guard let sourceDetails = try? fm.attributesOfItem(atPath: path) else {
            return nil
        }

        return sourceDetails[FileAttributeKey.modificationDate] as? Date
    }

    class func modificationDateOfFile(atURL url: URL) -> Date? {
        if !url.isFileURL {
            return nil
        }
        return self.modificationDateOfFile(atPath: url.path)
    }

    class func fileIsDirectory(atPath path: String) -> Bool {
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: path, isDirectory: &isDir) {
            if isDir.boolValue {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    class func fileIsDirectory(atURL url: URL) -> Bool {
        if !url.isFileURL {
            return false
        }
        return self.fileIsDirectory(atPath: url.path)
    }

    @available(*, deprecated, message: "Don't use this, use Data.writeWithIntermediaryDirectories")
    class func save(data: Data, fullFilename: String, createDirectory: Bool = true, allowEmpty: Bool = false ) -> Bool {

        if !allowEmpty && data.count == 0 {
            print("attempted to save an empty file : \(fullFilename)")
            return false
        }

        if createDirectory {
            let saveDir = URL(fileURLWithPath: fullFilename).deletingLastPathComponent()

                do {
                    try FileManager.default.createDirectory(at: saveDir,
                                                            withIntermediateDirectories: true,
                                                            attributes: nil)
                } catch {
                    print("unable to create directory: \(error)")
                }

        }

        return FileManager.default.createFile(atPath: fullFilename, contents: data, attributes: nil)
    }

    class func uniquePath(fromBase basePath: String) -> String {

        var exists = FileManager.default.fileExists(atPath: basePath)
        if !exists {
            return basePath
        }

        var increment = 1
        var incrementedPath: String = basePath

        let fileName =  URL(fileURLWithPath: basePath).deletingPathExtension().absoluteString
        let fileExtension =  URL(fileURLWithPath: basePath).pathExtension

        while exists {
            incrementedPath = "\(fileName)_\(increment).\(fileExtension)"
            increment += 1

            exists = FileManager.default.fileExists(atPath: incrementedPath)
        }

        return incrementedPath
    }

    class func uniqueFileURL(fromBase base: URL) -> URL {
        let incrementedPath = uniquePath(fromBase: base.path)
        return URL(fileURLWithPath: incrementedPath)
    }
}
