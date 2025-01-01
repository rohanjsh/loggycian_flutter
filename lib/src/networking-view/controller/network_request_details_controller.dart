import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loggycian_networking/loggycian_networking.dart';

class NetworkRequestDetailsController {
  NetworkRequestDetailsController({required this.log});
  final NetworkRequestDetailsModel log;
  final ScrollController scrollController = ScrollController();

  void copyCurl(BuildContext context) {
    final curl = Curl(request: log).generate();
    Clipboard.setData(
      ClipboardData(
        text: curl,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'cURL copied to clipboard',
        ),
      ),
    );
  }

  Future<void> copy(BuildContext context, String body) async {
    await Clipboard.setData(
      ClipboardData(
        text: body,
      ),
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Copied to clipboard',
          ),
        ),
      );
    }
  }

  void dispose() {
    scrollController.dispose();
  }
}
