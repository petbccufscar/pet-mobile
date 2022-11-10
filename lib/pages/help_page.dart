import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';

class HelpPage extends StatelessWidget {
  HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Textos para os cards. Como usamos o context para definir o locale, eles precisam ser construídos dentro do build.
    final List<_HelpInfo> helpInfoList = [
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_1,
          AppLocalizations.of(context)!.help_page_card_1_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_2,
          AppLocalizations.of(context)!.help_page_card_2_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_3,
          AppLocalizations.of(context)!.help_page_card_3_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_4,
          AppLocalizations.of(context)!.help_page_card_4_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_5,
          AppLocalizations.of(context)!.help_page_card_5_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_6,
          AppLocalizations.of(context)!.help_page_card_6_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_7,
          AppLocalizations.of(context)!.help_page_card_7_text),
    ];

    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text(AppLocalizations.of(context)!.help_page_title),
      body: Container(
        color: Color(0xFFDFECEB),

        // Lista com os cards de ajuda.
        child: ListView.separated(
          // Separador entre os cards. Caixa invisível.
          separatorBuilder: (BuildContext ctx, int index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: helpInfoList.length,
          itemBuilder: (BuildContext ctx, int index) {
            return Padding(
              padding: EdgeInsets.only(
                  top: index == 0 ? 20 : 0,
                  left: 20,
                  right: 20,
                  bottom: index == helpInfoList.length - 1
                      ? MediaQuery.of(context).size.height * 0.5
                      : 0),
              child: ExpansionTile(
                collapsedBackgroundColor: Color(0xFFF4F4F4),
                backgroundColor: Color(0xFFF4F4F4),
                title: Padding(
                  padding: const EdgeInsets.all(10.0),

                  // Título do card.
                  child: RichText(
                    text: TextSpan(
                      text: helpInfoList[index].title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: helpInfoList[index].info,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HelpInfo {
  _HelpInfo(this.title, this.info);

  final String title;
  final String info;
}
