// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:game_template/src/shared/cloud_firebase_methods.dart';
import 'package:game_template/src/shared/history.dart';
import 'package:game_template/src/shared/reusable_widget.dart';
import 'package:game_template/src/style/responsive_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UserHistoryScreen extends StatefulWidget {
  String email;

  UserHistoryScreen(this.email, {Key? key}) : super(key: key);

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState(this.email);
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  String email;
  _UserHistoryScreenState(this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgrounds[getBackgroundForDayTime()]),
                fit: BoxFit.cover)),
        child: ResponsiveScreen(
          squarishMainArea: Column(
            children: [
              Text('Histórico',
                  textAlign: TextAlign.center,
                  style: textStyleWithShadow(context)),
              Expanded(
                  child: LoaderOverlay(
                useDefaultLoading: false,
                overlayWidget: Center(
                  child: SpinKitThreeBounce(color: buttonColor, size: 50.0),
                ),
                overlayOpacity: 0,
                child: FutureBuilder<DocumentSnapshot>(
                  future: getUserDocumentSnapshotByEmail(email),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    context.loaderOverlay.show();
                    if (snapshot.hasError) {
                      context.loaderOverlay.hide();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          text('Algo deu errado, tente novamente mais tarde.',
                              context)
                        ],
                      );
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      context.loaderOverlay.hide();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          text(
                              'Você não possui um histórico no banco de dados.',
                              context)
                        ],
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      List historiesJson = [];
                      data['history'].forEach((history) {
                        historiesJson.add(historyMapper(history));
                      });

                      context.loaderOverlay.hide();
                      return ListView(
                        children: [
                          dataTable([
                            DataColumn(label: Text('Legenda:')),
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                            DataColumn(label: Text(''))
                          ], [
                            DataRow(cells: [
                              DataCell(Text('✔️ Certo',
                                  style: TextStyle(color: Colors.green))),
                              DataCell(Text('✖️ Errado',
                                  style: TextStyle(color: Colors.red))),
                              DataCell(Text('✔️✔️ Bonus',
                                  style: TextStyle(color: Colors.green))),
                              DataCell(Text('🔄 Restaurou')),
                            ])
                          ], dataRowHeight: 50.0),
                          formDataTable(historiesJson)
                        ],
                      );
                    }

                    return Text('');
                  },
                ),
              )),
              ElevatedButton(
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser?.email == email) {
                      GoRouter.of(context).goNamed('history');
                    } else {
                      GoRouter.of(context).goNamed('userHistories');
                    }
                  },
                  child: Text('Voltar'),
                  style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      textStyle: textStyle(context, size: 2))),
            ],
          ),
        ),
      ),
    );
  }
}

historyMapper(historyMap) {
  History history = History.fromJson(historyMap);
  return history;
}

DataTable formDataTable(list) {
  List<DataRow> dataRow = [];
  list.forEach((element) {
    if (element.reseted == true) {
      dataRow.add(DataRow(cells: [
        DataCell(Text('   -')),
        DataCell(Text('O progresso do jogo foi redefinido.')),
        DataCell(Text('    🔄')),
        DataCell(
            Text(formatDate(element.created_at), textAlign: TextAlign.center))
      ]));
    } else {
      dataRow.add(DataRow(cells: [
        DataCell(Text('   ' + element.world.toString())),
        DataCell(Text(element.question)),
        DataCell(getEmojiForAnwser(element.result)),
        DataCell(
            Text(formatDate(element.created_at), textAlign: TextAlign.center))
      ]));
    }
  });

  final columns = [
    DataColumn(label: Text('Mundo')),
    DataColumn(label: Text('Pergunta')),
    DataColumn(label: Text('Resposta')),
    DataColumn(label: Text('Quando?'))
  ];

  return dataTable(columns, dataRow);
}

DataCell formatDataCell(data) {
  return DataCell(Text(''));
}

Text getEmojiForAnwser(result) {
  String text = '';
  MaterialColor color;
  if (result == 'correct') {
    text = '    ✔️';
    color = Colors.green;
  } else if (result == 'wrong') {
    text = '    ✖️';
    color = Colors.red;
  } else {
    text = '   ✔️✔️';
    color = Colors.green;
  }

  return Text(text,
      textAlign: TextAlign.center, style: TextStyle(color: color));
}
