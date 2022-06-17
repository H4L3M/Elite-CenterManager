import 'package:flutter/material.dart';

class AddParticipant extends StatefulWidget {
  const AddParticipant({Key? key}) : super(key: key);

  @override
  State<AddParticipant> createState() => _AddParticipantState();
}

class _AddParticipantState extends State<AddParticipant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: TextButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: const Text('back'),
      ),
    );
  }
}

void add() {
  Row(
    children: [
      Column(
        children: const [Text('Column 1')],
      ),
      Column(
        children: const [Text('Column 2')],
      ),
    ],
  );
}

void addParticipants(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Flex(
        direction: Axis.horizontal,
        children: const [
          Center(
            child: Text('hello'),
          ),
        ],
      ),
    ),
  );
}

void addParticipant(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        // color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Modal BottomSheet'),
              ElevatedButton(
                child: const Text('Close BottomSheet'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget formAddParticipant(int selectedIndex) {
  return Expanded(
    child: Center(child: Text('selectedIndex:$selectedIndex')),
  );
}
