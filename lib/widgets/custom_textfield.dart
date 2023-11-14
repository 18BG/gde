import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyFields extends StatefulWidget {
  MyFields(
      {this.hide,
      this.maxl,
      this.hint,
      this.onsave,
      this.suffix,
      this.toChange,
      this.f,
      this.onChange,
      this.prefix,
      this.labelText,
      this.icon,
      this.border,
      this.iconColor,
      this.keyboardTyp,
      super.key});

  TextEditingController? toChange;

  String? hint;
  TextInputType? keyboardTyp;
  Color? iconColor;
  int? maxl;
  String? labelText;
  bool? suffix;
  bool? prefix;
  IconData? icon;
  String? onsave;
  bool? hide;
  String? Function(String?)? f;
  bool? border;
  void Function(String)? onChange;
  @override
  State<MyFields> createState() => _TextFormFieldsState();
}

class _TextFormFieldsState extends State<MyFields> {
  bool? validation;

  String? validationreturn;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardTyp ?? TextInputType.text,
      onChanged: widget.onChange,
      controller: widget.toChange,
      obscureText: widget.hide ?? true,
      maxLines: (widget.maxl != null) ? widget.maxl : 1,
      validator: widget.f,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.labelText,
        border:
            (widget.border ?? false) ? OutlineInputBorder() : InputBorder.none,
        suffixIcon: (widget.suffix ?? false)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.hide = !(widget.hide ?? true);
                  });
                },
                icon: (widget.hide ?? true)
                    ? Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      )
                    : Icon(
                        Icons.visibility,
                        color: Colors.green,
                      ),
              )
            : null,
        prefixIcon: (widget.prefix ?? false)
            ? Icon(
                widget.icon,
                color: widget.iconColor,
              )
            : null,
      ),
    );
  }
}
