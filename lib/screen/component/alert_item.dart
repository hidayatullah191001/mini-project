import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

Future AlertSucces(BuildContext context, String text) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.success,
    text: text,
  );
}

Future AlertInfo(BuildContext context, String text) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.info,
    text: text,
  );
}

Future AlertConfirm(BuildContext context, String text, dynamic func) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.confirm,
    text: text,
    onConfirmBtnTap: func,
  );
}

Future AlertError(BuildContext context, String text) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.error,
    text: text,
  );
}
