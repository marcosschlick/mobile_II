# Programação Mobile 2 — Material das Aulas (TADS)

Repositório com o código e exemplos usados nas aulas da disciplina **Programação Mobile 2** (TADS — Tecnólogo em Análise e Desenvolvimento de Sistemas). Cada aula fica em um arquivo e pode ser acessada pelo menu do app. O repositório é atualizado após cada aula, então vocês podem usar como referência e acompanhar o que já foi dado.

---

## Do que se trata

- App Flutter com um **menu inicial** onde cada item abre uma tela correspondente a uma aula.
- Em cada tela tem o conteúdo daquele dia (ex.: contador, acessibilidade, etc.) com comentários no código para estudo.
- Na aula de **Acessibilidade** há um botão no AppBar (ícone de acessibilidade) que liga/desliga o "Raio-X" de semântica (`showSemanticsDebugger`) para visualizar o que o leitor de tela enxerga.

---

## Pré-requisitos

- [Flutter](https://docs.flutter.dev/get-started/install) instalado e configurado (com `flutter doctor` ok).
- Opcional: Android Studio / Xcode para emulador, ou Chrome para rodar na web.

---

## Como instalar e rodar

### 1. Clonar o repositório

```bash
git clone https://github.com/MatheusLFialho/mobile2_aulas.git
cd mobile2_aulas
```

### 2. Instalar dependências

```bash
flutter pub get
```

### 3. Rodar o app

- **No dispositivo/emulador padrão:**
  ```bash
  flutter run
  ```

- **No Chrome (web):**
  ```bash
  flutter run -d chrome
  ```

- **No Windows (desktop):**
  ```bash
  flutter run -d windows
  ```

Ao abrir o app, a primeira tela é o **Menu de Aulas**. Toque em um item para abrir a aula correspondente; use o botão voltar (ou seta no AppBar) para voltar ao menu.

---

## Estrutura do projeto (MVVM)

O projeto segue **MVVM** com pastas didáticas dentro de `lib/`: **view/** (telas), **viewmodel/** (estado e lógica), **model/** (dados/entidades, por enquanto vazia).

| Pasta / arquivo | Descrição |
|-----------------|-----------|
| `lib/main.dart` | Ponto de entrada do app. |
| `lib/view/` | **Views** — telas (UI): `app_view.dart`, `menu_page.dart`, `aula1_contador_page.dart`, `aula_acessibilidade_page.dart`. |
| `lib/viewmodel/` | **ViewModels** — estado e lógica: `app_view_model.dart`, `aula1_contador_view_model.dart`, `aula_acessibilidade_view_model.dart`. |
| `lib/model/` | **Models** — entidades e dados (ex.: usuário, perfil). Por enquanto só tem um README explicando; usamos quando houver API/banco. |
| *(novas aulas)* | Adicionar `*_page.dart` em `view/`, `*_view_model.dart` em `viewmodel/`, e um item no menu em `view/menu_page.dart`. |

*(O nome do pacote no `pubspec.yaml` é `mobile2_aulas`.)*

---

## Observação

O conteúdo é commitado **depois** de ser dado em sala, para manter o repositório alinhado com o que foi efetivamente trabalhado nas aulas. Se precisarem do código de uma aula que ainda não apareceu no menu, é porque ela ainda não foi ministrada (e será adicionada em seguida).

---

## Dúvidas

Em caso de dúvidas sobre a disciplina ou o código, falem comigo em sala ou pelo canal combinado no curso.
