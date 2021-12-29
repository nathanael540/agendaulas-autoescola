import 'package:flutter/material.dart';
import 'gtext_widget.dart';

class QuoteDay extends StatefulWidget {
  const QuoteDay({Key? key}) : super(key: key);

  @override
  _QuoteDayState createState() => _QuoteDayState();
}

class _QuoteDayState extends State<QuoteDay> {
  getQuote() {
    List<Map> quotes = [
      {
        "text":
            "Pra quem tem pensamento forte o impossível é só questão de opinião.",
        "author": "Chorão",
      },
      {
        "text":
            "O que os outros pensam de nós teria pouca importância se não influenciasse tão profundamente o que pensamos de nós mesmos.",
        "author": "George Santayana",
      },
      {
        "text":
            "Quando tudo parece dar errado acontecem coisas boas que não teriam acontecido se tudo tivesse dado certo.",
        "author": "Renato Russo",
      },
      {
        "text":
            "Impossível é uma palavra muito grande, que pessoas pequenas usam para te oprimir!",
        "author": "Chorão",
      },
      {
        "text": "O bravo não é quem não sente medo, mas quem vence esse medo!",
        "author": "Nelson Mandela",
      },
      {
        "text":
            "Ninguém é digno do paraíso se não aprender a atravessar o deserto.",
        "author": "Augusto Cury",
      },
      {
        "text":
            "O importante não é vencer todos os dias, mas sim lutar sempre!",
        "author": "Santo Agostinho",
      },
      {
        "text":
            "A maior parte da nossa felicidade depende da nossa atitude e não das circunstâncias!",
        "author": "Martha Washington",
      },
      {
        "text":
            "O que os outros pensam de nós teria pouca importância se não influenciasse tão profundamente o que pensamos de nós mesmos.",
        "author": "George Santayana",
      },
      {
        "text": "Tudo vale a pena se a alma não é pequena.",
        "author": "Fernando Pessoa",
      },
      {
        "text":
            "Nossa maior glória não está na ausência de fracassos, mas no fato de nos erguemos sempre que fracassamos.",
        "author": "Confúcio",
      },
      {
        "text": "O caminho que sobe e o que desce é o mesmo.",
        "author": "Heráclito",
      },
      {
        "text":
            "Os homens fariam maiores coisas se não julgassem tantas coisas impossiveis.",
        "author": "Malesherbes",
      },
      {
        "text": "Você deve ser a própria mudança que deseja ver no mundo.",
        "author": "Gandhi",
      },
      {
        "text":
            "O mundo pertence aos otimistas: os pessimistas são meros espectadores.",
        "author": "Dwight David Eisenhower",
      },
      {
        "text":
            "Pedras no caminho? Guardo todas, um dia vou construir um castelo...",
        "author": "Fernando Pessoa",
      },
      {
        "text":
            "As vontades fracas traduzem-se em discursos, as vontades fortes, em ações.",
        "author": "Gustave Le Bon",
      },
      {
        "text":
            "É necessário ter feito muito para compreender que não se fez o bastante.",
        "author": "Raul Follereau",
      },
      {
        "text":
            "O segredo do sucesso consiste em 10 por cento de inspiração e 90 por cento de transpiração.",
        "author": "Benjamin Franklin",
      },
      {
        "text": "O fracasso é a experiência que precede ao triunfo.",
        "author": "Gandhi",
      },
      {
        "text":
            "O primeiro passo é o mais importante porque é nele que você descobre que esta em pé.",
        "author": "Adolfo Perez Esquivel",
      },
      {
        "text":
            "O sucesso é a soma de pequenos esforços - repetidos dia sim, e no outro dia também.",
        "author": "Robert Collier",
      },
      {
        "text":
            "Sucesso é uma questão de não desistir e fracassar é uma questão de desistir cedo demais.",
        "author": "Walter Burke",
      },
      {
        "text":
            "Não se desanime nem se atemorize com a adversidade, pois ela existe apenas para ser vencida, aprimorada e aperfeiçoada.",
        "author": "Ivan Teorilang",
      },
      {
        "text": "A vitória mais bela que se pode alcançar é vencer a si mesmo.",
        "author": "Santo Inácio de Loyola",
      },
      {
        "text": "O único homem que jamais erra é aquele que nunca faz nada.",
        "author": "Eleanor Roosevelt",
      },
      {
        "text":
            "O otimismo é a fé em ação. Nada se pode levar a efeito sem otimismo.",
        "author": "Helen Keller",
      },
      {
        "text": "O fracasso não será fracasso, se dele tirarmos uma lição!",
        "author": "Ronald Niednagel",
      },
      {
        "text": "A paciência é a melhor maneira de vencer.",
        "author": "Antônio de Pádua",
      },
      {
        "text":
            "O covarde nunca tenta, o fracassado nunca termina e o vencedor nunca desiste!",
        "author": "Norman Vincent Peale",
      },
      {
        "text":
            "Você não tem nenhum limite a não ser aqueles que você mesmo se colocou ou aceitou que te fossem impostos.",
        "author": "Martin Brofman",
      },
      {
        "text":
            "Só aqueles que têm paciência para fazer coisas simples com perfeição é que irão adquirir habilidade para fazer coisas difíceis com facilidade.",
        "author": "Schiller",
      },
    ];
    int today = DateTime.now().day;
    return quotes[today];
  }

  @override
  Widget build(BuildContext context) {
    Map quote = getQuote();

    return Wrap(
      children: [
        GText(
          "“${quote['text']}”",
          color: Colors.white,
          fontSize: 15,
          italic: FontStyle.italic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GText(
              " - ${quote['author']}",
              color: Colors.white,
              fontSize: 13,
              italic: FontStyle.italic,
            ),
          ],
        ),
      ],
    );
  }
}
