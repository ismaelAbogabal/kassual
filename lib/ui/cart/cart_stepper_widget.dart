import 'package:flutter/material.dart';
import 'package:kassual/ui/cart/step_widget.dart';

class _Steps {
  final String name;
  final int order;
  const _Steps(this.name, this.order);
  static const _Steps cart = _Steps("Cart", 0);
  static const _Steps address = _Steps("Address", 1);
  static const _Steps shipping = _Steps("Shipping", 2);
  static const _Steps checkout = _Steps("Checkout", 3);

  static const List<_Steps> steps = [cart, address, shipping, checkout];
}

final kCartStepperHeroTag = "**-cart_stepper_hero_tag--**";

class CartStepper extends StatelessWidget {
  final int currentStep;

  const CartStepper({
    Key key,
    @required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: kCartStepperHeroTag,
      child: Row(
        children: _Steps.steps
            .map<Widget>((e) => Expanded(
                  child: StepWidget(
                    text: Text(e.name),
                    currentStep: currentStep,
                    step: _Steps.steps.indexOf(e),
                  ),
                ))
            .toList()
              ..add(SizedBox(width: 50)),
      ),
    );
  }
}
