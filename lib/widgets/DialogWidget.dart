import 'package:flutter/material.dart';
import 'package:flutter_catatan/theme.dart';
import 'package:flutter_catatan/widgets/ButtonWidget.dart';

class DialogWidget {
  static getDialogWidget(BuildContext context, List<Widget> children,
      {bool barrierDismissible = true}) {
    return showGeneralDialog(
        barrierLabel: "Barrier",
        barrierDismissible: barrierDismissible,
        barrierColor: Colors.black.withOpacity(0.8),
        transitionDuration: const Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, _, __) {
          return SafeArea(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.all(padding2XL),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(paddingL),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(paddingXL),
                          shrinkWrap: true,
                          children: children,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static getInfoDialog(
    BuildContext context,
    String message,
  ) {
    DialogWidget.getDialogWidget(
        context,
        [
          Column(
            children: [
              const SizedBox(
                height: paddingXL,
              ),
              Text(
                "Pemberitahuan",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: paddingL,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: paddingS,
              ),
              ButtonWidget(
                isFull: true,
                textButton: "Tutup",
                onTap: () => Navigator.pop(context),
                backgroundColor: primaryColor,
              ),
            ],
          )
        ],
        barrierDismissible: true);
  }

  static getErrorDialog(BuildContext context, String message,
      {bool barrierDismissible = true, Function()? onButtonCloseClick}) {
    DialogWidget.getDialogWidget(
        context,
        [
          Column(
            children: [
              const SizedBox(
                height: paddingXL,
              ),
              Text(
                "Error",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: paddingL,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: paddingS,
              ),
              ButtonWidget(
                isFull: true,
                textButton: "Tutup",
                onTap: () => Navigator.pop(context),
                backgroundColor: redColor,
              ),
            ],
          )
        ],
        barrierDismissible: barrierDismissible);
  }
}
