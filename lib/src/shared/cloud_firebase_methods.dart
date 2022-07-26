import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:game_template/src/shared/history.dart';

Future createNewCollectionForNewAccount(name, email) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

  final json = {'name': name, 'e-mail': email, 'history': []};

  await docUser.set(json);
}

Future updateHistoryFromUser(
    {world = null, question = null, result = null, reseted = false}) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

  final docSnap = await docUser.get();
  final historyModel = docSnap.data()?['history'];

  History history = History(
      world: world, question: question, result: result, reseted: reseted);

  historyModel.add(history.toHash());

  docUser.set({'history': historyModel}, SetOptions(merge: true));
}

Future updateUserName(name) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

  docUser.set({'name': name}, SetOptions(merge: true));
}

Future getUserName() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

  final docSnap = await docUser.get();
  final userNameModel = docSnap.data()?['name'];

  return userNameModel;
}