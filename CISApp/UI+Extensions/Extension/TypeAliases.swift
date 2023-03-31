import Foundation

typealias VoidHandler = ()->Void
typealias StringHandler = ()->String
public typealias HTTPHeaders = [String:String]
public typealias Parameters = [String: Any]
public typealias NetworkRouterComplition = (_ data: Data?, _ response: URLResponse?, _ error: Error?)->()
