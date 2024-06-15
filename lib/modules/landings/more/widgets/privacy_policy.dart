import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(S.of(context).privacy_policy),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: AppColor.primaryColor,
      body: _buildBody([
        _buildText1(),
        _buildText2(),
        _buildText3(),
        _buildText4(),
        _buildTitle1(),
        _buildText5(),
        _buildTitle2(),
        _buildTitle3(),
        _buildTitle4(),
        _buildTitle5(),
        _buildTitle6(),
        _buildTitle7(),
        _buildTitle8(),
        _buildTitle9(),
      ]),
    );
  }

  Widget _buildBody(List<Widget> content) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Privacy Policy",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          ...content,
        ],
      ),
    );
  }
  Widget _buildText1() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(
        "Vista Entertainment built the Legend Cinema app as a Free app. "
            "This SERVICE is provided by Vista Entertainment "
            "at no cost and is intended for use as is.",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
  Widget _buildText2() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(
        "This page is used to inform visitors regarding our policies with the collection, use and disclosure of Personal Information of anyone decided to use our Service.",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
  Widget _buildText3() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(
        "If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. "
            "The Personal Information that we collect is used for providing and improving the Service. "
            "We will not use or share your information with anyone except as described in this Privacy Policy.",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
  Widget _buildText4() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Text(
        "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Legend Cinema unless otherwise defined in this Privacy Policy.",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
  Widget _buildTitle1() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 8.0, bottom: 8.0),
      child: Text(
        "Information Collection and Use",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  Widget _buildText5() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information. The information that we request will be retained by us and used as described in this privacy policy.",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text(
            "The app does use third party services that may collect information used to identify you.",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text(
            "Link to privacy policy of third party service providers used by the app",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              const url = 'https://play.google.com/store/apps/details?id=com.google.android.gms';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                '. Google Play Services',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTitle2() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Log Data",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "We want to inform you that whenever you use our Service, in a case of an error in the app we"
                " collect data and information (through third party products) on your phone called Log Data."
                " This Log Data may include information such as your device Internet Protocol "
                "IP address, device name, operating system version, the configuration of the app"
                " when utilizing our Service, the time and date of your "
                "use of the Service, and other statistics.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
  Widget _buildTitle3() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cookies",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Cookies are files with a small amount of data that are commonly used "
                "as anonymous unique identifiers. These are sent to your browser from the "
                "websites that you visit and are stored on your device's internal memory.",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            "This Service does not use these cookies explicitly. However, the app may use third "
                "party code and libraries that use cookies to collect information and improve their services. "
                "You have the option to either accept or refuse these cookies and know when a cookie is being "
                "sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
  Widget _buildTitle4() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Services Provider",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "We may employ third-party companies and individuals due to the following reasons",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(". To facilitate our Service;",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(". To provide the Service on our behalf;",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(". To perform Service-related services;",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(". To assist us in analyzing how our Service is used.",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text("We want to inform users of this Service that these third parties have"
              " access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf."
              " However, they are obligated not to disclose or use the information for any other purpose.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
  Widget _buildTitle5() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Security",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "We value your trust in providing us your Personal Information, thus we are striving to use"
                " commercially acceptable means of protecting it. But remember that no method of transmission"
                " over the internet, or method of electronic storage is 100% secure and reliable,"
                " and we cannot guarantee its absolute security",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
  Widget _buildTitle6() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Links to Other Sites",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "This Service may contain links to other sites. If you click on a third party"
                " link, you will be directed to that site. Note that these external sites "
                "are not operated by us. Therefore, we strongly advise you to review the "
                "Privacy Policy of these websites. We have no control over and assume no responsibility "
                "for the content, privacy policies, or practices of any third-party sites or services.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
  Widget _buildTitle7() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Children's Privacy ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable"
                " information from children under 13. In the case we discover that a child under 13 has provided us with"
                " personal information, we immediately delete this from our servers. If you are a parent or guardian and "
                "you are aware that your""child has provided us with personal information, please contact "
                "us so that we will be able to do necessary actions.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
  Widget _buildTitle8() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Changes to This Privacy Policy ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "We may update our Privacy Policy from time to time. Thus, you are advised to "
                "review this page periodically for any changes. We will notify you of any changes"
                " by posting the new Privacy Policy on this page. These changes are effective immediately "
                "after they are posted on this page.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
  Widget _buildTitle9() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Us",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "If you have any questions or suggestions about our Privacy Policy,"
                " do not hesitate to contact us at info@legend.com.kh.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }


}
