# PET Mobile

## Boas práticas gerais
- [Convenções de nomeação](https://medium.com/nonstopio/flutter-best-practices-c3db1c3cd694)
- [Estrutura dos arquivos](https://medium.com/flutter-community/flutter-scalable-folder-files-structure-8f860faafebd)

## Organização dos diretórios

- ### config
    Configurações gerais do app.
- ### config/theme
    Temas.
- ### l10n (localization)
    Todos os textos do app e futuramente suas traduções.
- ### pages
    Telas do app.
- ### app_widget.dart
    Widget principal do app. Aqui configuramos tema, i18n e rotas.
- ### main.dart
    Raiz do app.
- ### l10n.yaml
    Configurações para internacionalização.

## Widgets

- ### DropDown
    Card com botão lateral que mostra algum conteúdo.

- ### SideMenuScaffold
    Extenção do Scaffold padrão que já vem com o menu lateral.