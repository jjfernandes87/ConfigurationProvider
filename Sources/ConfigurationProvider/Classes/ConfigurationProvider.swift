//
//  ConfigurationProvider.swift
//  ConfigurationProvider
//
//  Created by Julio Fernandes on 03/12/17.
//

import UIKit

enum ConfigurationProviderAbortReason : Int {
    case unknown
    case unableToLoad
    case levelNotFound
    case tagNotFound
}

public protocol ConfigurationProviderProtocol {
    func getBy<T>(tag: String) -> T?
}

public class ConfigurationProvider: NSObject, ConfigurationProviderProtocol {
    
    public static var instance: ConfigurationProvider!
    
    var configurations: NSDictionary?
    var schemeName: String?
    
    //MARK: - Public Methods
    
    /// Singleton ConfigurationProvider
    /// Incia a classe e acessa as configurações do Configuration.plist
    ///
    /// - Returns: retorna a classe ConfigurationProvider
    public class func shared() -> ConfigurationProvider {
        self.instance = (self.instance ?? ConfigurationProvider())
        
        if (self.instance.configurations == nil) {
            self.instance.getConfigurations()
        }
        
        return self.instance
    }
    
    /// Acessa as variáveis do Configuration.plist
    ///
    /// - Parameter tag: chave do Configuration.plist
    /// - Returns: valor da chave buscada
    public func getBy<T>(tag: String) -> T? {
        
        /// Realiza a busca pela chave
        guard let value: T = configurations?.getBy(path: tag) else {
            abortFor(reason: .tagNotFound, details: "Tag not found: \(tag)")
            return nil
        }
        
        return value
    }
    
    /// Cria a excessão e informa o erro ocorrido
    ///
    /// - Parameters:
    ///   - reason: Tipo de excessão que será lançado
    ///   - details: mensagem de erro para ajudar o desenvolvedor a analisar o erro
    func abortFor(reason: ConfigurationProviderAbortReason, details: String) -> Void {
        let exceptionName: NSExceptionName!
        switch (reason) {
        case .unableToLoad:     exceptionName = NSExceptionName(rawValue: "ConfigurationProvider Error: Unable To Load")
        case .levelNotFound:    exceptionName = NSExceptionName(rawValue: "ConfigurationProvider Error: Level Not Found")
        case .tagNotFound:      exceptionName = NSExceptionName(rawValue: "ConfigurationProvider Error: Tag Not Found")
        default:                exceptionName = NSExceptionName(rawValue: "ConfigurationProvider Error: Unknown error")
        }
        NSException(name: exceptionName, reason: details, userInfo: nil).raise()
    }
    
    //MARK: - Private Methods
    
    /// Abre o Configuration.plist para acessar as informações internas
    private func getConfigurations() {
        
        /// Valida se existe o arquivo de configuração do app
        guard let data = openConfigurationPlist() else {
            return abortFor(reason: .unableToLoad, details: "Configuration.plist not found!")
        }
        
        /// Acessa a variável Scheme no info.plist da aplicação para acessar as informações do Configuration.plist
        if let info = Bundle.main.infoDictionary, let scheme = info["Scheme"] as? String {
            if let schemeConfigurations = data.object(forKey: scheme.replacingOccurrences(of: "\"", with: "")) as? NSDictionary {
                configurations = schemeConfigurations
                schemeName = String(describing: scheme)
            }  else {
                abortFor(reason: .levelNotFound, details: "Scheme level not found: \(schemeName ?? "not scheme")")
            }
        }
        
    }
    
    /// Abre o arquivo Configuration e retorna suas informações
    ///
    /// - Returns: retorna os dados
    private func openConfigurationPlist() -> NSDictionary? {
        var allData: NSDictionary? = nil
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") {
            let fileURL = URL(fileURLWithPath: path, isDirectory: false)
            allData =  NSDictionary(contentsOf: fileURL)
        }
        return allData
    }
}

public extension NSDictionary {
    
    /// Acesso as chaves do NSDictionary
    ///
    /// - Parameter path: chave
    /// - Returns: valor
    func getBy<T>(path: String) -> T? {
        let firstPart = path.contains(".") ? String(path[..<path.range(of: ".")!.lowerBound]) : path
        let secondPart = path.contains(".") ? String(path[path.range(of: ".")!.upperBound...]) : ""
        if let dictionary = self.object(forKey: firstPart) as? NSDictionary, secondPart != "" {
            return dictionary.getBy(path: secondPart)
        } else {
            return self.object(forKey: firstPart) as? T
        }
    }
}
