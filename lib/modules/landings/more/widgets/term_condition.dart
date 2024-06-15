import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';

class TermConditionWidget extends StatelessWidget {
  const TermConditionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: Text(S.of(context).term_condition), // Changed TextWidget to Text
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: AppColor.primaryColor,
      body: _buildBody(), // Passing default content as an empty list
    );
  }

  Widget _buildBody([List<Widget> content = const []]) { // Added default value for content
    return const SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Terms & Condition",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8,bottom: 8),
            child: SizedBox(height: 10),
          ),
          Text("Ticket Purchased Rule and Regulation",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: SizedBox(height: 10),
          ),
          Text("1. Every movie tickets purchased via the Sale Channels are strictly "
              "non-refundable and are not available for exchange under whatever circumstances.",
          ),
          SizedBox(height: 10),
          Text("2. Purchased tickets are not exchangeable for tickets at a different price,"
              " for another movie, or for another screening or day.",
          ),
          SizedBox(height: 10),
          Text("3. Movie tickets purchased via the Sales Channels will be available for"
              " collection at the relevant cinema from the ticket counter or at our "
              "KIOSK machine (where available) by producing the booking numbers/"
              " reservation sent by email or as available under the purchased history"
              " feature in Legend Mobile application or any other means that shall be "
              "introduced by Legend Cinema from time to time.",
          ),
          SizedBox(height: 10),
          Text("4. In case of any malfunctions of the reservation or purchase form "
              "placed on the website or mobile application, please contact us immediately "
              "at the following e-mail address hotline@legend.com.kh or contact our hotline "
              "081300400 at least 30 minutes before the movie start. We would also like to inform "
              "you that it is the basis and condition for an effective complaint about the"
              " impossibility or difficulties in purchasing tickets online.",
          ),
          SizedBox(height: 10),
          Text("5. If the User fails to purchase a ticket for the screening for"
              " which he or she has reserved a seat in the Legend Cinema within"
              " the time limit specified in clause 4 above, the reservation of"
              " such a seat cannot be guaranteed.",
          ),
          SizedBox(height: 10),
          Text("6. Movie tickets are made available subject to the classification of "
              "relevant film given by the Film Censorship Board of Cambodia. "
              "Legend Cinema has a legal obligation to refuse admission to a person,"
              " who in the opinion of its duty manager, is under the minimum age required "
              "for NC15 and R18 classified films (including children in arms). Proof of age may be required in certain instances.",
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(height: 10),
          ),
          Text("Legend Cinema reserved the rights to have term and condition changed"
              "All rights reserved Legend Cinema Co, Ltd 2024.",
          ),
        ],
      ),
    );
  }
}
