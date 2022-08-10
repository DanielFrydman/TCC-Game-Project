import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:game_template/src/shared/history.dart';

Future createNewCollectionForNewAccount(name, email, isManager) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(email);

  final json = {
    'name': name,
    'e-mail': email,
    'history': [],
    'created_at': new DateTime.now(),
    'updated_at': new DateTime.now(),
    'isManager': isManager,
    'historyAccess': [],
    'historyRequest': []
  };

  await docUser.set(json);
}

Future updateHistoryFromUser(
    {world = null, question = null, result = null, reseted = false}) async {
  final email = FirebaseAuth.instance.currentUser?.email;
  final docUser = FirebaseFirestore.instance.collection('users').doc(email);
  final docSnap = await docUser.get();
  final historyModel = docSnap.data()?['history'];
  History history = History(
      world: world,
      question: question,
      result: result,
      reseted: reseted,
      created_at: new DateTime.now());

  historyModel.add(history.toHash());
  docUser.set({'history': historyModel}, SetOptions(merge: true));
}

Future updateUserName(name) async {
  final email = FirebaseAuth.instance.currentUser?.email;
  final docUser = FirebaseFirestore.instance.collection('users').doc(email);
  docUser.set({'name': name}, SetOptions(merge: true));
}

Future getUserName() async {
  final email = FirebaseAuth.instance.currentUser?.email;
  final docUser = FirebaseFirestore.instance.collection('users').doc(email);
  final docSnap = await docUser.get();
  final userNameModel = docSnap.data()?['name'];
  return userNameModel;
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocumentSnapshot() =>
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();

Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocumentSnapshotByEmail(
        email) =>
    FirebaseFirestore.instance.collection('users').doc(email).get();

Future<bool> hasHistoryAccessRequested() async {
  try {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final docUser =
        await FirebaseFirestore.instance.collection('users').doc(userEmail);
    final docSnap = await docUser.get();
    final historyRequest = docSnap.data()?['historyRequest'];

    if (historyRequest.length > 0) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  } catch (e) {
    return Future<bool>.value(false);
  }
}

Future updateHistoryRequest(email) async {
  try {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final docUser = FirebaseFirestore.instance.collection('users').doc(email);
    final docSnap = await docUser.get();
    final historyRequest = docSnap.data()?['historyRequest'];
    if (historyRequest.contains(userEmail)) {
      return 'Solicitação de acesso já foi enviada.';
    } else {
      historyRequest.add(userEmail);
      docUser.set({'historyRequest': historyRequest}, SetOptions(merge: true));
      return 'Solicitação de acesso enviada.';
    }
  } catch (e) {
    return 'Algo deu errado, tente novamente.';
  }
}

Future removeManagerFromHistoryRequest(email) async {
  try {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final docUser = FirebaseFirestore.instance.collection('users').doc(userEmail);
    final docSnap = await docUser.get();
    final historyRequest = docSnap.data()?['historyRequest'];
    if (historyRequest.length > 0) {
      if (historyRequest.contains(email)) {
        historyRequest.remove(email);
        docUser.set({'historyRequest': historyRequest}, SetOptions(merge: true));
        return 'Gestor removido da solicitação de acesso.';
      } else {
        return 'Gestor não solicitou acesso.';
      }
    } else {
      return 'O gestor solicitou acesso ainda.';
    }
  } catch (e) {
    return 'Algo deu errado, tente novamente.';
  }
}

Future updateHistoryAccess(email) async {
  try {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final docUser = FirebaseFirestore.instance.collection('users').doc(email);
    final docSnap = await docUser.get();
    final isManager = docSnap.data()?['isManager'];
    if (isManager) {
      final historyAccess = docSnap.data()?['historyAccess'];
      if (historyAccess.contains(userEmail)) {
        return 'Gestor já possui acesso ao histórico.';
      } else {
        historyAccess.add(userEmail);
        docUser.set({'historyAccess': historyAccess}, SetOptions(merge: true));
        return 'Acesso ao histórico concedido.';
      }
    } else {
      return 'O usuário informado não é um gestor.';
    }
  } catch (e) {
    return 'Algo deu errado, tente novamente.';
  }
}
