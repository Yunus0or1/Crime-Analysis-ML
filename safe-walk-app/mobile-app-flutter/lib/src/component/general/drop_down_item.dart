import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DropDownItem extends StatelessWidget {
  final List<dynamic>? dropDownList;
  final dynamic selectedItem;
  final Function()? callBackRefreshUI;
  final Function(dynamic value)? setSelectedItem;
  final Function()? callBackAdditional;
  final BoxDecoration? boxDecoration;
  final double? height;
  final Color? dropDownContainerColor;
  final Color? dropDownTextColor;
  final EdgeInsets? padding;
  final double? iconSize;
  final Color? iconColor;
  final double? textFontSize;

  const DropDownItem(
      {Key? key,
      this.callBackRefreshUI,
      this.dropDownList,
      this.selectedItem,
      this.setSelectedItem,
      this.callBackAdditional,
      this.boxDecoration,
      this.height,
      this.dropDownContainerColor,
      this.dropDownTextColor,
      this.padding,
      this.iconSize,
      this.iconColor,
      this.textFontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildDropdown();
  }

  Widget buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: padding ?? EdgeInsets.all(0),
          decoration: boxDecoration ??
              BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black),
                ),
                color: Colors.transparent,
              ),
          height: height ?? 35,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              iconSize: iconSize ?? 26,
              iconEnabledColor: iconColor ?? Colors.black,
              dropdownColor: dropDownContainerColor ?? Colors.white,
              isDense: true,
              isExpanded: true,
              value: selectedItem,
              onChanged: (value) {
                if (value == null) return;
                setSelectedItem!(value);
                callBackRefreshUI!();
                if (callBackAdditional != null) {
                  callBackAdditional!();
                }
              },
              items: dropDownList!.map((item) {
                return buildDropDownMenuItem(item);
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  DropdownMenuItem<dynamic> buildDropDownMenuItem(dynamic menuItem) {
    return DropdownMenuItem(
      value: menuItem,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Text(
              getObjectText(menuItem)!,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: dropDownTextColor ?? Colors.black,
                  fontSize: textFontSize ?? 15),
            ),
          ),
        ],
      ),
    );
  }

  String? getObjectText(dynamic menuItem) {
    switch (menuItem.runtimeType.toString()) {
      case 'Airport':
        return menuItem.latitude;
      default:
        return menuItem;
    }
  }
}
