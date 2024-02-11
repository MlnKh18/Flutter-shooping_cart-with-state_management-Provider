import 'package:flutter/material.dart';

class ShowSnackbar extends StatelessWidget {
  const ShowSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: const Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }
}
