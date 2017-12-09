# ConfigurationProvider

ConfigurationProvider é uma biblioteca para centralizar configurações do seu app escrita em Swift.

[![CI Status](http://img.shields.io/travis/jjfernandes87/ConfigurationProvider.svg?style=flat)](https://travis-ci.org/jjfernandes87/ConfigurationProvider)
[![Version](https://img.shields.io/cocoapods/v/ConfigurationProvider.svg?style=flat)](http://cocoapods.org/pods/ConfigurationProvider)
[![License](https://img.shields.io/cocoapods/l/ConfigurationProvider.svg?style=flat)](http://cocoapods.org/pods/ConfigurationProvider)
[![Platform](https://img.shields.io/cocoapods/p/ConfigurationProvider.svg?style=flat)](http://cocoapods.org/pods/ConfigurationProvider)

## Features

- [x] Arquivo plist para agrupar as configurações do seu app (Configuration.plist)
- [x] Método getBy<T>(tag: String) para acessar as variáveis do plist
- [x] Criação de schemes (desenv, homol, release)
- [x] Opção de agrupar endpoints, dominios e headers http 
- [x] Buscar por endpoints com retorno URL
- [x] Buscar por endpoints com retorno String
- [x] Opção de buscar por endpoints e passar paremetros para substituição no endPoint ["id", "seu_id"] => /ficha/[id] = /ficha/[seu_id] 
- [x] NSException para informar erros de tag, level ou invalid url
- [x] Cobertura de testes de integração

## Requirements

- iOS 9.3+
- Xcode 9.0+
- Swift 4.0+

## Communication

- Se você **encontrou um bug**, abra uma issue.
- Se você **tem uma nova feature**, abra uma issue.
- Se você **quer contribuir**, envie uma pull request.

## Example

Para rodar o projeto de exemplo, clone o repositório, e rode o comando `pod install` no diretório Example primeiro.

## Installation

ConfigurationProvider esta disponível através [CocoaPods](http://cocoapods.org). Para instalar, basta adicionar a linha abaixo no seu Podfile:

```ruby
pod 'ConfigurationProvider', :git => 'https://github.com/jjfernandes87/ConfigurationProvider.git'
```

Então você precisa criar um arquivo plist chamado Configuration

```ruby
Configuration.plist
```

O Configuration.plist é do tipo Dictionary e você precisa criar as chaves de configurações do seu app

```swift
['Root']: [
	['debug']: ['your settings'],
	['release']: ['your settings']
]
```

Depois de criar e configurar seu Configuration.plist, você precisa adicionar uma chave no arquivo info.plist app, called Scheme

```swift
Scheme = 'debug'
```

## Author

jjfernandes87, julio.fernandes87@gmail.com

## License

ConfigurationProvider is available under the MIT license. See the LICENSE file for more info.
