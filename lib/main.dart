import 'package:myapp1/flashcard.dart';
import 'package:myapp1/flashcard_view.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

void main() {

}

class MyApp extends StatefulWidget {


  @override

}

class _MyAppState extends State<MyApp> {
  final List<Flashcard> _flashcards = [
    Flashcard(question: "What language does flutter uses?", answer: "Dart"),
    Flashcard(question: "What language does React uses?", answer: "JavaScript"),
    Flashcard(question: "What language does Angular uses?", answer: "JavaScript"),
    Flashcard(question: "What language does Electron uses?", answer: "JavaScript"),
    Flashcard(question: "What language does React Native uses?", answer: "JavaScript")
  ];

  int _currIndex = 0;

  @override

    return MaterialApp(
      
        
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
                width: 250,
                height: 250,
                
                  front: FlashcardView(text: _flashcards[_currIndex].question),
                  
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                    
                    icon: const Icon(Icons.chevron_left), 
                    
                  OutlinedButton.icon(
                     
                     
                    label: const Text('Next')),
                ]
              )
            ]
          ),
        )
      )
    );
  }
  void nextCard(){
    
      _currIndex = (_currIndex + 1 < _flashcards.length) ? _currIndex + 1 : 0;
    });
  }
  void previousCard(){
    
      
    });
  }
}