import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:game_template/src/shared/cloud_firebase_methods.dart';
import 'package:game_template/src/shared/reusable_widget.dart';
import 'package:game_template/src/style/responsive_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
                      future: getUserDocumentSnapshot(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        context.loaderOverlay.show();
                        if (snapshot.hasError) {
                          context.loaderOverlay.hide();
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              text(
                                  'Algo deu errado, tente novamente mais tarde.',
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

                          context.loaderOverlay.hide();
                          return ListView(children: [
                            Column(
                              children: [
                                gap(MediaQuery.of(context).size.height / 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    if (data['isManager']) ...[
                                      buttonUserHistory(
                                          context, 'Seu', data['e-mail']),
                                      button(context, 'Conceder acesso',
                                          '/menu/history/grantAccessHistory'),
                                      button(context, 'Solicitar acesso',
                                          '/menu/history/requestAccessHistory'),
                                      button(context, 'Sua equipe',
                                          '/menu/history/userHistories')
                                    ] else ...[
                                      buttonUserHistory(context,
                                          'Seu histórico', data['e-mail']),
                                      button(context, 'Conceder acesso',
                                          '/menu/history/grantAccessHistory'),
                                    ]
                                  ],
                                )
                              ],
                            )
                          ]);
                        }

                        return Text('');
                      },
                    )),
              ),
              button(context, 'Voltar', '/menu')
            ],
          ),
        ),
      ),
    );
  }
}
