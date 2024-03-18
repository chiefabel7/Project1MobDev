import 'package:flutter/material.dart';

void main() {
  runApp(FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlashcardScreen(),
    );
  }
}

class FlashcardScreen extends StatefulWidget {
  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  Map<String, List<Flashcard>> flashcardDecks = {
    'Math': [],
    'History': [],
    'Science': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
      ),
      body: ListView(
        children: flashcardDecks.keys.map((deckName) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  deckName,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: flashcardDecks[deckName]!.length,
                itemBuilder: (context, index) {
                  return FlashcardWidget(
                    flashcard: flashcardDecks[deckName]![index],
                  );
                },
              ),
            ],
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addFlashcard();
        },
        tooltip: 'Add Flashcard',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addFlashcard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String question = '';
        String answer = '';
        String selectedDeck = flashcardDecks.keys.first;

        return AlertDialog(
          title: Text('Add Flashcard'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                DropdownButtonFormField(
                  value: selectedDeck,
                  onChanged: (value) {
                    selectedDeck = value.toString();
                  },
                  items: flashcardDecks.keys.map((deckName) {
                    return DropdownMenuItem(
                      value: deckName,
                      child: Text(deckName),
                    );
                  }).toList(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Enter question'),
                  onChanged: (value) {
                    question = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Enter answer'),
                  onChanged: (value) {
                    answer = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (question.isNotEmpty && answer.isNotEmpty) {
                  setState(() {
                    flashcardDecks[selectedDeck]!
                        .add(Flashcard(question, answer));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Flashcard {
  String question;
  String answer;

  Flashcard(this.question, this.answer);
}

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;

  FlashcardWidget({required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PresentationScreen(
                flashcards: [flashcard],
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            flashcard.question,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

class PresentationScreen extends StatefulWidget {
  final List<Flashcard> flashcards;

  PresentationScreen({required this.flashcards});

  @override
  _PresentationScreenState createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  int currentIndex = 0;
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Presentation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              showAnswer ? widget.flashcards[currentIndex].answer : widget.flashcards[currentIndex].question,
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentIndex = (currentIndex + 1) % widget.flashcards.length;
                showAnswer = false; // Reset to question when moving to next card
              });
            },
            child: Text('Next'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showAnswer = !showAnswer;
              });
            },
            child: Text(showAnswer ? 'Show Question' : 'Show Answer'),
          ),
        ],
      ),
    );
  }
}

