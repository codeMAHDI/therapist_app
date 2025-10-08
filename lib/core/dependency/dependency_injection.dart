import 'package:counta_flutter_app/view/components/custom_Controller/custom_controller.dart';
import 'package:counta_flutter_app/view/screens/authentication/controller/auth_controller.dart';
import 'package:counta_flutter_app/view/screens/chat_screen/controller/chat_controller.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/controller/therapist_profile_controller.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/controller/chat_controller.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/controller/user_my_booking_controller.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/controller/therapist_home_controller.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_chat_screen/controller/user_chat_controller.dart';
import 'package:get/get.dart';
import '../../view/components/custom_image_add_send/custom_image_add_send_controller.dart';
import '../../view/screens/testing_view/testing_controller.dart';
import '../../view/screens/therapist_part_screen/controller/therapist_register_controller.dart';
import '../../view/screens/therapist_part_screen/view/subscription_screen/controller/subscription_controller.dart';
import '../../view/screens/therapist_part_screen/view/therapist_profile_screen/specialization_screen_01/controller/speciality_controller.dart';
import '../../view/screens/user_part_screen/controller/user_home_controller.dart';
import '../../view/screens/user_part_screen/view/notification_screen/controller/notification_controller.dart';
import '../../view/screens/user_part_screen/view/popular_doctor_screen/controller/popular_doctor_controller.dart';
import '../../view/screens/user_part_screen/view/user_profile_screen/about_us_screen/controller/about_controller.dart';
import '../../view/screens/user_part_screen/view/user_profile_screen/edit_profile_screen/controller/edit_profile_controller.dart';
import '../../view/screens/user_part_screen/view/user_profile_screen/your_wallet_screen/controller/wallet_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
    Get.lazyPut(() => CustomController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => TherapistHomeController(), fenix: true);
    Get.lazyPut(() => UserMyBookingController(), fenix: true);
    Get.lazyPut(() => UserHomeController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => TherapistProfileController(), fenix: true);
    Get.lazyPut(() => AboutController(), fenix: true);
    Get.lazyPut(() => SubscriptionController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => PopularDoctorController(), fenix: true);
    Get.lazyPut(() => CustomImageAddSendController(), fenix: true);
    Get.lazyPut(() => WalletController(), fenix: true);
    Get.lazyPut(() => SpecialityController(), fenix: true);
    Get.lazyPut(() => TestingController(), fenix: true);
    Get.lazyPut(() => TherapistChatController(), fenix: true);
    Get.lazyPut(() => EditProfileController(), fenix: true);
    Get.lazyPut(() => UserChatController(), fenix: true);
    Get.lazyPut(() => TherapistRegisterController(), fenix: true);
  }
}
