import 'package:flutter/material.dart';

class ContainerFrame extends StatelessWidget {
  const ContainerFrame({
    super.key,
    required this.column,
  });

  final Widget column;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1),
            blurRadius: 5,
          ),
        ],
      ),
      child: column,
    );
  }
}
