# RedeMM

Aplicativo iOS para gerenciamento de itens, desenvolvido com SwiftUI e SwiftData.

## Visão Geral

O **RedeMM** é um app nativo para iPhone e iPad que permite criar, visualizar e organizar itens por categorias. Cada item possui título, descrição, categoria e data de criação. Os dados são persistidos localmente com SwiftData.

## Requisitos

| Ferramenta | Versão mínima |
|------------|--------------|
| Xcode      | 16.0+        |
| iOS / iPadOS | 18.5+      |
| Swift      | 5.0+         |

## Funcionalidades

- Listagem de itens com título, descrição, categoria e data
- Adição de novos itens via formulário
- Visualização detalhada de cada item
- Remoção de itens com deslize ou modo de edição
- Categorias disponíveis: **General**, **Work**, **Personal**, **Study**, **Health**, **Finance**, **Travel**, **Other**
- Persistência local com SwiftData
- Suporte a iPhone e iPad

## Como Rodar

1. Clone este repositório:
   ```bash
   git clone https://github.com/ChatAnalyopenai/RedeMM.git
   ```
2. Abra o arquivo `RedeMM.xcodeproj` no Xcode.
3. Selecione um simulador ou dispositivo com **iOS 18.5 ou superior**.
4. Pressione **⌘ + R** (ou clique em **Run**) para compilar e executar o app.

> **Nota:** Não há dependências externas. O projeto utiliza apenas frameworks nativos da Apple (SwiftUI e SwiftData).

## Estrutura do Projeto

```
RedeMM/
├── RedeMM.xcodeproj/       # Configurações do projeto Xcode
└── RedeMM/
    ├── RedeMMApp.swift     # Ponto de entrada do app e configuração do ModelContainer
    ├── ContentView.swift   # Telas principais: lista, detalhes e formulário de adição
    ├── Item.swift          # Modelo de dados SwiftData
    ├── Assets.xcassets/    # Recursos visuais (ícones, cores)
    ├── Info.plist          # Configurações do app
    └── RedeMM.entitlements # Permissões do app
```

## Roadmap

- [ ] Busca e filtro de itens por categoria
- [ ] Edição de itens existentes
- [ ] Ordenação customizada da lista
- [ ] Notificações locais
- [ ] Sincronização com iCloud

## Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do repositório.
2. Crie uma branch para sua feature: `git checkout -b feature/minha-feature`
3. Commit suas alterações: `git commit -m 'Adiciona minha feature'`
4. Faça push para a branch: `git push origin feature/minha-feature`
5. Abra um Pull Request contra `main`.

## Licença

Este projeto está disponível para uso pessoal e educacional. Consulte o repositório para informações sobre licenciamento.
