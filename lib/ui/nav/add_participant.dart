import 'package:center_manager/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../const.dart';

class AddParticipant extends StatefulWidget {
  const AddParticipant({Key? key}) : super(key: key);

  @override
  State<AddParticipant> createState() => _AddParticipantState();
}

class _AddParticipantState extends State<AddParticipant> {
  String addNewParticipant = "Add New Participant";
  String buttonTextSuccess = "Participant Added Successfully";

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

  var participants = FirebaseFirestore.instance.collection('participants');

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
                Radius.circular(10.0),
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
                  // hoverColor: Colors.greenAccent,
                  splashColor: Colors.lightBlueAccent,
                  label: const Text('Add Participant'),
                  icon: const Icon(Icons.add),
                  elevation: 4,
                  hoverElevation: 0,
                  onPressed: () {
                    if (_firstName.text != "" && _lastName.text != "") {
                      addParticipant();
                    }
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
            textField(
              TextFormField(
                controller: _firstName,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            textField(
              TextFormField(
                controller: _lastName,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        // const Center(child: Text('Guardian information')),
        Row(
          children: [
            textField(
              TextFormField(
                controller: _guardianFirstName,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'Guardian First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            textField(
              TextFormField(
                controller: _guardianLastName,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'Guardian Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            textField(
              TextFormField(
                controller: _dateOfBirth,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ), // Only numbers can be enter
                ),
                // maxLength: 8,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
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
            textField(
              TextFormField(
                controller: _mobileNumber,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
                // maxLength: 10,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            const SizedBox(width: 24),
            textField(
              TextFormField(
                controller: _identificationNumber,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'Identification Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            textField(
              TextFormField(
                controller: _address,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
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
                    labelText: 'City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                  ),
                  items: [
                    'Agadir',
                    'Ait Melloul',
                    'Anza',
                    'Azrou',
                    'Biougra',
                    'Belfaa',
                    'Beni Mellal',
                    'Chtouka Aitbaha',
                    'Drarga',
                    'El Kolea',
                    'Essaouira',
                    'Essmara',
                    'Inzegan',
                    'Laayoune',
                    'Ouled Teima',
                    'Rabat',
                    'Sale',
                    'Taroudant',
                    'Temsia',
                    'Tikiouine',
                    'Tiiznit',
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                    ),
                    items: [
                      'Office',
                      'Excel',
                      'Soroban',
                      'Band Aid',
                      'Compatibility General',
                      'E-commerce',
                      'French',
                      'English',
                      'Math',
                      'SVT',
                      'Physique',
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                    ),
                    items: [
                      'A',
                      'B',
                      'C',
                      'D',
                      'E',
                      'F',
                      'G',
                      'H',
                      'I',
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
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
            //         items: [
            //           'Current',
            //           'Expected',
            //           'Finished',
            //         ]
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            textField(
              TextFormField(
                controller: _schoolName,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'School Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            textField(
              TextFormField(
                controller: _schoolLevel,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'School Level',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            textField(
              TextFormField(
                controller: _schoolBranch,
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'School Branch',
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(100, 229, 229, 229)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            textField(
              Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return listCities.where((String option) {
                    return option.contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  debugPrint('You just selected $selection');
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget textField(Widget child) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: child,
      ),
    );
  }

  void addParticipant() {
    if (_identificationNumber.text == "") {
      _identificationNumber.text = Utils().timestamp(11).toString();
    }

    final participant = <String, dynamic>{
      'info': {
        'full_name': '${_firstName.text} ${_lastName.text}',
        'date_of_birth': _dateOfBirth.text,
        'address': _address.text,
        'city': _city,
        'mobile_number': _mobileNumber.text,
        'icn': _identificationNumber.text.toUpperCase(),
        'genre': _genre,
      },
      'formation': [
        {
          'name': _formationName,
          'group': _formationGroup,
          'level': _formationLevel,
          'free': _isFreeFormation,
          'paid': _isFormationPaid,
          'paid_registration': _isRegistrationPaid,
          'registration_date': Utils().timestamp(10),
          // 'status': _status,
        }
      ],
      'school': {
        'name': _schoolName.text,
        'branch': _schoolBranch.text,
        'level': _schoolLevel.text
      },
      'guardian_name': '${_guardianFirstName.text} ${_guardianLastName.text}',
      'first_registration': Utils().timestamp(10),
    };

    participants
        .doc(Utils().timestamp(11))
        .set(participant)
        .whenComplete(() => {Utils().inlineDelay(2000), init()});
  }

  void init() {
    //info
    _firstName.text = "";
    _lastName.text = "";
    _genre = "";
    _dateOfBirth.text = "";
    _mobileNumber.text = "";
    _identificationNumber.text = "";
    _address.text = "";
    _city = "";

    //guardian
    _guardianFirstName.text = "";
    _guardianLastName.text = "";

    //formation
    _formationName = "";
    _formationGroup = "";
    _formationLevel = "";
    _isFormationPaid = false;
    _isFreeFormation = false;

    //school
    _schoolName.text = "";
    _schoolBranch.text = "";
    _schoolLevel.text = "";
  }
}
