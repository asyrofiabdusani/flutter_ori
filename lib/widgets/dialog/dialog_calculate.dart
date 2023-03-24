import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'package:flutter_ori/widgets/table/paginated_1.dart';
import 'package:flutter_ori/widgets/table/table_1.dart';

class DialogCalculate extends StatelessWidget {
  /* final double dialogWidth;
  final double dialogHeight;
  final String dialogImg;
  final double dialogImgWidth;
  final double dialogImgHeight;
  final String dialogTopText;
  final String dialogBottomText;
  final String primaryBtText;
  final String secondaryBtText;
  final bool primaryBtIsShow;
  final bool secondaryBtIsShow;
  final VoidCallback primaryCallback;
  final VoidCallback secondaryCallback; */

  const DialogCalculate({
    Key? key,
    /* required this.dialogWidth,
      required this.dialogHeight,
      required this.dialogImg,
      required this.dialogImgWidth,
      required this.dialogImgHeight,
      required this.dialogTopText,
      required this.dialogBottomText,
      required this.primaryBtText,
      required this.secondaryBtText,
      required this.primaryBtIsShow,
      required this.secondaryBtIsShow,
      required this.primaryCallback,
      required this.secondaryCallback */
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(44),
        child: SizedBox(
          width: 1077,
          height: 711,
          // width: dialogWidth,
          // height: dialogHeight,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Pastikan Anda sudah melakukan pengecekan'),
              Divider(color: Color(0xffD0D5DD)),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'images/60875-confuse-person-1.png',
                        width: 250,
                        height: 250,
                        // dialogImg,
                        // width: dialogImgWidth,
                        // height: dialogImgHeight,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AdTextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Estimasi Tanggal Pesrsetujuan')),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AdTextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Pertanggungan Asuransi')),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AdTextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Own Risk')),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AdTextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Total Due')),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AdTextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Estimasi Nilai Klaim')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const TableFirst(),
              const SizedBox(height: 24),
              Row(
                children: [
                  FilledButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.fromLTRB(24, 8, 24, 8)),
                      backgroundColor: const MaterialStatePropertyAll(
                          adrColor.backgroundBaseLight),
                      foregroundColor: const MaterialStatePropertyAll(
                          adrColor.textButtonSecondary),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                              width: 1,
                              color: adrColor.backgroundButtonInfoSelected),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: adrFont.button1FontSize,
                        fontWeight: FontWeight.w600,
                      ),
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
