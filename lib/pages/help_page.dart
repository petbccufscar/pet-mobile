import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_mobile/widgets/drop_down.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold.dart';

class HelpPage extends StatelessWidget {
  HelpPage({Key? key}) : super(key: key);

  final Icon iconOpened = Icon(Icons.arrow_upward);
  final Icon iconClosed = Icon(Icons.arrow_downward);

  @override
  Widget build(BuildContext context) {
    final List<_HelpInfo> helpInfoList = [
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_1, AppLocalizations.of(context)!.help_page_card_1_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_2, AppLocalizations.of(context)!.help_page_card_2_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_3, AppLocalizations.of(context)!.help_page_card_3_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_4, AppLocalizations.of(context)!.help_page_card_4_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_5, AppLocalizations.of(context)!.help_page_card_5_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_6, AppLocalizations.of(context)!.help_page_card_6_text),
      _HelpInfo(AppLocalizations.of(context)!.help_page_card_7, AppLocalizations.of(context)!.help_page_card_7_text),
    ];

    return SideMenuScaffold(
      appBarTitle: Text(AppLocalizations.of(context)!.help_page_title),
      body: Container(
        color: const Color.fromARGB(0xff, 0x61, 0xCF, 0xD7),
        child: ListView.separated(
          itemBuilder: (BuildContext ctx, int index) {
            return Padding(
              padding: EdgeInsets.only(
                  top: index == 0 ? 20 : 0,
                  left: 20,
                  right: 20,
                  bottom: index == helpInfoList.length - 1 ?  MediaQuery.of(context).size.height * 0.5 : 0
              ),
              child: DropDown(
                title: Padding(
                  padding: const EdgeInsets.all(10),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                      text: helpInfoList[index].title,
                    ),
                  ),
                ),
                iconOpened: iconOpened,
                iconClosed: iconClosed,
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    text: helpInfoList[index].info,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext ctx, int index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: helpInfoList.length,
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

