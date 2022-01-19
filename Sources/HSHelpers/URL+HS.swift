//
//  URL+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 18/02/2019.
//

import Foundation

public extension URL {

// #if os(macOS)
    var bookmark: Data? {
        do {
            #if os(macOS)
            let bookmarkOptions: URL.BookmarkCreationOptions = [.withSecurityScope]
            #else
            let bookmarkOptions: URL.BookmarkCreationOptions = []
            #endif

            return try self.bookmarkData(options: bookmarkOptions,
                                  includingResourceValuesForKeys: nil, relativeTo: nil)
        } catch let error {
            print("error making bookmark: \(error)")
            return nil
        }
    }

    init?(bookmark: Data?) {
        guard let bookmark = bookmark else {
            return nil
        }

        #if os(macOS)
        let bookmarkOptions: URL.BookmarkResolutionOptions = [.withSecurityScope]
        #else
        let bookmarkOptions: URL.BookmarkResolutionOptions = []
        #endif

        var bookmarkDataIsStale = false
        try? self.init(resolvingBookmarkData: bookmark,
                                           options: bookmarkOptions,
                                           relativeTo: nil,
                                           bookmarkDataIsStale: &bookmarkDataIsStale)
        if bookmarkDataIsStale {
            return nil
        }
    }

    // from https://danieltull.co.uk/blog/2018/09/09/wrapping-urls-security-scoped-resource-methods/
    func accessSecurityScopedResource<Value>(_ accessor: (URL) throws -> Value) rethrows -> Value {

        let didStartAccessing = startAccessingSecurityScopedResource()

        defer {
            if didStartAccessing {
                stopAccessingSecurityScopedResource()
            }
        }

        return try accessor(self)
    }

    @available(iOS 9.0, OSX 10.11, tvOS 9.0, watchOS 2.0, *)
    var directory: URL {
        if self.hasDirectoryPath {
            return self
        }
        return self.deletingLastPathComponent()
    }

    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appending(queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }

    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appending(queryItem: URLQueryItem) -> URL? {
        return self.appending(queryItems: [queryItem])
    }

// #endif

}
