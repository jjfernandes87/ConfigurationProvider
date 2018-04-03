//
//  URLConfigurationProvider_Tests.swift
//  ConfigurationProvider_Tests
//
//  Created by Julio on 04/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import ConfigurationProvider

class URLConfigurationProvider_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// Testando busca de URL com retorno String
    func testURLConfigurationProviderByString() {
        let value: String = URLConfigurationProvider.urlStringBy(tag: "busca")!
        XCTAssertEqual(value, "http://busca.com")
    }
    
    /// Testando busca de URL com retorno URL
    func testURLConfigurationProviderByURL() {
        let value: URL = URLConfigurationProvider.urlBy(tag: "busca")!
        XCTAssertEqual(value, URL(string: "http://busca.com")!)
    }
    
    /// Testando busca de URL com parametros para serem alterados no endpoint e com retorno String
    func testURLConfigurationProviderByStringWithReplecement() {
        let value: String = URLConfigurationProvider.urlStringBy(tag: "detalhe", replacements: ["id": "12345"])!
        XCTAssertEqual(value, "http://detalhe/12345/")
    }
    
    /// Testando busca de URL com parametros para serem alterados no endpoint e com retorno URL
    func testURLConfigurationProviderByURLWithReplecement() {
        let value: URL = URLConfigurationProvider.urlBy(tag: "detalhe", replacements: ["id": "12345"])!
        XCTAssertEqual(value, URL(string: "http://detalhe/12345/")!)
    }
    
    /// Testando busca de url com domain
    func testURLConfigurationProviderByURLWithDomain() {
        let value: URL = URLConfigurationProvider.urlBy(tag: "hasDomain", hasDomain: true)!
        XCTAssertEqual(value, URL(string: "http://domain.com.br/domain")!)
    }
    
    /// Testando busca de url com domain
    func testURLConfigurationProviderByStringWithDomain() {
        let value: String = URLConfigurationProvider.urlStringBy(tag: "hasDomain", hasDomain: true)!
        XCTAssertEqual(value, "http://domain.com.br/domain")
    }
    
}
