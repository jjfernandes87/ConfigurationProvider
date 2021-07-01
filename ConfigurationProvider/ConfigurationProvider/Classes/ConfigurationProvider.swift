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

public class ConfigurationProvider: NSObject {
    
    public static var instance: ConfigurationProvider!
    
    var configurations: NSDictionary?
    var schemeName: String?
    
    //MARK: - Public Methods
    
    /// Singleton ConfigurationProvider
    /// Incia a classe e acessa as configurações do Configuration.plist
    ///
    /// - Returns: retorna a classe ConfigurationProvider
    public class func shared(bundle: Bundle = .main) -> ConfigurationProvider {
        self.instance = (self.instance ?? ConfigurationProvider())
        
        if (self.instance.configurations == nil) {
            _ = self.instance.getConfigurations(for: bundle)
        }
        
        return self.instance
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
