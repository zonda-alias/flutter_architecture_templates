import 'package:freezed_annotation/freezed_annotation.dart';

import 'simple_pagination_data.dart';

part 'simple_single_data.freezed.dart';

part 'simple_single_data.g.dart';

@Freezed(
  genericArgumentFactories: true,
  toJson: true,
)
class SimpleSingleResultData<T> with _$SimpleSingleResultData {
  const factory SimpleSingleResultData({
    ///当前加载状态
    @Default(LoadStatus.waiting) LoadStatus loadStatus,

    ///当前UI层数据集合
    T? uiLayerData,

    ///请求提醒文案
    String? tipMsg,
  }) = _SimpleSingleResultData;

  factory SimpleSingleResultData.fromJson(
          Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$SimpleSingleResultDataFromJson(json, fromJsonT);
}

extension SimpleSingleResultDataExt<T> on SimpleSingleResultData<T> {
  bool get isOnSuccess => loadStatus == LoadStatus.success;

  bool get isNotValidData => uiLayerData == null;

  T? get getDataIfSuccess => isOnSuccess ? uiLayerData : null;

  R takeIfSuccess<R>(
      {required R Function(T data) onSuccess, required R Function() onElse}) {
    if (loadStatus == LoadStatus.success) {
      return onSuccess.call(uiLayerData);
    } else {
      return onElse.call();
    }
  }

  R? when<R>({
    required R Function(T data) onSuccess,
    required R Function(String? tipMsg) onEmpty,
    required R Function() onInitLoading,
    required R Function(String? tipMsg)? onInitError,
  }) {
    //TODO z

    if (loadStatus == LoadStatus.error) {
      return onInitError?.call(tipMsg);
    }

    if (loadStatus == LoadStatus.waiting) {
      return onEmpty.call(tipMsg);
    }

    if (loadStatus == LoadStatus.loading) {
      return onInitLoading.call();
    }

    if (loadStatus == LoadStatus.success) {
      return onSuccess.call(uiLayerData);
    }
    return null;
  }
}
