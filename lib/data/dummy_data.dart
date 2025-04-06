import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/notifiers.dart';

void loadDummy() {
  List a = [
    [
      'Lista de Compras',
      '- mamão \n- banana \n- ovos \n- presunto \n- pizza \n- doritos',
    ],
    [
      'Livros',
      """A mandíbula de Caim
Moby Dick
20 Mil Léguas Submarinas
A Arte da Guerra
Pequeno Príncipe
Ilíada/Odisseia
A Revolução dos Bichos
A Culpa é das Estrelas
Magnus Chase
O Diário de Hass
Elektra
O Segredo de Luísa
Justiça
Criação - Gore Vidal
O Andar do Bêbado
Algorithms to Live By
King Warrior Magician Lover
Endurance: A Year in Space
Código Limpo""",
    ],
    [
      'Frases',
      '''"Aquele que luta com monstros deve ter cuidado para não se tornar um monstro - E se você olhar por muito tempo para um abismo, o abismo também olha para dentro de você."
-Nietzsche, Friedrich

"O homem está condenado a ser livre - porque, uma vez lançado ao mundo, ele é responsável por tudo o que faz."
-Sartre, Jean-Paul

"Vivemos em um mundo onde temos que nos esconder para fazer amor - enquanto a violência é praticada em plena luz do dia."
-Lennon, John

"Todo o conhecimento humano começou com intuições - passou daí aos conceitos e terminou com ideias."
-Kant, Immanuel

"O maior castigo para aqueles que não se interessam por política é que serão governados pelos que se interessam."
-Arnold, Nicholas Murray

"Se queres prever o futuro - estuda o passado."
-Confúcio''',
    ],
  ];
  final _myBox = Hive.box('mybox');
  a.forEach((i) {
    _myBox.put(a.indexOf(i), a[a.indexOf(i)]);
  });
  notesLenght.value = _myBox.length;
  print(_myBox.toMap());
}
