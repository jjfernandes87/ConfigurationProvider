//
//  ConfigurationProvider_Tests.swift
//  ConfigurationProvider_Tests
//
//  Created by Julio Fernandes on 03/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import ConfigurationProvider

class ConfigurationProvider_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// Testando a classe ConfigurationProvider
    func testConfigurationProviderClass() {
        let value: String = ConfigurationProvider.shared().getBy(tag: "name")!
        XCTAssertTrue(value == "Dev", "Testando a classe ConfigurationProvider")
    }
    
    /// Teste simples para acessar chave do dicionário
    func testSimpleGetMethod() {
        let json: NSDictionary = ["name": "ConfigurationProvider"]
        let value: String = json.getBy(path: "name")!
        XCTAssertTrue(value == "ConfigurationProvider", "Teste simples para acessar chave do dicionário")
    }
    
    /// Teste de acesso com chave composta para obter dados do dicionário
    func testCompositeGetMethod() {
        let json: NSDictionary = ["dev": ["name": "ConfigurationProvider"]]
        let value: String = json.getBy(path: "dev.name")!
        XCTAssertTrue(value == "ConfigurationProvider", "Teste de acesso com chave composta para obter dados do dicionário")
        
    }
    
    /// Teste de performace para chaves compostas
    func testPerformanceCompositeGetMethod() {
        let json: NSDictionary = ["dev": ["app": ["version": "0.0.3"]]]
        self.measure() {
            let value: String = json.getBy(path: "dev.app.version")!
            XCTAssertTrue(value == "0.0.3", "Teste de performace para chaves compostas")
        }
    }
    
    /// Teste de performace para chaves simples
    func testPerformanceSimpleGetMethod() {
        let json: NSDictionary = ["name": "ConfigurationProvider"]
        self.measure() {
            let value: String = json.getBy(path: "name")!
            XCTAssertTrue(value == "ConfigurationProvider", "Teste de performace para chaves simples")
        }
    }
}
