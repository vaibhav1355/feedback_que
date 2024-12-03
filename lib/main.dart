import 'package:flutter/material.dart';

const Color kGreenColor = Color(0xFF448AFF);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Map<String, TextEditingController> _textControllers = {};

  final List<Map<String, dynamic>> data = [
    {
      "question": "Which of the following widgets is used to lay out widgets in a vertical direction in Flutter?",
      "id": "1",
      "actionType": "Single",
      "answer": ["Option 3"],
      "options": {"Option 1", "Option 2", "Option 3", "Option 4"},
      "selectedValues": <String>{},
    },
    {
      "question": "What is the default build mode of Flutter when you run the app using the flutter run command?",
      "id": "2",
      "actionType": "Multiple",
      "answer": ["Option 1", "Option 4"],
      "options": {"Option 1", "Option 2", "Option 3", "Option 4"},
      "selectedValues": <String>{},
    },
    {
      "question": "Provide a short comment about Flutter's flexibility.",
      "id": "3",
      "actionType": "Comment",
      "answer": [],
      "options": {},
      "selectedValues": <String>{},
    },
    {
      "question": "Rate your experience with Flutter.",
      "id": "4",
      "actionType": "Star",
      "answer": [],
      "options": {"totalStars": 7},
      "selectedValues": <String>{},
    },
    {
      "question": "Which Flutter widget is used to detect gestures?",
      "id": "5",
      "actionType": "Single",
      "answer": ["Option 2"],
      "options": {"Option 1", "Option 2", "Option 3", "Option 4"},
      "selectedValues": <String>{},
    },
    {
      "question": "Select all platforms supported by Flutter.",
      "id": "6",
      "actionType": "Multiple",
      "answer": ["Option 1", "Option 3", "Option 4"],
      "options": {"Option 1", "Option 2", "Option 3", "Option 4"},
      "selectedValues": <String>{},
    },
    {
      "question": "Write a short summary of your favorite Flutter feature.",
      "id": "7",
      "actionType": "Comment",
      "answer": [],
      "options": {},
      "selectedValues": <String>{},
    },
    {
      "question": "Rate the documentation provided by Flutter.",
      "id": "8",
      "actionType": "Star",
      "answer": [],
      "options": {"totalStars": 5},
      "selectedValues": <String>{},
    },
    {
      "question": "Select one option for each row:",
      "id": "9",
      "actionType": "MatrixTypeSingleOption",
      "options": {
        "numberOfRows": 4,
        "numberOfColumns": 4,
      },
      "selectedValues": <String>{},
    },
    {
      "question": "Select one option for each row:",
      "id": "9",
      "actionType": "MatrixTypeMultipleOption",
      "options": {
        "numberOfRows": 4,
        "numberOfColumns": 4,
      },
      "selectedValues": <String>{},
    },
    {
      "question": "Select one option for each row:",
      "id": "10",
      "actionType": "NPS",
      "options": {

      },
      "selectedValues": <String>{},
    },
    {
      "question": "Select one option for each row:",
      "id": "11",
      "actionType": "MatrixInputField",
      "options": {
          "numberofRows":"2",
          "numberofColumns" : "2",
      },
      "selectedValues": <String>{},
    },
  ];

  // handle changes in Single choice , multiple choice , check box and radio button
  void onCheckBoxChanged(int index, String value, bool isSelected) {
    setState(() {
      if (data[index]['actionType'] == "Single") {
        data[index]['selectedValues'] = {value};
      } else if (data[index]['actionType'] == "Multiple") {
        if (isSelected) {
          data[index]['selectedValues'].add(value);
        } else {
          data[index]['selectedValues'].remove(value);
        }
      }
      print('Question ID: ${data[index]['id']}, Selected Values: ${data[index]['selectedValues']}');
    });
  }


  void onCommentChanged(int index, String value) {
    setState(() {
      data[index]['selectedValues'] = {value};
      print('Question ID: ${data[index]['id']}, Comment: $value');
    });
  }

  void onStarChanged(int index, int stars) {
    setState(() {
      data[index]['selectedValues'] = {stars.toString()};
      print('Question ID: ${data[index]['id']}, Stars: $stars');
    });
  }

  void _onNPSValueSelected(int index, String value) {
    setState(() {
      data[index]['selectedValues'] = {value};
      print('Question ID: ${data[index]['id']}, NPS Selected Value: $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Quiz App')),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index) {
            final item = data[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question-${index + 1}: ${item['question']}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    if (item['actionType'] == "Single") ...[
                      for (String option in item['options'])
                        _buildRadioOption(index, option),
                    ] else if (item['actionType'] == "Multiple") ...[
                      for (String option in item['options'])
                        _buildCheckboxOption(index, option),
                    ] else if (item['actionType'] == "Comment") ...[
                      _buildCommentBox(index),
                    ] else if (item['actionType'] == "Star") ...[
                      _buildStarRating(index),
                    ] else if (item['actionType'] == "MatrixTypeSingleOption") ...[
                      _buildMatrixOption(index)
                    ] else if (item['actionType'] == "MatrixTypeMultipleOption") ...[
                      _buildMatrixOptionMultiple(index)
                    ] else if (item['actionType'] == "NPS") ...[
                      _buildNPSOption(index),
                    ] else if (item['actionType'] == 'MatrixInputField') ...[
                      _buildMatrixInputField(index),
                    ]
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  Widget _buildRadioOption(int index, String value) {
    final selectedValues = data[index]['selectedValues'] as Set<String>;
    return RadioListTile<String>(
      value: value,
      groupValue: selectedValues.isNotEmpty ? selectedValues.first : null,
      title: Text(value),
      activeColor: kGreenColor,
      onChanged: (value) => onCheckBoxChanged(index, value!, true),
    );
  }

  Widget _buildCheckboxOption(int index, String value) {
    final selectedValues = data[index]['selectedValues'] as Set<String>;
    return CheckboxListTile(
      title: Text(value),
      value: selectedValues.contains(value),
      onChanged: (isSelected) => onCheckBoxChanged(index, value, isSelected!),
      activeColor: kGreenColor,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildCommentBox(int index) {
    final selectedValues = data[index]['selectedValues'] as Set<String>;
    final initialValue = selectedValues.isNotEmpty ? selectedValues.first : '';
    return TextField(
      decoration: InputDecoration(
        labelText: 'Your Answer',
        border: OutlineInputBorder(),
      ),
      minLines: 1,
      maxLines: 3,
      onChanged: (value) => onCommentChanged(index, value),
      controller: TextEditingController.fromValue(
        TextEditingValue(
          text: initialValue,
          selection: TextSelection.collapsed(offset: initialValue.length),
        ),
      ),
    );
  }

  Widget _buildStarRating(int index) {
    final selectedValues = data[index]['selectedValues'] as Set<String>;
    final stars = selectedValues.isNotEmpty ? int.parse(selectedValues.first) : 0;
    final totalStars = data[index]['options']['totalStars'] as int;

    return Row(
      children: List.generate(totalStars, (starIndex) {
        return IconButton(
          icon: Icon(
            Icons.star,
            color: starIndex < stars ? kGreenColor : Colors.grey,
          ),
          onPressed: () => onStarChanged(index, starIndex + 1),
        );
      }),
    );
  }

  Widget _buildMatrixOption(int index) {
    final rows = data[index]['options']['numberOfRows'] as int;
    final columns = data[index]['options']['numberOfColumns'] as int;
    final selectedValues = data[index]['selectedValues'] as Set<String>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column headers for the matrix
        Row(
          children: [
            SizedBox(width: 80),
            for (int col = 1; col <= columns; col++)
              Expanded(
                child: Center(
                  child: Text(
                    'Col $col',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),

        // Rows with radio buttons
        for (int row = 1; row <= rows; row++)
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  'Row $row',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // Replace Table with Container or another simpler layout
              for (int col = 1; col <= columns; col++)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Radio<String>(
                      value: 'R$row$col',
                      groupValue: selectedValues.isEmpty ? null : selectedValues.first,
                      activeColor: kGreenColor,
                      onChanged: (String? value) {
                        setState(() {
                          if (value != null) {
                            selectedValues.clear();
                            selectedValues.add(value);
                          }
                        });
                        print('Question ID: ${data[index]['id']}, Selected Cell: R$row$col');
                      },
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildMatrixOptionMultiple(int index) {
    final rows = data[index]['options']['numberOfRows'] as int;
    final columns = data[index]['options']['numberOfColumns'] as int;
    final selectedValues = data[index]['selectedValues'] as Set<String>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column headers (Column 1, Column 2, ...)
        Row(
          children: [
            SizedBox(width: 80), // Space for row label alignment
            for (int col = 1; col <= columns; col++)
              Expanded(
                child: Center(
                  child: Text(
                    'Col $col',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),

        // Rows with Row Labels and checkboxes
        for (int row = 1; row <= rows; row++)
          Row(
            children: [
              // Row label (Row 1, Row 2, ...)
              SizedBox(
                width: 80,
                child: Text(
                  'Row $row',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // Column cells with checkboxes
              for (int col = 1; col <= columns; col++)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Checkbox(
                      value: selectedValues.contains('R${row}C${col}'),
                      activeColor: kGreenColor,
                      onChanged: (isSelected) {
                        setState(() {
                          final cellValue = 'R${row}C${col}';
                          if (isSelected == true) {
                            selectedValues.add(cellValue);
                          } else {
                            selectedValues.remove(cellValue);
                          }
                        });
                        print('Question ID: ${data[index]['id']}, Selected Cells: $selectedValues');
                      },
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildNPSOption(int index) {
    final selectedValues = data[index]['selectedValues'] as Set<String>? ?? {};
    final selectedValue = selectedValues.isNotEmpty ? selectedValues.first : null;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Allow horizontal scrolling
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(11, (i) { // Start from 0, generate 11 items (0-10)
          final value = i.toString();
          return GestureDetector(
            onTap: () => _onNPSValueSelected(index, value),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2), // Reduced horizontal margin
              decoration: BoxDecoration(
                color: selectedValue == value ? kGreenColor : Colors.grey[300],
                borderRadius: BorderRadius.circular(4), // Smaller radius for compact design
              ),
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Adjust padding for shorter buttons
              child: Text(
                value,
                style: TextStyle(
                  color: selectedValue == value ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }


  Widget _buildMatrixInputField(int index) {
    final rows = int.parse(data[index]['options']['numberofRows']);
    final columns = int.parse(data[index]['options']['numberofColumns']);
    final selectedValues = data[index]['selectedValues'] as Set<String>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column headers
        Row(
          children: [
            const SizedBox(width: 80),
            for (int col = 1; col <= columns; col++)
              Expanded(
                child: Center(
                  child: Text(
                    'Col $col',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),

        for (int row = 1; row <= rows; row++)
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  'Row $row',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              for (int col = 1; col <= columns; col++)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'R${row}C${col}',
                      ),
                      controller: _getControllerForCell(index, row, col, selectedValues),
                      onChanged: (value) {
                        final cellKey = 'R${row}C${col}';
                        setState(() {
                          selectedValues.removeWhere((cell) => cell.startsWith(cellKey));
                          if (value.isNotEmpty) {
                            selectedValues.add('$cellKey:$value');
                          }
                        });
                        print('Question ID: ${data[index]['id']}, Selected value: $selectedValues');
                      },
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  TextEditingController _getControllerForCell(
      int index,
      int row,
      int col,
      Set<String> selectedValues,
      ) {
    final cellKey = 'R${row}C${col}';
    if (!_textControllers.containsKey(cellKey)) {
      final initialValue = selectedValues
          .firstWhere(
            (cell) => cell.startsWith('$cellKey:'),
        orElse: () => '',
      )
          .split(':')
          .last;

      _textControllers[cellKey] = TextEditingController(text: initialValue);
    }
    return _textControllers[cellKey]!;
  }
}


