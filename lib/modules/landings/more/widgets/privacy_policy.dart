import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
        title: TextWidget(S.of(context).privacy_policy, bold: true, size: 22,),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: AppColor.primaryColor,
      body: _buildBody([
        _buildPrivacyPolicyText(),
        const Gap(14),
        _buildInfoCollectionText(),
        _buildServiceProviderText(),
        _buildSecurityText(),
        _buildLikeOtherSiteText(),
        _buildChidrenPrivacy(),
        _buildChangePrivacyPolicyText(),
        _buildContactText(context),
      ], context),
    );
  }

  Widget _buildBody(List<Widget> content, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            S.of(context).privacy_policy,
            size: 20,
            bold: true
          ),
          ...content,
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicyText() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextWidget(
        "     Vista Entertainment built the Legend Cinema app as a Free app. "
        "This SERVICE is provided by Vista Entertainment "
        "at no cost and is intended for use as is.\n\n"
        "     This page is used to inform vistors regarding our "
        "policies with the collection, use and disclosure"
        "of Personal Information of anyone decided to use our Service.\n\n"
        "    If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. "
        "The Personal Information that we collect is used for providing and improving the Service. "
        "We will not use or share your information with anyone except as described in this Privacy Policy.\n\n"
        "    The terms used in this Privacy Policy have the same meanings as "
        "in our Terms and Conditions, which is accessible at Legend Cinema unless otherwise defined in this Privacy Policy.",
      ),
    );
  }

  Widget _buildInfoCollectionText() {
    return Padding(
      padding: const EdgeInsets.only(left: 2, top: 8.0, bottom: 8.0, ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: TextWidget(
              "Information Collection and Use",
              size: 20,
              bold: true,
            ),
          ),
          const Gap(10),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "    For a better experience, while using our Service,"
                      " we may require you to provide us with certain personally "
                      "identifiable information. The information that we request "
                      "will be retained by us and used as described in this privacy policy.\n   "
                      " The app does use third party services that may collect information used to identify you."
                      " Link to privacy policy of third party service providers used by the app ",
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () async {
                      const url = 'https://play.google.com/store/apps/details?id=com.google.android.gms';
                      // ignore: deprecated_member_use
                      if (await canLaunch(url)) {
                        // ignore: deprecated_member_use
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Google Play Services.',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
          TextWidget(
            "Log Data",
            size: 20,
            bold: true,
          ),
          Gap(10),
          TextWidget(
            "     We want to inform you that whenever you use our Service, in a case of an error in the app we"
            " collect data and information (through third party products) on your phone called Log Data."
            " This Log Data may include information such as your device Internet Protocol "
            "IP address, device name, operating system version, the configuration of the app"
            " when utilizing our Service, the time and date of your "
            "use of the Service, and other statistics.",
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
          TextWidget(
            "Cookies",
            size: 20,
            bold: true,
          ),
          Gap(10),
          TextWidget(
            "     Cookies are files with a small amount of data that are commonly used "
            "as anonymous unique identifiers. These are sent to your browser from the "
            "websites that you visit and are stored on your device's internal memory.\n\n"
            "     This Service does not use these cookies explicitly. However, the app may use third "
            "party code and libraries that use cookies to collect information and improve their services. "
            "You have the option to either accept or refuse these cookies and know when a cookie is being "
            "sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.",
          ),
        ],
      ),
    );
  }

  Widget _buildServiceProviderText() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            "Services Provider",
            bold: true,
            size: 20,
          ),
          Gap(10),
          TextWidget(
            "     We may employ third-party companies and individuals due to the following reasons\n"
            "     ${AppConstant.inlineSeparator} To facilitate our Service;\n"
            "     ${AppConstant.inlineSeparator} To provide the Service on our behalf;\n"
            "     ${AppConstant.inlineSeparator} To perform Service-related services;\n"
            "     ${AppConstant.inlineSeparator} To assist us in analyzing how our Service is used.\n"
            "\n     We want to inform users of this Service that these third parties have"
            " access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf."
            " However, they are obligated not to disclose or use the information for any other purpose.",
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityText() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            "Security",
            size: 20,
            bold: true,
          ),
          Gap(10),
          TextWidget(
            "     We value your trust in providing us your Personal Information, thus we are striving to use"
            " commercially acceptable means of protecting it. But remember that no method of transmission"
            " over the internet, or method of electronic storage is 100% secure and reliable,"
            " and we cannot guarantee its absolute security",
          ),
        ],
      ),
    );
  }

  Widget _buildLikeOtherSiteText() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            "Links to Other Sites",
            size: 20,
            bold: true,
          ),
          Gap(10),
          TextWidget(
            "     This Service may contain links to other sites. If you click on a third party"
            " link, you will be directed to that site. Note that these external sites "
            "are not operated by us. Therefore, we strongly advise you to review the "
            "Privacy Policy of these websites. We have no control over and assume no responsibility "
            "for the content, privacy policies, or practices of any third-party sites or services.",
          ),
        ],
      ),
    );
  }

  Widget _buildChidrenPrivacy() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            "Children's Privacy ",
            size: 20,
            bold: true,
          ),
          Gap(10),
          TextWidget(
            "     These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable"
            " information from children under 13. In the case we discover that a child under 13 has provided us with"
            " personal information, we immediately delete this from our servers. If you are a parent or guardian and "
            "you are aware that your""child has provided us with personal information, please contact "
            "us so that we will be able to do necessary actions.",
          ),
        ],
      ),
    );
  }

  Widget _buildChangePrivacyPolicyText() {
    return const Padding(
      padding: EdgeInsets.only(left: 2, top: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            "Changes to This Privacy Policy ",
            bold: true,
            size: 20,
          ),
          Gap(10),
          TextWidget(
            "     We may update our Privacy Policy from time to time. Thus, you are advised to "
            "review this page periodically for any changes. We will notify you of any changes"
            " by posting the new Privacy Policy on this page. These changes are effective immediately "
            "after they are posted on this page.",
          ),
        ],
      ),
    );
  }

  Widget _buildContactText(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 2, top: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            S.of(context).contact_us,
            size: 20,
            bold: true,
          ),
          const Gap(10),
          const TextWidget(
            "     If you have any questions or suggestions about our Privacy Policy,"
            " do not hesitate to contact us at info@legend.com.kh.",
          ),
        ],
      ),
    );
  }
}
