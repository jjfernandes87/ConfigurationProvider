//
//  ConfigurationProvider+Bundle.swift
//  
//
//  Created by Renan Dias on 30/06/21.
//

import Foundation

// MARK: - Multi Bundle Support
public extension ConfigurationProvider {
    /// Acessa as variáveis do Configuration.plist no Bundle correspondente.
    ///
    /// - Parameter tag: chave do Configuration.plist
    /// - Parameter bundle: Bundle a buscar o Configuration.plist
    /// - Returns: valor da chave buscada
    func getBy<T>(tag: String, bundle: Bundle) -> T? {
        let configuration = getConfigurations(for: bundle)
        guard let value: T = configuration?.getBy(path: tag) else {
            abortFor(reason: .tagNotFound, details: "Tag not found: \(tag)")
            return nil
        }
        return value
    }
}

private extension ConfigurationProvider {
    /// Abre e retorna o Configuration.plist para acessar as informações internas de acordo com o Schema.
    /// - Parameter bundle: Bundle a acessar as informações internas.
    /// - Returns: Um dicionário com as informações do Configuration.plist.
    func getConfigurations(for bundle: Bundle) -> NSDictionary? {
        guard let data = openConfigurationPlist(with: bundle) else {
            abortFor(reason: .unableToLoad, details: "Configuration.plist not found!")
            return nil
        }
        
        if let info = Bundle.main.infoDictionary, let scheme = info["Scheme"] as? String {
            if let schemeConfigurations = data.object(forKey: scheme.replacingOccurrences(of: "\"", with: "")) as? NSDictionary {
                return schemeConfigurations
            }  else {
                abortFor(reason: .levelNotFound, details: "Scheme level not found: \(schemeName ?? "not scheme")")
            }
        }
        return nil
    }
    
    /// Abre o arquivo Configuration.plist e retorna suas informações desse arquivo,
    /// - Parameter bundle: Bundle onde se encontra o Configuration.plist a ser usado.
    /// - Returns: Retorna um dicionário do Configuration.plist
    func openConfigurationPlist(with bundle: Bundle) -> NSDictionary? {
        var allData: NSDictionary? = nil
        if let path = bundle.path(forResource: "Configuration", ofType: "plist") {
            let fileURL = URL(fileURLWithPath: path, isDirectory: false)
            allData = NSDictionary(contentsOf: fileURL)
        }
        return allData
    }
}
