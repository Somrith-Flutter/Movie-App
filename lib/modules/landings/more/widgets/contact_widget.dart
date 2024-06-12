import 'package:flutter/material.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          S.of(context).contact_us
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return Container();
  }
}