import 'package:flutter/material.dart';

import '../enums/status.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  Status status;
  final Function onRestart;

  ResultadoWidget({
    @required this.status,
    @required this.onRestart,
  });

  @override
  Size get preferredSize => Size.fromHeight(120);

  Color _getColor() {
    if (status == Status.venceu) {
      return Colors.green[300];
    } else if (status == Status.perdeu) {
      return Colors.red[300];
    } else {
      return Colors.yellow;
    }
  }

  IconData _getIcon() {
    if (status == Status.venceu) {
      return Icons.sentiment_very_satisfied;
    } else if (status == Status.perdeu) {
      return Icons.sentiment_very_dissatisfied;
    } else {
      return Icons.sentiment_satisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: () => onRestart(),
            ),
          ),
        ),
      ),
    );
  }
}
