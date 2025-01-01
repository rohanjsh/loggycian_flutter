import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loggycian_networking/loggycian_networking.dart';

class NetworkLoggerState {
  const NetworkLoggerState({
    required this.filteredLogs,
    required this.selectedLogs,
    this.isSelectableMode = false,
  });
  final List<NetworkRequestDetailsModel> filteredLogs;
  final List<NetworkRequestDetailsModel> selectedLogs;
  final bool isSelectableMode;

  NetworkLoggerState copyWith({
    List<NetworkRequestDetailsModel>? filteredLogs,
    List<NetworkRequestDetailsModel>? selectedLogs,
    bool? isSelectableMode,
  }) {
    return NetworkLoggerState(
      filteredLogs: filteredLogs ?? this.filteredLogs,
      selectedLogs: selectedLogs ?? this.selectedLogs,
      isSelectableMode: isSelectableMode ?? this.isSelectableMode,
    );
  }
}

class NetworkLoggerHomeController with ChangeNotifier {
  NetworkLoggerHomeController() {
    _filterTextController = TextEditingController();
    _state = NetworkLoggerState(
      filteredLogs: List.of(NetworkLoggingRepository.logs.values.toList()),
      selectedLogs: [],
    );
    _setupLogsSubscription();
  }

  late final TextEditingController _filterTextController;
  late final StreamSubscription<List<NetworkRequestDetailsModel>>
      _logsSubscription;
  late NetworkLoggerState _state;

  TextEditingController get filterTextController => _filterTextController;
  NetworkLoggerState get state => _state;
  bool get hasSelectedLogs => _state.selectedLogs.isNotEmpty;
  bool get isAllSelected =>
      _state.selectedLogs.length == _state.filteredLogs.length;

  void _setupLogsSubscription() {
    _logsSubscription =
        NetworkLoggingRepository.logsStreamController.stream.listen((_) {
      _updateFilteredLogs();
    });
  }

  void _updateFilteredLogs() {
    final filteredLogs = _filterLogs(
      _filterTextController.text,
      NetworkLoggingRepository.logs.values.toList(),
    );
    _state = _state.copyWith(filteredLogs: filteredLogs);
    notifyListeners();
  }

  List<NetworkRequestDetailsModel> _filterLogs(
    String searchText,
    List<NetworkRequestDetailsModel> logs,
  ) {
    if (searchText.isEmpty) return logs;

    final query = searchText.toLowerCase();
    return logs.where((log) {
      return log.statusCode.toString().toLowerCase().contains(query) ||
          log.uri.toLowerCase().contains(query) ||
          log.method.toString().toLowerCase().contains(query);
    }).toList();
  }

  void onSearchChanged(String value) => _updateFilteredLogs();

  void onSearchCancel() {
    _state = _state.copyWith(
      filteredLogs: List.of(NetworkLoggingRepository.logs.values.toList()),
    );
    _filterTextController.clear();
    notifyListeners();
  }

  void onSelectAll() {
    _state = _state.copyWith(
      selectedLogs: isAllSelected ? [] : List.of(_state.filteredLogs),
    );
    notifyListeners();
  }

  void onChangeSelectableMode() {
    _state = _state.copyWith(
      isSelectableMode: !_state.isSelectableMode,
      selectedLogs: [],
    );
    notifyListeners();
  }

  void onItemSelect(NetworkRequestDetailsModel item) {
    final selectedLogs = List.of(_state.selectedLogs);
    if (selectedLogs.contains(item)) {
      selectedLogs.remove(item);
    } else {
      selectedLogs.add(item);
    }
    _state = _state.copyWith(selectedLogs: selectedLogs);
    notifyListeners();
  }

  void onRemoveLogs() {
    if (NetworkLoggingRepository.logs.isEmpty) return;
    NetworkLoggingRepository.clearSelectedLogs(_state.selectedLogs);
  }

  @override
  void dispose() {
    _logsSubscription.cancel();
    _filterTextController.dispose();
    super.dispose();
  }
}
