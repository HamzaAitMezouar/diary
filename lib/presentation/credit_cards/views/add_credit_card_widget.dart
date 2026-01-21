import 'dart:developer';

import 'package:diary/core/constants/border.dart';
import 'package:diary/core/constants/text_style.dart';
import 'package:diary/core/params/payment_params.dart';
import 'package:diary/presentation/credit_cards/controller/credit_cards_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/exports.dart';

class AddCreditCardWidget extends ConsumerStatefulWidget {
  const AddCreditCardWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AddCreditCardWidgetState();
}

class AddCreditCardWidgetState extends ConsumerState<AddCreditCardWidget> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(children: <Widget>[
        CreditCardWidget(
          cardType: CardType.visa,
          textStyle: TextStyles.robotoBold15.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
          enableFloatingCard: true,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          //bankName: 'Bank',
          showBackView: isCvvFocused,
          obscureCardNumber: true,
          obscureCardCvv: true,
          isHolderNameVisible: true,
          cardBgColor: Theme.of(context).cardColor,
          //   backgroundImage: Assets.avatarholder,
          isSwipeGestureEnabled: true,
          onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
          customCardTypeIcons: <CustomCardTypeIcon>[
            cardNumber.startsWith("4")
                ? CustomCardTypeIcon(
                    cardType: CardType.visa,
                    cardImage: Image.asset(
                      Assets.visa,
                      height: 40,
                      width: 40,
                    ),
                  )
                : CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      Assets.mastercard,
                      height: 40,
                      width: 40,
                    ),
                  ),
          ],
        ),
        Column(
          children: <Widget>[
            CreditCardForm(
              formKey: formKey,
              obscureCvv: true,
              obscureNumber: false,
              cardNumber: cardNumber,
              cvvCode: cvvCode,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              cardHolderName: cardHolderName,
              expiryDate: expiryDate,
              inputConfiguration: InputConfiguration(
                cvvCodeTextStyle: TextStyles.robotoBold13,
                cardNumberTextStyle: TextStyles.robotoBold13,
                cardHolderTextStyle: TextStyles.robotoBold13,
                expiryDateTextStyle: TextStyles.robotoBold13,
                cardNumberDecoration: InputDecoration(
                  labelText: 'Number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                  hintStyle: TextStyles.robotoBold13,
                  labelStyle: TextStyles.robotoBold13,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                expiryDateDecoration: InputDecoration(
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                  counterStyle: TextStyles.robotoBold13,
                  hintStyle: TextStyles.robotoBold13,
                  labelStyle: TextStyles.robotoBold13,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                cvvCodeDecoration: InputDecoration(
                  labelText: 'CVV',
                  hintText: 'XXX',
                  hintStyle: TextStyles.robotoBold13,
                  labelStyle: TextStyles.robotoBold13,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                cardHolderDecoration: InputDecoration(
                    labelText: 'Card Holder',
                    hintStyle: TextStyles.robotoBold13,
                    labelStyle: TextStyles.robotoBold13,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    )),
              ),
              onCreditCardModelChange: onCreditCardModelChange,
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _onValidate(ref);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[AppColors.activeButtonColor, AppColors.blue],
                    begin: Alignment(-1, -4),
                    end: Alignment(1, 4),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: Text('Validate', style: TextStyles.montserratBold13),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  void _onValidate(WidgetRef ref) {
    if (formKey.currentState?.validate() ?? false) {
      log(expiryDate.toString());
      // ref.read(paymentMethodsProvider.notifier).addPaymentMethod(
      //   SaveCardParams(cardNumber: cardNumber, cvc: cvvCode, expMonth: expMonth, expYear: expYear)
      // )
    } else {
      print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
