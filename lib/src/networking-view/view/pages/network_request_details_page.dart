import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/core/core.dart';
import 'package:loggycian_flutter/src/networking-view/controller/network_request_details_controller.dart';
import 'package:loggycian_flutter/src/networking-view/view/widgets/headers_and_body_section.dart';
import 'package:loggycian_flutter/src/networking-view/view/widgets/info_item.dart';
import 'package:loggycian_flutter/src/networking-view/view/widgets/info_section.dart';
import 'package:loggycian_flutter/src/networking-view/view/widgets/url_section.dart';
import 'package:loggycian_networking/loggycian_networking.dart';

class NetworkRequestDetailsPage extends StatefulWidget {
  const NetworkRequestDetailsPage({
    required this.log,
    super.key,
  });
  final NetworkRequestDetailsModel log;

  @override
  State<NetworkRequestDetailsPage> createState() =>
      _NetworkRequestDetailsPageState();
}

class _NetworkRequestDetailsPageState extends State<NetworkRequestDetailsPage> {
  late final NetworkRequestDetailsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NetworkRequestDetailsController(log: widget.log);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surfaceDark,
          border: Border(
            top: BorderSide(
              color: AppColors.borderDark,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () => _controller.copyCurl(context),
              child: Text(
                AppStrings.copyAsCurl,
                style: AppTextStyleConstants.bodySemiBold.copyWith(
                  color: AppColors.actionSuccess,
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.black,
        toolbarHeight: AppSpacing.appBarHeight,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RawScrollbar(
        controller: _controller.scrollController,
        interactive: true,
        thumbVisibility: true,
        trackVisibility: true,
        radius: const Radius.circular(3),
        thickness: 12,
        child: ListView(
          cacheExtent: 100000,
          controller: _controller.scrollController,
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.log.method.value,
                style: AppTextStyleConstants.title.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: UrlSection(
                uri: widget.log.uri,
                responseTime: widget.log.responseTime,
                requestTime: widget.log.requestTime,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InfoSection(
                children: [
                  if ((widget.log.queryParameters is Map) &&
                      (widget.log.queryParameters as Map).isNotEmpty)
                    InfoItem(
                      title: AppStrings.queryParams,
                      description: (widget.log.queryParameters as Map)
                          .entries
                          .map((e) => '${e.key}: ${e.value}')
                          .join('\n'),
                    ),
                  InfoItem(
                    title: AppStrings.method,
                    description: widget.log.method.value,
                  ),
                  if (widget.log.statusCode != null)
                    InfoItem(
                      title: AppStrings.statusCode,
                      description: widget.log.statusCode.toString(),
                    ),
                  InfoItem(
                    title: AppStrings.requestDateTime,
                    description: widget.log.requestTime.toIso8601String(),
                  ),
                  if (widget.log.responseTime != null) ...[
                    InfoItem(
                      title: AppStrings.responseDateTime,
                      description: widget.log.responseTime!.toIso8601String(),
                    ),
                    InfoItem(
                      title: AppStrings.responseDuration,
                      description: widget.log.responseTime!
                          .difference(widget.log.requestTime)
                          .durationInSec(),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: HeadersAndBodySection(
                type: AppStrings.request,
                headers: widget.log.requestHeaders,
                body: widget.log.requestBody,
                onCopy: () => _controller.copy(
                  context,
                  '${widget.log.requestHeaders.entries.map((e) => '${e.key}: ${e.value}').join('\n')}\n\n${widget.log.requestBody?.toString() ?? ''}',
                ),
              ),
            ),
            if (widget.log.responseBody != null) ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: HeadersAndBodySection(
                  type: AppStrings.response,
                  headers: widget.log.responseHeaders,
                  body: widget.log.responseBody,
                  onCopy: () => _controller.copy(
                    context,
                    '${widget.log.responseHeaders?.entries.map((e) => '${e.key}: ${e.value}').join('\n') ?? ''}\n\n${widget.log.responseBody?.toString() ?? ''}',
                  ),
                ),
              ),
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
