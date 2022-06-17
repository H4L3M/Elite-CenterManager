import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddParticipant extends StatefulWidget {
  const AddParticipant({Key? key}) : super(key: key);

  @override
  State<AddParticipant> createState() => _AddParticipantState();
}

class _AddParticipantState extends State<AddParticipant> {
  bool _isFreeFormation = false;
  bool _isFormationPaid = false;
  bool _isRegistrationPaid = false;

  late String _genre = "";
  late String _city = "";
  late String _formationName = "";
  late String _formationGroup = "";
  late String _formationLevel = "";

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();

  final TextEditingController _guardianFirstName = TextEditingController();
  final TextEditingController _guardianLastName = TextEditingController();

  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _identificationNumber = TextEditingController();

  final TextEditingController _address = TextEditingController();

  final TextEditingController _schoolName = TextEditingController();
  final TextEditingController _schoolBranch = TextEditingController();
  final TextEditingController _schoolLevel = TextEditingController();

  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.white54,
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Center(
              child: Row(
                children: const [
                  Icon(
                    Icons.supervisor_account_rounded,
                    size: 100,
                    color: Colors.white,
                  ),
                  Text(
                    'Add New Participant',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          form(context),
          const SizedBox(height: 36),
          Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    const Text('Free Formation?'),
                    Switch(
                      value: _isFreeFormation,
                      onChanged: (value) {
                        setState(
                          () {
                            _isFreeFormation = value;
                          },
                        );
                      },
                    ),
                    const Text('Registration Paid?'),
                    Switch(
                      value: _isRegistrationPaid,
                      onChanged: (value) {
                        setState(
                          () {
                            _isRegistrationPaid = value;
                          },
                        );
                      },
                    ),
                    const Text('Formation Paid?'),
                    Switch(
                      value: _isFormationPaid,
                      onChanged: (value) {
                        setState(
                          () {
                            _isFormationPaid = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: FloatingActionButton.extended(
                  label: const Text('Add Participant'),
                  icon: const Icon(Icons.add),
                  elevation: 0,
                  onPressed: () {
                    addParticipant();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget form(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Row(
          children: [
            Expanded(
                child: Stack(
              children: [
                TextFormField(
                  controller: _firstName,
                  initialValue: null,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            )),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Stack(
                children: [
                  TextFormField(
                    controller: _lastName,
                    initialValue: null,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // const Center(child: Text('Guardian information')),
        Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  TextFormField(
                    controller: _guardianFirstName,
                    initialValue: null,
                    decoration: const InputDecoration(
                      labelText: 'Guardian First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: TextFormField(
                controller: _guardianLastName,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'Guardian Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  TextFormField(
                    controller: _dateOfBirth,
                    initialValue: null,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(), // Only numbers can be enter
                    ),
                    // maxLength: 8,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Stack(
                children: [
                  DropdownButtonFormField(
                    // initialValue: _sexVal,
                    decoration: const InputDecoration(
                      labelText: 'Genre',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      'Male',
                      'Female',
                    ]
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    hint: const Text('Chose Genre'),
                    onChanged: (value) {
                      _genre = value.toString();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
                child: Stack(
              children: [
                TextFormField(
                  controller: _mobileNumber,
                  initialValue: null,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                  ),
                  // maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ],
            )),
            const SizedBox(
              width: 24,
            ),
            Expanded(
                child: Stack(
              children: [
                TextFormField(
                  controller: _identificationNumber,
                  initialValue: null,
                  decoration: const InputDecoration(
                    labelText: 'Identification Number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            )),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
                child: Stack(
              children: [
                TextFormField(
                  controller: _address,
                  initialValue: null,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            )),
            const SizedBox(
              width: 24,
            ),
            Expanded(
                child: Stack(
              children: [
                DropdownButtonFormField(
                  // initialValue: _sexVal,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    'Agadir',
                    'Ait Melloul',
                    'Inzegan',
                    'Ouled Teima',
                    'Taroudant',
                  ]
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  hint: const Text('Chose City'),
                  onChanged: (value) {
                    _city = value.toString();
                  },
                ),
              ],
            )),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  DropdownButtonFormField(
                    // initialValue: _sexVal,
                    decoration: const InputDecoration(
                      labelText: 'Formation Name',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      'Office',
                      'Suroban',
                      'Band Aid',
                      'French',
                      'English',
                    ]
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    hint: const Text('Chose Formation'),
                    onChanged: (value) {
                      _formationName = value.toString();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Stack(
                children: [
                  DropdownButtonFormField(
                    // initialValue: _sexVal,
                    decoration: const InputDecoration(
                      labelText: 'Formation Group',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      'A',
                      'B',
                      'C',
                      'D',
                      'E',
                    ]
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    hint: const Text('Chose Group'),
                    onChanged: (value) {
                      _formationGroup = value.toString();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Stack(
                children: [
                  DropdownButtonFormField(
                    // initialValue: _sexVal,
                    decoration: const InputDecoration(
                      labelText: 'Formation Level',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      'First',
                      'Second',
                      'Third',
                      'Final',
                    ]
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    hint: const Text('Chose Level'),
                    onChanged: (value) {
                      _formationLevel = value.toString();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  TextFormField(
                    controller: _schoolName,
                    initialValue: null,
                    decoration: const InputDecoration(
                      labelText: 'School Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Stack(
                children: [
                  TextFormField(
                    controller: _schoolLevel,
                    initialValue: null,
                    decoration: const InputDecoration(
                      labelText: 'School Level',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Stack(
                children: [
                  TextFormField(
                    controller: _schoolBranch,
                    initialValue: null,
                    decoration: const InputDecoration(
                      labelText: 'School Branch',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void addParticipant() {
    final usr = <String, dynamic>{
      'first_name': _firstName.text,
      'last_Name': _lastName.text,
      'date_of_birth': _dateOfBirth.text,
      'address': _address.text,
      'city': _city,
      'mobile_number': _mobileNumber.text,
      'icn': _identificationNumber.text,
      'genre': _genre,
      'guardian_name': '${_guardianFirstName.text} ${_guardianLastName.text}',
      'formation': [
        {
          'name': _formationName,
          'group': _formationGroup,
          'level': _formationLevel,
          'free': _isFreeFormation,
          'paid_formation': _isFormationPaid,
          'paid_registration': _isRegistrationPaid,
          'registration_date': DateTime.now().millisecondsSinceEpoch,
        }
      ],
      'school': {
        'name': _schoolName.text,
        'branch': _schoolBranch.text,
        'level': _schoolLevel.text
      },
      'first_registration': DateTime.now().millisecondsSinceEpoch,
    };

    db.collection('participants').add(usr).then(
          (DocumentReference doc) => print(' id of this doc is : ${doc.id}'),
        ).whenComplete(() =>
        print('Participant Added Successfully.')
    );
  }
}
