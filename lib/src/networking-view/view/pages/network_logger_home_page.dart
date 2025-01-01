import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/core/core.dart';
import 'package:loggycian_flutter/src/networking-view/controller/network_logger_home_controller.dart';
import 'package:loggycian_flutter/src/networking-view/view/pages/network_request_details_page.dart';
import 'package:loggycian_flutter/src/networking-view/view/widgets/action_button.dart';
import 'package:loggycian_flutter/src/networking-view/view/widgets/network_log_item.dart';
import 'package:loggycian_flutter/src/networking-view/view/widgets/network_search_bar.dart';
import 'package:loggycian_networking/loggycian_networking.dart';

class NetworkLoggerHomePage extends StatefulWidget {
  const NetworkLoggerHomePage({
    required this.showDebugButtonNotifier,
    super.key,
  });
  final ValueNotifier<bool> showDebugButtonNotifier;

  @override
  State<NetworkLoggerHomePage> createState() => _NetworkLoggerHomePageState();
}

class _NetworkLoggerHomePageState extends State<NetworkLoggerHomePage> {
  static const _toolbarHeight = 48.0;
  late final NetworkLoggerHomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NetworkLoggerHomeController();
    _toggleShowDebugNotificationValue(false);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final bottomSafeArea = MediaQuery.paddingOf(context).bottom;
        final bottomBarHeight = _controller.state.isSelectableMode
            ? _toolbarHeight + bottomSafeArea
            : 0.0;

        return Scaffold(
          backgroundColor: AppColors.black,
          bottomNavigationBar: AnimatedContainer(
            curve: Curves.easeOut,
            duration: kAnimationDefaultDuration,
            color: AppColors.overlayDark,
            height: bottomBarHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ActionButton.text(
                label: AppStrings.remove,
                onPressed: _controller.hasSelectedLogs
                    ? _controller.onRemoveLogs
                    : null,
              ),
            ),
          ),
          appBar: AppBar(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.black,
            toolbarHeight: AppSpacing.appBarHeight,
            leading: ActionButton.icon(
              icon: Icons.arrow_back_ios_new_rounded,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.networkLogs,
                      style: AppTextStyleConstants.title.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    ActionButton.text(
                      label: _controller.state.isSelectableMode
                          ? AppStrings.cancel
                          : AppStrings.select,
                      onPressed: _controller.onChangeSelectableMode,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              NetworkSearchBar(
                controller: _controller.filterTextController,
                onClear: _controller.onSearchCancel,
                onChanged: _controller.onSearchChanged,
              ),
              const SizedBox(height: 8),
              AnimatedCrossFade(
                firstChild: Padding(
                  padding: const EdgeInsets.only(left: 32, top: 6),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _controller.onSelectAll,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: Icon(
                          _controller.isAllSelected
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: _controller.isAllSelected
                              ? AppColors.successLight
                              : AppColors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 16),
                      ActionButton.text(
                        label: _controller.isAllSelected
                            ? AppStrings.unselectAll
                            : AppStrings.selectAll,
                        onPressed: _controller.onSelectAll,
                      ),
                    ],
                  ),
                ),
                secondChild: const SizedBox.shrink(),
                duration: kAnimationDefaultDuration,
                crossFadeState: _controller.state.isSelectableMode
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 16,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: _controller.state.isSelectableMode ? 16 : 14,
                  ),
                  itemCount: _controller.state.filteredLogs.length,
                  itemBuilder: (context, index) {
                    final item =
                        _controller.state.filteredLogs.reversed.toList()[index];
                    return NetworkLogItem(
                      item: item,
                      isSelected: _controller.state.selectedLogs.contains(item),
                      isSelectableMode: _controller.state.isSelectableMode,
                      onTap: _controller.state.isSelectableMode
                          ? () => _controller.onItemSelect(item)
                          : () => _onDetailsTap(item),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleShowDebugNotificationValue(bool value) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.showDebugButtonNotifier.value = value,
      );

  void _onDetailsTap(NetworkRequestDetailsModel log) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => NetworkRequestDetailsPage(log: log),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    _toggleShowDebugNotificationValue(true);
    super.dispose();
  }
}
