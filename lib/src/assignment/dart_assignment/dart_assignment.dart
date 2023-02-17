import 'package:flutter/material.dart';

List data = [
  {
    "name": "json",
    "age": 14,
    "last name": "type",
    "hobby": ["surfing", "develop"],
    "personality": {
      "pAgositive": ["pleasant", "active", "independent"],
      "negative": ["lazy"]
    }
  },
  {
    "name": "java",
    "age": 25,
    "last name": "lang",
    "hobby": ["sing"],
    "personality": {
      "positive": ["independent"],
      "negative": []
    }
  },
  {
    "name": "python",
    "age": 18,
    "last name": "lang",
    "hobby": ["sing", "develop"],
    "personality": {
      "positive": ["pleasant", "active", "independent"],
      "negative": ["jealousy", "lazy", "dependent"]
    }
  },
  {
    "name": "js",
    "age": 18,
    "last name": "lang",
    "hobby": [],
    "personality": {
      "positive": ["pleasant", "independent"],
      "negative": ["jealousy", "dependent"]
    }
  },
  {
    "name": "dart",
    "age": 8,
    "last name": "lang",
    "hobby": ["sing", "eat", "surfing", "develop"],
    "personality": {
      "positive": ["pleasant"],
      "negative": ["lazy", "dependent"]
    }
  },
  {
    "name": "ts",
    "age": 26,
    "last name": "lang",
    "hobby": ["sing", "surfing", "develop"],
    "personality": {
      "positive": ["active", "independent"],
      "negative": ["jealousy", "lazy", "dependent"]
    }
  },
  {
    "name": "int",
    "age": 27,
    "last name": "type",
    "hobby": ["sing", "eat", "develop"],
    "personality": {
      "positive": ["active", "independent"],
      "negative": ["jealousy", "lazy", "dependent"]
    }
  },
  {
    "name": "double",
    "age": 29,
    "last name": "type",
    "hobby": ["sing", "eat", "surfing", "develop"],
    "personality": {
      "positive": ["independent"],
      "negative": ["jealousy", "lazy"]
    }
  }
];

class DartAssignment extends StatelessWidget {
  resultAge() {
    List firstData = [...data];
    var resultAge = firstData
        .where((person) => person['name'][0] == 'j')
        .map((pserson) => pserson['age'])
        .reduce((value, element) => value + element);
    print(resultAge);
  }

  resultHobby() {
    List secondData = [...data];
    secondData.sort((a, b) {
      return a['age'] - b['age'];
    });
    var resultHobby = secondData
        .where((person) => person['last name'] == 'lang')
        .where((person) => person['age'] >= 10)
        .map((pserson) => pserson['hobby'])
        .take(3);
    print(resultHobby);
  }

  resultNegative() {
    List thirdData = [...data];
    var resultNegative = thirdData
        .where((person) => person['hobby'].contains('sing'))
        .where((person) => person['age'] >= 20)
        .map((pserson) => pserson['personality']['negative'])
        .reduce((value, element) => value + element)
        .toSet()
        .toList();
    print(resultNegative);
  }

  const DartAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                resultAge();
              },
              child: const Text("문제 1")),
          const SizedBox(
            width: 30,
          ),
          ElevatedButton(
              onPressed: () {
                resultHobby();
              },
              child: const Text("문제 2")),
          const SizedBox(
            width: 30,
          ),
          ElevatedButton(
              onPressed: () {
                resultNegative();
              },
              child: const Text("문제 3")),
        ],
      ),
    );
  }
}
