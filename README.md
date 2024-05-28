# Chuck Norris Jokes App

<img src="https://github.com/WaldsonFagundes/chucknorris_jokes/raw/main/assets/img.png" alt="Chuck Norris Jokes" width="400"/>


## Descrição

O Chuck Norris Jokes App é um aplicativo que permite buscar piadas de Chuck Norris de maneira divertida e fácil. Utilizando a [API Chuck Norris Jokes](https://api.chucknorris.io/), o aplicativo oferece funcionalidades para buscar piadas aleatórias, por pesquisa ou por categoria. Implementado com a Arquitetura Limpa e utilizando TDD (Test-Driven Development), este app garante um código robusto e manutenível.

## Funcionalidades

- **Piada Aleatória**: Obtenha uma piada aleatória do Chuck Norris com um simples toque.
- **Busca por Pesquisa**: Encontre piadas específicas digitando uma palavra-chave.
- **Busca por Categoria**: Selecione uma categoria e receba uma piada relacionada.

## Arquitetura

Este aplicativo foi desenvolvido seguindo os princípios da Arquitetura Limpa, garantindo uma separação clara das responsabilidades e facilitando a manutenção e evolução do código.

### Camadas da Arquitetura

- **Data**: Responsável pela implementação dos data sources e pelos modelos de dados.
- **Domain**: Contém as entidades, casos de uso e os repositórios.
- **Presentation**: Inclui a interface do usuário e os controladores.

## Tecnologias Utilizadas

- **Bloc (Ploc)**: Gerenciamento de estado.
- **Arquitetura Limpa**: Para um código modular e de fácil manutenção.
- **TDD (Test-Driven Development)**: Garantia de qualidade e robustez no desenvolvimento.

## Pacotes Utilizados

- [dartz](https://pub.dev/packages/dartz): ^0.10.1
- [equatable](https://pub.dev/packages/equatable): ^2.0.5
- [internet_connection_checker](https://pub.dev/packages/internet_connection_checker): ^1.0.0+1
- [shared_preferences](https://pub.dev/packages/shared_preferences): ^2.2.3
- [http](https://pub.dev/packages/http): ^1.1.0
- [bloc](https://pub.dev/packages/bloc): ^8.1.4
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): ^8.1.5
- [get_it](https://pub.dev/packages/get_it): ^7.6.7
- [mockito](https://pub.dev/packages/mockito): ^5.4.4
- [build_runner](https://pub.dev/packages/build_runner): ^2.4.9
- [faker](https://pub.dev/packages/faker): ^2.1.0
- [import_sorter](https://pub.dev/packages/import_sorter): ^4.6.0

## Como Executar o Projeto

1. **Clone o repositório**
   ```sh
   git clone https://github.com/WaldsonFagundes/chucknorris_jokes.git

2. **Instale as dependências**
   ```sh
   flutter pub get

3. **Execute o aplicativo**
    ```sh
    flutter run
    
### Testes
    
    flutter test

### Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.



Waldson fagundes
waldsonfagundes@gmail.com
