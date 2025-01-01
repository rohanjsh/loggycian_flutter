import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/core/core.dart';
import 'package:loggycian_flutter/src/core/util/util.dart';
import 'package:loggycian_networking/loggycian_networking.dart';

class NetworkLogItem extends StatelessWidget {
  const NetworkLogItem({
    required this.item,
    required this.isSelected,
    required this.isSelectableMode,
    required this.onTap,
    super.key,
  });
  final NetworkRequestDetailsModel item;
  final bool isSelected;
  final bool isSelectableMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responseTime = item.responseTime;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
            right: 12,
            left: 12,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            color: Color(0xff1C1C1C),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: AnimatedCrossFade(
                  duration: kAnimationDefaultDuration,
                  crossFadeState: isSelectableMode
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  secondChild: const SizedBox.shrink(),
                  firstChild: IconButton(
                    onPressed: onTap,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    style: const ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color:
                          isSelected ? const Color(0xff0FA457) : Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
              if (isSelectableMode) const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  item.method.value.toUpperCase(),
                                  style: AppTextStyleConstants.bodySemiBold
                                      .copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                if (responseTime != null) ...[
                                  const SizedBox(width: 8),
                                  Text(
                                    responseTime
                                        .difference(item.requestTime)
                                        .durationInSec(),
                                    style: AppTextStyleConstants.body.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Container(
                            //stadium shape
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: _logTypeColor(
                                item.statusType ??
                                    NetworkRequestStatusEnum.started,
                              ),
                            ),
                            child: Text(
                              _logTypeText(
                                item.statusType ??
                                    NetworkRequestStatusEnum.started,
                              ),
                              style: AppTextStyleConstants.body.copyWith(
                                fontFamily: 'euclid_circularB_medium',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(
                          item.uri,
                          maxLines: 3,
                          style: AppTextStyleConstants.body.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _logTypeColor(NetworkRequestStatusEnum type) {
    switch (type) {
      case NetworkRequestStatusEnum.success:
        return AppColors.success;
      case NetworkRequestStatusEnum.error:
        return AppColors.error;
      case NetworkRequestStatusEnum.started:
        return AppColors.info;
    }
  }

  String _logTypeText(NetworkRequestStatusEnum type) {
    switch (type) {
      case NetworkRequestStatusEnum.success:
        return AppStrings.success;
      case NetworkRequestStatusEnum.error:
        return AppStrings.error;
      case NetworkRequestStatusEnum.started:
        return AppStrings.started;
    }
  }
}
