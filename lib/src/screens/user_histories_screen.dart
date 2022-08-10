import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:game_template/src/shared/cloud_firebase_methods.dart';
import 'package:game_template/src/shared/history.dart';
import 'package:game_template/src/shared/reusable_widget.dart';
import 'package:game_template/src/style/responsive_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UserHistoriesScreen extends StatefulWidget {
  UserHistoriesScreen({Key? key}) : super(key: key);

  @override
  State<UserHistoriesScreen> createState() => _UserHistoriesScreenState();
}

class _UserHistoriesScreenState extends State<UserHistoriesScreen> {
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

                          List historyAccess = data['historyAccess'];

                          context.loaderOverlay.hide();
                          return ListView(
                            children: [
                              for (final email in historyAccess)
                                ListTile(
                                  onTap: () {
                                    GoRouter.of(context).goNamed('userHistory',
                                        params: {'email': '${email}'});
                                  },
                                  leading: Text(
                                      (historyAccess.indexOf(email) + 1)
                                          .toString(),
                                      style: GoogleFonts.vt323(
                                          textStyle: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w300))),
                                  title: Text('${email}',
                                      style: textStyleWithShadow(context,
                                          size: 1.5)),
                                ),
                            ],
                          );
                        }

                        return Text('');
                      },
                    )),
              ),
              ElevatedButton(
                  onPressed: () => GoRouter.of(context).go('/menu/history'),
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
