import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../../../core/constant/phone/phone_size.dart';
import '../../../../core/services/auth_validator.dart';

class NavigateToPageBottomSheet extends StatefulWidget {
  const NavigateToPageBottomSheet({
    Key? key,
    required this.pdfController,
    required this.currentPage,
    required this.lastPage,
  }) : super(key: key);

  final PDFViewController pdfController;
  final int currentPage;
  final int lastPage;
  @override
  NavigateToPageBottomSheetState createState() =>
      NavigateToPageBottomSheetState();
}

class NavigateToPageBottomSheetState extends State<NavigateToPageBottomSheet> {
  final TextEditingController _pageNumberTextEditing = TextEditingController();
  final _pageNumberForm = GlobalKey<FormState>();
  @override
  void dispose() {
    _pageNumberTextEditing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _pageNumberForm,
      child: SizedBox(
        height: getScreenHeight(context) * .4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              Text(
                "ادخل رقم الصفحة لتنتقل اليها",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _pageNumberTextEditing,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                onFieldSubmitted: (value) async {
                  if (_pageNumberForm.currentState!.validate()) {
                    Navigator.of(context).pop();
                    await widget.pdfController
                        .setPage(int.parse(_pageNumberTextEditing.text) - 1);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: Text("${widget.currentPage} / ${widget.lastPage}"),
                ),
                validator: (value) {
                  if (!HandleValidation()
                      .validatePageNumber(value!, widget.lastPage)) {
                    return 'Invalid page number or exceeds limit';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 140,
                    // height: 120,
                    child: FilledButton.tonal(
                      onPressed: () async {
                        if (_pageNumberForm.currentState!.validate()) {
                          Navigator.of(context).pop();
                          await widget.pdfController.setPage(
                              int.parse(_pageNumberTextEditing.text) - 1);
                        }
                      },
                      child: const Text("انتقال"),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 70,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                        ),
                      ),
                      child: const Text("إلغاء"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
