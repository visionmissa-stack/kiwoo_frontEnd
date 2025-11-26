import 'package:kiwoo/app/controllers/def_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

import 'package:kiwoo/app/data/models/contact_list_model.dart';
import 'package:kiwoo/app/modules/loans/providers/loan_provider.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_string.dart';
import '../core/utils/font_family.dart';
import '../core/utils/formatters/extension.dart'
    show PhoneExtention, PhoneExtention2;
import '../core/utils/image_name.dart';
import '../core/utils/kiwoo_icons.dart';
import '../data/models/server_response_model.dart';
import '../modules/home/controllers/functions.dart' show divideList;
import 'app_button.dart';
import 'avatar_network_image.dart';
import 'list_builder_widget.dart';

class ContactListController extends GetxController with DefController {
  late final RxString search;
  late final RxList<ContactData> listContacts;
  late final LoanProvider provider;
  List<String> contacts = [];

  @override
  void onInit() {
    search = RxString('');
    provider = Get.put(LoanProvider());
    listContacts = RxList<ContactData>.empty(growable: true);

    super.onInit();
  }

  List<ContactData> searchContact(List<ContactData>? items, String search) {
    if (search.trim().isEmpty) return items ?? [];
    var reg = RegExp(search, caseSensitive: false);
    var result = (items ?? <ContactData>[])
        .where(
          (el) =>
              reg.hasMatch('${el.name}') ||
              reg.hasMatch('${el.email}') ||
              reg.hasMatch('${el.phone}'),
        )
        .toList();

    return result;
  }

  Future<List<ContactData>> contactListApiCall({
    String? search,
    int? id,
    String? callingme,
  }) async {
    ServerResponseModel? response;
    if (id == null) {
      var contactsData = await getContactFromPhone();

      List<String> contacts = contactsData[0];
      final Map? otherContacts = contactsData[1];

      if (otherContacts?.isNotEmpty == true) {
        await provider.contactListSAVEApi(otherContacts!);
      }
      if (search?.isNotEmpty == true) {
        var reg = RegExp(search!, caseSensitive: false);
        contacts = contacts.where((el) => reg.hasMatch(el)).toList();
      }
      if (search?.isValidPhone == true) {
        var searchNumber = search!.getValidNumber;
        contacts.addIf(() => !contacts.contains(searchNumber), searchNumber);
      }

      if (contacts.isEmpty) return [];

      var list = await Future.wait<ServerResponseModel?>([
        ...divideList(contacts, 20).map((el) {
          return provider.contactListApi(el);
        }),
      ]);
      response = list.reduce((result, current) {
        if (current?.isSuccess == true) {
          return current!..data.addAll(result?.data ?? []);
        }
        return result;
      });
    } else {
      response = await provider.loantactListApi(id.toString());
    }

    if (response?.isSuccess == true) {
      return listContactFromListMap(response!.data);
    }

    return [];
  }

  Future<List> getContactFromPhone() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      if (this.contacts.isNotEmpty) {
        return [this.contacts, null];
      }
      List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true,
      );
      print(
        "the contacts ${contacts.firstWhere((el) => el.displayName.contains("Frantzly")).phones[2].normalised}",
      );
      var phones = phone == "50932973624"
          ? contacts.fold({}, (result, current) {
              var name = "${current.displayName}_${current.name}";
              result[name] = current.phones
                  .map((el) => el.normalised)
                  .join(", ");
              return result;
            })
          : null;
      var listValidPhone = contacts
          .mapMany((data) => data.phones)
          .fold<List<String>>([], (result, current) {
            if (current.isValidPhone && current.getValidNumber != phone) {
              result.add(current.getValidNumber);
            }
            return result;
          });
      this.contacts = listValidPhone;
      return [listValidPhone, phones];
    }
    return <String>[];
  }
}

class ContactListView extends GetWidget<ContactListController> {
  const ContactListView({
    super.key,
    this.onContactClick,
    this.onSubmit,
    this.loanId,
    this.hidePhoneNumber = false,
  }) : canSearch = false;
  const ContactListView.searchable({
    super.key,
    this.onContactClick,
    this.hidePhoneNumber = false,
    this.onSubmit,
    this.loanId,
  }) : canSearch = true;
  final int? loanId;
  final bool hidePhoneNumber;

  @override
  get controller => Get.put(ContactListController());

  final void Function(ContactData)? onContactClick;
  final bool canSearch;
  final void Function(List<ContactData>)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: canSearch
          ? ListBuilderWidget.futureWithSearch(
              onSearch: (value, data, refresh, isLoading) {
                var result = controller.searchContact(data, value);
                return result;
              },
              onEmptyText: "No Contacts Found",
              futureSearch: futureSearch,
              futureBuilder: futureBuilder,
              itemBuilder: itemBuilder,
            )
          : ListBuilderWidget.future(
              onEmptyText: "No Contacts Found",
              future: futureSearch,
              futureBuilder: futureBuilder,
              itemBuilder: itemBuilder,
            ),
    );
  }

  Future<List<ContactData>> futureSearch([search]) {
    return controller.contactListApiCall(
      search: search,
      id: loanId,
      callingme: "true",
    );
  }

  Widget futureBuilder(
    BuildContext p0,
    List<ContactData> listData,
    childFunction,
  ) {
    return Column(
      children: [
        Expanded(child: childFunction(listData)),
        AppButton(
          buttonText: AppStrings.SUBMIT,
          onTap: () {
            onSubmit?.call(listData);
          },
        ),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, ContactData item, refresh, [_]) {
    return Obx(
      () => ListTile(
        selected: item.isSelected.isTrue,
        selectedTileColor: AppColors.PRIMARY3,
        selectedColor: AppColors.APP_BAR_BG,
        onTap: () {
          onContactClick?.call(item);
        },
        tileColor: AppColors.APP_BG,
        leading: item.isSelected.isTrue
            ? const Icon(Kiwoo.ok_circled)
            : AspectRatio(
                aspectRatio: 1,
                child: ClipOval(
                  child: avatarImage(
                    item.avatar,
                    placeHolder: Center(child: Image.asset(ImgName.ELLIPSE_1)),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      );
                    },
                  ),
                ),
              ),
        title: Text(
          "${item.name}",
          style: TextStyle(fontFamily: FontPoppins.BOLD),
        ),
        subtitle: !hidePhoneNumber
            ? Text(
                "${item.phone}",
                style: TextStyle(fontFamily: FontPoppins.REGULAR),
              )
            : null,
      ),
    );
  }
}
