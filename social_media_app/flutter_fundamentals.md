# Widgets

Tudo no fluitter é baseado em widgest quando se referimos a UI e interface.
Cada um desses widgets podem ser encadeados um dentro do outro recebendo o contexto de seus pais respectivos como parâmetros. **Funciona com base em composição em vez de herança**.

## Widgets State
Os Widgets de layout não possuem uma representação visual por si só, são responsáveis por controlar aspectos de outros widgets de layout.
Ex: **Padding, Aligmnet, Row, Column and?... Grid**

Para criar uma interface no Flutter devemos sobescrever o método **build** dos widgets (herdando de um widget com ou sem estado) e retornar um novo Widget.

O framework **chama** o método build quando o widget é **criado** e quando **dependências do widget mudam** (a exempolo os estados)

- Widgets são imutáveis; a descrição da UI não muda.
- Em StatefulWidget, quem muda é o `State` (guarda dados e faz `build`).
- Mudou algo? Chame `setState` para reconstruir só o subtree.
- O `State` persiste entre rebuilds; perde se mudar tipo ou `key`.

# Layouts
O Layout em flutter nada mais é do que a composição de determinados widgets em um tamanho e posição específico para o comprimento de determinada responsabilidade (assim como na Web)

## Constraints

> Constraints go down. Sizes go up. Parent sets position.

O widget pai que define as regras do filho, o filho pode obedecer ou não, mas caso não obedeça irá seguir as limitações do widget pai

```dart
Center( // O Pai
  child: Container( // O Filho
    width: 1000, 
    height: 1000,
    color: Colors.red,
  ),
)
```
1. **Tela para o Center:** "Você tem o tamanho da tela inteira (ex: 400x800)."
2. **Center para o Container:** "Você pode ter de 0 até 400 de largura e 0 até 800 de altura."
3. **Container tenta ser rebelde:** "Eu quero ter 1000x1000!"
4. **A Regra vence:** O Container é forçado a caber nos limites. Ele acaba ficando com 400x800.
5. **Center define a posição:** Como o Container agora ocupa tudo, o Center o posiciona preenchendo o espaço.

# Box Types
Os widgets são desenhados em tamanhos variados.
**Center** e **ListView** tentam ocupar o máximo de espaço
**Transform** e **Opacity** tentam ser do mesmo tamanho dos filhos
**Image** e **Text** têm tamanhos específicos

Todos os Widgets de Layout possuem propriedades como
**Child** - `Center`, `Container`, ou `Padding`
**Children** - `Row`, `Column`, `ListView`, ou `Stack`

Posso colocar Widgets dentro de `Containers` para conseguir manipular questões como posicionamento e dimensionamento. Como o caso de um padding

```dart
Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16.0),
    child: BorderedImage(),
  );
}
```

## Alinhamento e tamanho
You control how a row or column aligns its children using the `mainAxisAlignment` and `crossAxisAlignment` properties. For a row, the main axis runs horizontally and the cross axis runs vertically. For a column, the main axis runs vertically and the cross axis runs horizontally.

```dart
Widget build(BuildContext context) {
  return const Row(
    children: [
      Expanded(
        child: BorderedImage(width: 150, height: 150),
      ),
      Expanded(
        flex: 2,
        child: BorderedImage(width: 150, height: 150),
      ),
      Expanded(
        child: BorderedImage(width: 150, height: 150),
      ),
    ],
  );
}
```
Para quando os elementos ultrapassam a view Port e queremos que eles se adeque ao tamanho ou marcar elementos para se sobressair. Algo como o flex-grow...???

### ListView
O uso de um ListView dentro de um Column pode gerar um problema de **Unbounded Height**, caso o ListView não seja envolvido em Expanded or Flexable / SizeBox.

Geralmente usamos o construtor do ListView quando não sabemos a quantidade de itens que queremos exibir. **Lazy Loading**
```dart
final List<ToDo> items = Repository.fetchTodos();

Widget build(BuildContext context) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, idx) {
      var item = items[idx];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.description),
            Text(item.isComplete),
          ],
        ),
      );
    },
  );
}
```

Existem outros tipos de Builder principalmente o Layout Builder

# State Management

## StateFull Widgets
Usar StateFul Widgets quando queremos manter o estado dentro do própio Widget.


## Construtores
Construtores(Prop Drilling), forma mais direta de compartilhar dados passando as informações como um parâmetro no momento em que cria o widget filho.

Ex: Widget de Perfil que apenas exibe o nome que recebe

```dart
// O FILHO: Recebe o dado via construtor
class UserBadge extends StatelessWidget {
  final String userName; // O dado que será compartilhado
  
  const UserBadge({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(userName));
  }
}

// O PAI: Possui a informação e a repassa
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = "Carlos Silva"; // Estado que queremos compartilhar
    
    return Scaffold(
      body: Center(
        child: UserBadge(userName: name), // Passando via construtor
      ),
    );
  }
}
```
## Calbacks
A ideia é que o filho avise ao pai que algo mudou, para que o pai atualize o estado.

```dart
// O FILHO: Define um 'onTap' customizado
class CustomButton extends StatelessWidget {
  final VoidCallback onAction; // O "contrato" de aviso

  const CustomButton({super.key, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onAction, child: const Text("Clique aqui"));
  }
}

// O PAI: Implementa a função que será executada
class CounterScreen extends StatefulWidget {
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Total: $_counter"),
        CustomButton(onAction: () {
          setState(() => _counter++); // O pai decide o que fazer com o clique
        }),
      ],
    );
  }
}
```

## InheritedWidget (Provedor de Dados)
Permite que os dados exisam e sejam passados para os descendentes sem precisar usar um construtor. 

Algo como:
- Dados Globais da Aplicação
- Evitar Pop Drilling: Onde existe uma cadeia muito grande de passagem de estado de um construtor para isso
- Apenas notifica os Widgets que realmente estão 

```dart
// 1. Criamos a classe que herda de InheritedWidget
class AppColorTheme extends InheritedWidget {
  final Color primaryColor;

  const AppColorTheme({
    super.key,
    required this.primaryColor,
    required super.child,
  });

  // Método estático para os filhos buscarem a instância
  static AppColorTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppColorTheme>()!;
  }

  @override
  // Se a cor mudar, os filhos que usam a cor devem reconstruir
  bool updateShouldNotify(AppColorTheme oldWidget) => primaryColor != oldWidget.primaryColor;
}

// 2. Onde usar (Widget lá no fundo da árvore)
class DeepChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Buscamos a cor diretamente do "contexto" sem passar por construtor
    final theme = AppColorTheme.of(context);
    
    return Container(
      color: theme.primaryColor,
      child: const Text("Estou usando a cor do InheritedWidget"),
    );
  }
}
```

## Callbacks
Servem para o filho avisar o pai que algo aconteceu ou que o dado mudou

Ex: Botão que não deve saber como salvar um dado no banco, ele apenas avisa que foi clicado.

**Filho que emite o aviso**
```dart
class SeletorDeQuantidade extends StatefulWidget {
  // ValueChanged<int> é o mesmo que: void Function(int)
  final ValueChanged<int> aoMudar; 

  const SeletorDeQuantidade({super.key, required this.aoMudar});

  @override
  State<SeletorDeQuantidade> createState() => _SeletorDeQuantidadeState();
}

class _SeletorDeQuantidadeState extends State<SeletorDeQuantidade> {
  int _quantidade = 0;

  void _incrementar() {
    setState(() {
      _quantidade++;
    });
    // Aqui executamos a função que o pai nos passou!
    widget.aoMudar(_quantidade); 
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _incrementar,
      child: Text('Adicionar: $_quantidade'),
    );
  } 
}
```

**Pai que recebe o callback e decide o que fazer com a informação**
```dart
class TelaPedido extends StatefulWidget {
  @override
  State<TelaPedido> createState() => _TelaPedidoState();
}

class _TelaPedidoState extends State<TelaPedido> {
  int _totalItens = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Total no Carrinho: $_totalItens'),
        // Passamos uma função anônima para o parâmetro 'aoMudar'
        SeletorDeQuantidade(
          aoMudar: (novoValor) {
            setState(() {
              _totalItens = novoValor; // O pai reage e se atualiza
            });
          },
        ),
      ],
    );
  }
}
```

## Listeners
Change Notifier construção mais complexa sobre um detrerminado estado e temos o ValueNotifier onde criamos um estado de um valor e podemos manipular dentro do própio Widget. - Seria algo semelhante ao ref e outros estados como no Vue

# MVVM
## Model
É onde ficam os dados e comunicações externas(APIs, Banco de Dados)

O model não sabe que o Fluuter existe, ele apenas gerencia os dados e comunicação externa

## ViewModel
Cérebro da tela é onde os dados do MOdel são moldados em algo que possam ser exibidos na tela.
- Formata Strings, **gerencia o estado**, controla se algo está ou não em loading e chama as funções do Model.
- Como comunica: Exemplo de uso do Change Notifier

## View 
É oq o usuário ver, em outras palavras os widgets

## Caso de uso
Passo 1: O Model
```dart

class ClimaModel {
  // Simula uma chamada de API
  Future<double> buscarTemperatura(String cidade) async {
    await Future.delayed(Duration(seconds: 2)); // Simula delay
    if (cidade == "Erro") throw Exception("Cidade não encontrada");
    return 25.5;
  }
}
```

Passo 2: O ViewModel
Aqui usamos o ChangeNotifier para que a View possa "escutar".

```dart

import 'package:flutter/material.dart';

class ClimaViewModel extends ChangeNotifier {
  final ClimaModel _model = ClimaModel();

  double? temperatura;
  bool carregando = false;
  String? erro;

  Future<void> atualizarClima(String cidade) async {
    carregando = true;
    erro = null;
    notifyListeners(); // Avisa a View para mostrar o Spinner de carregamento

    try {
      temperatura = await _model.buscarTemperatura(cidade);
    } catch (e) {
      erro = "Não foi possível carregar o clima.";
    } finally {
      carregando = false;
      notifyListeners(); // Avisa a View para mostrar o resultado ou erro
    }
  }
}
```

Passo 3: A View
Usamos o ListenableBuilder para reconstruir a tela apenas quando o ViewModel mandar.

```dart

class ClimaView extends StatelessWidget {
  final ClimaViewModel viewModel = ClimaViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, child) {
            if (viewModel.carregando) return CircularProgressIndicator();
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (viewModel.erro != null) Text(viewModel.erro!, style: TextStyle(color: Colors.red)),
                Text("Temperatura: ${viewModel.temperatura ?? '--'}°C"),
                ElevatedButton(
                  onPressed: () => viewModel.atualizarClima("São Paulo"),
                  child: Text("Consultar Clima"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
```