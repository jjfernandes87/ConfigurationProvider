//
//  URLConfigurationProvider.swift
//  ConfigurationProvider
//
//  Created by Julio on 04/12/17.
//

import UIKit

enum URLConfigurationProviderAbortReason: Int {
    case unknown
    case unableToLoad
    case invalidURL
    case tagNotFound
    case levelNotFound
    case domainNotFound
}

public class URLConfigurationProvider {
    /// Singleton URLConfigurationProvider
    private static var instance = URLConfigurationProvider()
    
    /// Singleton URLConfigurationProvider
    ///
    /// - Returns: retorna a classe URLConfigurationProvider
    public class func shared() -> URLConfigurationProvider {
        instance
    }
    
    // Private initializer to enforce Singleton pattern
    private init() { }
}

//MARK: - Public Methods
public extension URLConfigurationProvider {
    /// Busca pela URL no arquivo de Configuration.plist
    ///
    /// - Parameters:
    ///   - tag: chave no arquivo de configuração
    ///   - replacements: parametros para ser substituido na URL original
    ///   - hasDomain: caso exista a chave domain
    /// - Returns: retorna a URL
    class func urlBy(
        tag: String,
        replacements: NSDictionary? = nil,
        hasDomain: Bool = false,
        bundle: Bundle = .main
    ) -> URL? {
        if let url = urlStringBy(tag: tag, replacements: replacements, hasDomain: hasDomain, bundle: bundle) {
            return URL(string: url)
        }
        
        return nil
    }
    
    /// Busca pela URL (String) no arquivo de Configuration.plist
    ///
    /// - Parameters:
    ///   - tag: chave no arquivo de configuração
    ///   - replacements: parametros para ser substituido na URL original
    ///   - hasDomain: caso exista a chave domain
    /// - Returns: retorna a URL (String)
    class func urlStringBy(
        tag: String,
        replacements: NSDictionary? = nil,
        hasDomain: Bool = false,
        bundle: Bundle = .main
    ) -> String? {
        return URLConfigurationProvider.instance.urlStringBy(tag: tag, replacements: replacements, hasDomain: hasDomain, bundle: bundle)
    }
}

//MARK: - Private Methods
private extension URLConfigurationProvider {
    /// Busca pela URL (String) no arquivo de Configuration.plist
    ///
    /// - Parameters:
    ///   - tag: chave no arquivo de configuração
    ///   - replacements: parametros para ser substituido na URL original
    /// - Returns: retorna a URL (String)
    func urlStringBy(
        tag: String,
        replacements: NSDictionary?,
        hasDomain: Bool,
        bundle: Bundle = .main
    ) -> String? {
        
        guard let endpoints: NSDictionary = ConfigurationProvider.getBy(tag: "endpoints", bundle: bundle) else {
            abortFor(reason: .tagNotFound, details: "Tag not found: \(tag)")
            return nil
        }
        
        guard var urlString: String = endpoints.getBy(path: tag) else {
            abortFor(reason: .tagNotFound, details: "Tag not found: \(tag)")
            return nil
        }
        
        if hasDomain {
            guard let domain: String = ConfigurationProvider.getBy(tag: "domain", bundle: bundle) else {
                abortFor(reason: .domainNotFound, details: "Domain not found")
                return nil
            }
            
            urlString = String(format: "%@%@", domain, urlString)
        }
        
        if let keys = replacements?.allKeys {
            for key in keys {
                let pathKey = "{\(key)}"
                let pathValue = replacements?.object(forKey: key) as! String
                urlString = urlString.replacingOccurrences(of: pathKey, with: pathValue)
            }
        }
            
        urlString = urlString.replacingOccurrences(of: "${bundle}", with: bundle.bundleURL.absoluteString)
        
        guard let url = NSURL(string: urlString) else {
            abortFor(reason: .invalidURL, details: "Unable to convert URL: \(urlString)")
            return nil
        }
        
        return url.absoluteString
    }
    
    /// Cria a excessão e informa o erro ocorrido
    ///
    /// - Parameters:
    ///   - reason: Tipo de excessão que será lançado
    ///   - details: mensagem de erro para ajudar o desenvolvedor a analisar o erro
    func abortFor(reason: URLConfigurationProviderAbortReason, details: String) -> Void {
        let exceptionName: NSExceptionName!
        switch (reason) {
        case .unableToLoad:     exceptionName = NSExceptionName(rawValue: "URLConfigurationProvider Error: Unable To Load")
        case .levelNotFound:    exceptionName = NSExceptionName(rawValue: "URLConfigurationProvider Error: Level Not Found")
        case .tagNotFound:      exceptionName = NSExceptionName(rawValue: "URLConfigurationProvider Error: Tag Not Found")
        case .invalidURL:       exceptionName = NSExceptionName(rawValue: "URLConfigurationProvider Error: Invalid URL")
        case .domainNotFound:   exceptionName = NSExceptionName(rawValue: "URLConfigurationProvider Error: Invalid Domain")
        default:                exceptionName = NSExceptionName(rawValue: "ConfigurationProvider Error: Unknown error")
        }
        NSException(name: exceptionName, reason: details, userInfo: nil).raise()
    }
}
