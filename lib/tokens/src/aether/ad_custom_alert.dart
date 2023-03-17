import 'package:flutter/material.dart';
import '../../dart/dart_color.dart';
import '../../dart/dart_font.dart';

class AdAlert extends StatefulWidget {
  AdAlert({
    super.key,
    this.alertType = Model.success,
    this.title = '',
    required this.message,
    this.showIcon = false,
    this.alertIcon,
    this.showCloseIcon = false,
    this.closeAction,
    this.width,
  });

  String title;
  final Widget message;
  final bool showIcon;
  final IconData? alertIcon;
  final bool showCloseIcon;
  final VoidCallback? closeAction;
  final double? width;
  Model alertType;

  @override
  State<AdAlert> createState() => _AdAlertState();
}

class _AdAlertState extends State<AdAlert> {
  @override
  Widget build(BuildContext context) {
    final IconData icon = widget.alertIcon ?? Icons.check;

    const double iconSize = 25;

    const IconData closeIcon = Icons.close;

    var effectiveAlertType = widget.alertType;
    Color alertTypeBorderColor = adrColor.borderSuccess;
    Color alertTypeColor = adrColor.backgroundSuccess;

    switch (effectiveAlertType) {
      case Model.success:
        {
          setState(() {
            alertTypeBorderColor = adrColor.borderSuccess;
            alertTypeColor = adrColor.backgroundSuccess;
          });
          // Color alertTypeBorderColor = adrColor.borderSuccess;
        }
        break;
      case Model.info:
        {
          setState(() {
            alertTypeBorderColor = adrColor.borderLink;
            alertTypeColor = adrColor.backgroundLink;
          });
          // Color alertTypeBorderColor = adrColor.borderLink;
        }
        break;
      case Model.warning:
        {
          setState(() {
            alertTypeBorderColor = adrColor.textWarning;
            alertTypeColor = adrColor.backgroundWarning;
          });
          // Color alertTypeBorderColor = adrColor.borderSuccess;
        }
        break;
      case Model.error:
        {
          setState(() {
            alertTypeBorderColor = adrColor.borderError;
            alertTypeColor = adrColor.backgroundError;
          });
          // Color alertTypeBorderColor = adrColor.borderLink;
        }
        break;
    }

    final Color effectiveAlertBorder = alertTypeBorderColor;

    final Text alertTitle = Text(
      widget.title,
      style: const TextStyle(
          fontSize: adrFont.h5FontSize,
          fontWeight: adrFont.weightMedium,
          color: adrColor.textNormal),
    );

    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    double alertWidth = widget.width ?? mediaQueryData.size.width - 20;
    // Set lebar minimal jadi 250
    if (alertWidth < 250) {
      alertWidth = 250;
    }

    Widget effectiveAlertTitle = Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 25,
          child: alertTitle,
        ),
        const SizedBox(
          height: 6,
        )
      ],
    );

    Widget effectiveAlertIcon = Row(
      children: [
        Icon(
          icon,
          color: alertTypeBorderColor,
          size: iconSize,
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );

    Widget closeButton = IconButton(
      splashRadius: 1,
      padding: const EdgeInsets.all(0),
      onPressed: widget.closeAction,
      icon: const Icon(
        closeIcon,
        size: 18,
      ),
    );
    const SizedBox(
      width: 10,
    );

    return Container(
      constraints: const BoxConstraints(minWidth: 250),
      width: alertWidth,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: alertTypeColor,
          border: Border.all(
            width: 1,
            color: alertTypeBorderColor,
          )),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: widget.showIcon ? effectiveAlertIcon : null,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: widget.title.isNotEmpty ? effectiveAlertTitle : null,
                  ),
                  SizedBox(
                    width: (alertWidth - iconSize - 108),
                    child: widget.message,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 25,
            width: 25,
            child: widget.showCloseIcon ? closeButton : null,
          )
        ],
      ),
    );
  }
}

enum Model {
  success,
  info,
  warning,
  error,
}
