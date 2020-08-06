//
// Model.swift
// Engine
//
// Copyright (c) 2020 Siam Biswas.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

/// Types adopting the `ModelBased` protocol can contain a `Model`
public protocol ModelBased {
    /// The type of Model
    associatedtype Model
    
    /// The model Object
    var model: Model? { get set }
    
     /// The setup method which will be called after the model initialization & modification
    func setupModel()
}

// MARK: -

/// Types adopting the `Model` protocol can be used as Model components for Engine
public protocol Model:Codable{
    
    /// Creates a `Model` instance from the specified parameters.
    ///
    /// - Parameters:
    ///   - data: a Data object.
    /// - returns: The new `Model` instance.
    init?(_ data: Data?)
    
    /// Creates a `Model` instance from the specified parameters.
    ///
    /// - Parameters:
    ///   - dictionary:  a Dictionary object.
    /// - returns: The new `Model` instance.
    init?(_ dictionary: [String: Any]?)
    
    /// Creates a `Model` instance from the specified parameters.
    ///
    /// - Parameters:
    ///  - json:  a String value with json format.
    ///  - encoding:  a type for String Encoding.
    /// - returns: The new `Model` instance.
    init?(_ json: String?, using encoding: String.Encoding)
    
    
    /// Creates a `Model` instance from the specified parameters.
    ///
    /// - Parameters:
    ///   - url:  a URL object for fetching the associated data
    /// - returns: The new `Model` instance.
    init?(_ url: URL?)
    
    /// Convert the Model into Key Value mapped Dictionary
    ///
    /// - returns: A `Dictionary` with String type Keys and Any type Values.
    func jsonDictionary() -> [String: Any]?
    
    /// Convert the Model into Data object
    ///
    /// - returns: A `Data` object
    func jsonData() -> Data?
    
    /// Convert the Model into Data object
    ///
    /// - Parameters:
    ///  - encoding:  a type for String Encoding.
    ///
    /// - returns: A `Data` object
    func jsonString(encoding: String.Encoding) -> String?
    
    /// Modifie the standerd JSONDecoder with custom support
    ///
    /// - returns: A `JSONDecoder`
    static func jsonDecoder() -> JSONDecoder
    
    /// Modifie the standerd JSONEncoder with custom support
    ///
    /// - returns: A `JSONEncoder`
    static func jsonEncoder() -> JSONEncoder
    
}

// MARK: -

public extension Model {
    
    init?(_ data: Data?) {
        guard let data = data,let _self = try? Self.jsonDecoder().decode(Self.self, from: data) else { return nil }
        self = _self
    }
    
    init?(_ dictionary: [String: Any]?){
        guard let dictionary = dictionary, let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else { return nil }
        self.init(data)
    }
    
    init?(_ json: String?, using encoding: String.Encoding = .utf8) {
       guard let json = json, let data = json.data(using: encoding) else {
          return nil
       }
       self.init(data)
    }
    
    init?(_ url: URL?){
        guard let url = url,let data = try?  Data(contentsOf: url) else { return nil }
        self.init(data)
    }
    
    
    func jsonDictionary() -> [String: Any]? {
          guard let data = try?  Self.jsonEncoder().encode(self) else { return nil }
          return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    func jsonData() -> Data? {
        guard let data = try? Self.jsonEncoder().encode(self) else { return nil }
        return data
    }

    func jsonString(encoding: String.Encoding = .utf8) -> String? {
        guard let data = self.jsonData() else { return nil }
        return String(data: data, encoding: encoding)
    }
    
    static func jsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    static func jsonEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
    
}

