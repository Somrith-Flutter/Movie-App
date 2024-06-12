import 'package:flutter/material.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about_us),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return Container();
  }
}