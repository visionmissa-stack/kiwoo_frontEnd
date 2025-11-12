import 'dart:async';
import 'dart:io';

import 'package:kiwoo/app/data/models/storage_box_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../core/utils/app_utility.dart';
import '../core/utils/storage_pro.dart';
import '../data/app_service_provider.dart';
import '../data/models/account_balance.dart';
import '../data/models/chat_model.dart';
import '../data/models/notifications/notification_model.dart';
import '../data/models/server_response_model.dart';
import '../data/models/user_detail_model.dart';
import '../data/models/user_model.dart';
import '../routes/app_pages.dart';
import 'firebase_services.dart';

class AppServicesController extends GetxService
    with WidgetsBindingObserver, StorageBox {
  late final AppServiceProvider provider;
  // late String? fmcToken;
  late final RxInt totalUnReadMessage;
  late final RxString errorMsg;
  late Rx<UserDetailModel?> userDetails;
  late Rx<UserDetailModel?> acountBalance;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  Worker? errorWorker;
  RxBool connectionStatus = false.obs;
  RxList<NotificationModel> get notifications =>
      Get.find<FirebaseServices>().notifications;
  String? get firebaseToken => Get.find<FirebaseServices>().token;

  @override
  void onInit() {
    provider = Get.put(AppServiceProvider(), permanent: true);
    errorMsg = ''.obs;
    errorWorker = ever(errorMsg, (msg) {
      showMsg(msg, color: Colors.red);
    }, condition: () => errorMsg.isNotEmpty);
    var currentUser = getObjectById<CurrentUser>('currentUser');
    userDetails = Rx<UserDetailModel?>(currentUser?.userDetails);
    totalUnReadMessage = RxInt(
      getAllObjects<ChatModel>().fold(
        0,
        (value, current) => value + current.count,
      ),
    );
    addKeysListenter();
    // _startMonitoring();
    super.onInit();
  }

  @override
  void onReady() {
    if (userDetails.value != null) {
      addCurrentUserListener();
      if (StorageBox.token.val.isNotEmpty) getUserDetails();
    }
    super.onReady();
  }

  @override
  void onClose() async {
    errorWorker?.dispose();
    _subscription.cancel();
    await Get.delete<AppServiceProvider>(force: true);
    super.onClose();
  }

  Future<ServerResponseModel?> getUserDetails() async {
    var response = await provider.getUserDetails();
    if (response?.isSuccess == true) {
      saveUserData(UserDetailModel.fromMap(response!.data!));
    }
    return response;
  }

  void addKeysListenter() {
    StorageBox.boxKeys().listenKey("token", (value) {
      if (value == null) {
        if (Get.currentRoute != Routes.CONNECTION) {
          Get.offAllNamed(Routes.CONNECTION);
        }
      } else if (Get.currentRoute.contains(Routes.CONNECTION)) {
        Get.offAllNamed(Routes.HOME);
      }
    });
    StorageBox.boxKeys().listenKey("fmcToken", (value) {
      updateTokenProvider();
    });
  }

  void addCurrentUserListener() {
    GetStoragePro.listenForObjectChanges<CurrentUser>(
      id: 'currentUser',
      onData: (model) {
        userDetails.value = model?.userDetails;
      },
    );
    GetStoragePro.listenAllObjects<ChatModel>(
      onData: (data) {
        totalUnReadMessage.value = data.fold(
          0,
          (value, current) => value + current.count,
        );
      },
    );
  }

  void saveUserData(UserDetailModel? userDetails) {
    if (userDetails != null &&
        userDetails.hasNotificationToken != StorageBox.fmcToken.val) {
      updateTokenProvider();
    }
    var currentUser = CurrentUser(userDetails: this.userDetails.value);

    GetStoragePro.saveObject<CurrentUser>(
      currentUser.copyWith(userDetails: userDetails),
    );
    if (this.userDetails.value == null) {
      addCurrentUserListener();
    }
  }

  void saveMessage(ChatModel chat) {
    GetStoragePro.saveObject<ChatModel>(chat);
  }

  void saveListMessage(List<ChatModel> chats) {
    GetStoragePro.saveObjectsList<ChatModel>(chats);
  }

  Future<void> clearCurrentUser() async {
    try {
      GetStoragePro.saveObject<CurrentUser>(CurrentUser());
      GetStoragePro.deleteAllObjects<ChatModel>();
      await StorageBox.removeToken();
    } catch (e) {
      Get.log("the error >>> $e", isError: true);
    }
  }

  //connection checker
  _startMonitoring() async {
    await _initConnectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) async {
      ConnectivityResult result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;
      if (result == ConnectivityResult.none) {
        connectionStatus.value = false;
      } else {
        await _updateConnectionStatus().then((bool isConnected) {
          connectionStatus.value = isConnected;
        });
      }
    });
  }

  Future<void> _initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status.first == ConnectivityResult.none) {
        connectionStatus.value = false;
      } else {
        connectionStatus.value = true;
      }
    } on PlatformException catch (e) {
      Get.log("PlatformException: $e", isError: true);
    }
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected = false;
    print("lokopp");
    try {
      final List<InternetAddress> result = await InternetAddress.lookup(
        'google.com',
      );
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      //return false;
    }
    return isConnected;
  }

  Future<List<AccountBalanceModel>?> getUserBalance() async {
    var response = await provider.getUserBalance();
    if (response?.isSuccess == true) {
      return listAccountModelFromMap(response!.data);
    }
    return null;
  }

  Future<void> updateTokenProvider() async {
    bool isSuccessFull = false;
    if (StorageBox.token.val.isNotEmpty) {
      do {
        if (StorageBox.token.val.isNotEmpty) {
          var response = await provider.updateFMCToken(
            token: StorageBox.fmcToken.val,
          );
          isSuccessFull = response?.isSuccess == true;
        }
        await 10.delay();
      } while (!isSuccessFull);
    }
  }
}
