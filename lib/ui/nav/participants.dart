import 'package:center_manager/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/participant.dart';

class Participants extends StatefulWidget {
  const Participants({Key? key}) : super(key: key);

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: const Center(
        child: ParticipantsInfo(),
      ),
    );
  }
}

void getParticipants() {}

class ParticipantsInfo extends StatefulWidget {
  const ParticipantsInfo({Key? key}) : super(key: key);

  @override
  _ParticipantsInfoState createState() => _ParticipantsInfoState();
}

class _ParticipantsInfoState extends State<ParticipantsInfo> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection(participantsCollection).snapshots();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getParticipants();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // if (snapshot.hasError) {
        //   return Text('Something went wrong');
        // }
        //
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Text("Loading");
        // }

        final columns = ['First Name', 'Last Name', 'Formation'];
        // return DataTable(columns: getColumn(columns), rows: rows);

        return ListView.builder(
          itemCount: _listParticipant.length,
          itemBuilder: (context, index) {
            return Center(child: Text(''),);
          },
        );
      },
    );
  }

  List<Object> _listParticipant = [];

  Future getParticipants() async {
    var data = await FirebaseFirestore.instance
        .collection(participantsCollection)
        // .orderBy('first_registration', descending: true)
        .get();

    setState(() {
      _listParticipant =
          List.of(data.docs.map((doc) => Participant.fromSnapshot(doc)));
    });
  }

  List<DataColumn> getColumn(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();
}
