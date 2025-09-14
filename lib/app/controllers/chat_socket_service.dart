import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../core/utils/enums.dart';
import '../data/chat_service_provider.dart';
import 'def_controller.dart';

class ChatSocketService extends GetxController with DefController {
  late final ChatServiceProvider chatProvider;
  late Socket? _socket;
  Rx<SocketStatus> socketStatus = Rx<SocketStatus>(SocketStatus.connecting);

  final count = 0.obs;
  @override
  void onInit() {
    chatProvider = Get.put(ChatServiceProvider());
    _socket = chatProvider.getSocket();
    super.onInit();
  }

  Future<Socket?> initializeSocket() async {
    try {
      _socket?.onConnectError((data) {
        socketStatus.value = SocketStatus.disconnected;
        Get.log("socket error connect sockkk $data ");
      });
      _socket?.onReconnectAttempt((p) {
        socketStatus.value = SocketStatus.reconnecting;

        Get.log("--------Try Reconnecting $p -----------");
      });
      _socket?.connect();
      return _socket;
    } catch (e) {
      Get.log("--------initializeSocket Catch $e -----------");
    }
    return null;
  }

  void listenSocket() {
    _socket?.onReconnectAttempt((p) {
      socketStatus.value = SocketStatus.reconnecting;

      Get.log("--------Try Reconnecting $p -----------");
    });
  }

  void listenWithSocket(String event, dynamic fn) async {
    try {
      Get.log(
          "--------listenWithSocket try $event ----------- \nSocket Disconnected: ${_socket?.disconnected}");

      if (_socket?.disconnected ?? true) await initializeSocket();

      Get.log(
          "--------listenWithSocket Try connectSocket-----------\nConnection Status: ${_socket?.connected}");
      _socket?.on(event, fn);
      // disconnectSocket();
    } catch (e) {
      Get.log("--------listenWithSocket catch $e -----------\n$event");
    }
  }

  void emitWithSocket(
    String event,
    Map data, {
    Function? ack,
    bool binary = false,
  }) async {
    try {
      if (_socket?.disconnected ?? true) await initializeSocket();

      Get.log(
          "--------emitWithSocket Try connectSocket  -----------\nConnection Status: ${_socket?.connected}");

      _socket?.emitWithAck(event, data, ack: ack, binary: binary);
      Get.log("--------emitWithSocket try emitted-----------\n$event $data");
      // disconnectSocket();
      // log("--------emitWithSocket Try disconnectSocket -----------");
    } catch (e) {
      Get.log("--------emitWithSocket catch $e -----------\n$event $data");
    }
  }

  cleanUpSocket() {
    try {
      _socket?.clearListeners();
      _socket?.disconnect();
      _socket?.close();
      _socket?.destroy();
      _socket = null;
      Get.log('cleanUpSocket $_socket');
    } catch (e) {
      Get.log(e.toString());
    }
  }

  @override
  void onClose() {
    cleanUpSocket();
    super.onClose();
  }
}
