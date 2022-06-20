class Participant {
  var firstName = "";
  var lastName = "";

  // Participant();
  Participant(this.firstName, this.lastName);

  Map<String, dynamic> toJson() =>
      {'first_name': firstName, 'last_name': lastName};

  Participant.fromSnapshot(snapshot)
      : firstName = snapshot.data()['first_name'],
        lastName = snapshot.data()['last_name'];
// var sex = "";
// var dateOfBirth = "";
//
// var guardianFirstName = "";
// var guardianLastName = "";
//
// var mobileNumber = "";
// var icn = "";
// var address = "";
// var city = "";
//
// bool freeFormation = false;
// var formationName = "";
// var formationGroup = "";
// var formationLevel = "";
//
// var schoolName = "";
// var schoolBranch = "";
// var schoolLevel = "";
//
// bool paidRegistration = false;
// bool paidFormation = false;

}
