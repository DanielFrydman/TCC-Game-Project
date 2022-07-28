import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final int? world;
  final String? question;
  final String? result;
  final bool? reseted;
  final DateTime? created_at;

  History(
      {this.world = 0,
      this.question = "",
      this.result = "",
      this.reseted = false,
      this.created_at = null});

  toHash() {
    return {
      "world": this.world,
      "question": setQuestion(),
      "result": this.result,
      "reseted": this.reseted,
      "created_at": this.created_at
    };
  }

  setQuestion() {
    if (this.question == null) {
      return null;
    }

    return "${this.question?.substring(0, question?.indexOf("?"))}?";
  }

  Map<String, dynamic> toJson() => {
        "world": world,
        "question": question,
        "result": result,
        "reseted": reseted,
        "created_at": created_at
      };

  static History fromJson(Map<String, dynamic> json) => History(
      world: json['world'],
      question: json['question'],
      result: json['result'],
      reseted: json['reseted'],
      created_at: checkIfDateIsValid(json['created_at']));
}

checkIfDateIsValid(date) {
  if (date == null) {
    return date;
  }

  return (date as Timestamp).toDate();
}
