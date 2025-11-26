import 'dart:async';

import 'package:kiwoo/app/controllers/app_services_controller.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

import '../../api_helper/app_exception.dart';

FutureOr<T?> tryCatch<T>(FutureOr<T> Function() doaction) async {
  final appService = Get.find<AppServicesController>();
  try {
    appService.errorMsg.value = '';
    await Future.delayed(const Duration(seconds: 1));
    var response = await doaction();
    return response;
  } on FetchDataException catch (e) {
    appService.errorMsg.value = e.getMessage();
    // showMsg(e.getMessage(), color: Colors.red);
    // print("the response 2 ${e.getMessage()}");
    // throw e;
  } on UnauthorisedException catch (e) {
    if (e.getPrefix() == 0) {
      await appService.clearCurrentUser();
    }
    appService.errorMsg.value = e.getMessage();

    // showMsg(e.getMessage(), color: Colors.red);

    // throw e;
  } catch (e) {
    Get.log("its an error $e", isError: true);
    appService.errorMsg.value = "Unknow Error : $e";

    // throw e;
  }
  return null;
}
