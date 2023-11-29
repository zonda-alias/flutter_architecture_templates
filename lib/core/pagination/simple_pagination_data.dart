import 'package:freezed_annotation/freezed_annotation.dart';

part 'simple_pagination_data.freezed.dart';
part 'simple_pagination_data.g.dart';

@Freezed(
  genericArgumentFactories: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
)
class SimplePaginatedStateData<T> with _$SimplePaginatedStateData {
  const factory SimplePaginatedStateData({
    ///当前加载的页码
    @Default(1) int curPage,

    ///当前加载状态
    @Default(LoadStatus.waiting) LoadStatus loadStatus,

    ///当前UI层数据集合
    @Default([]) List<T> uiLayerList,

    ///是否还有下一批
    @Default(false) bool hasNextPage,

    ///请求提醒文案
    String? tipMsg,
  }) = _SimplePaginatedStateData;

  factory SimplePaginatedStateData.fromJson(
          Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$SimplePaginatedStateDataFromJson(json, fromJsonT);
}

///当前加载状态
enum LoadStatus {
  ///未开始
  waiting,

  ///加载中
  loading,

  ///加载成功
  success,

  ///加载失败
  error;
}

extension AppSimplePaginatedStateDataExt<T> on SimplePaginatedStateData<T> {
  ///当前加载成功
  bool isOnSuccess() => loadStatus == LoadStatus.success;

  ///当前是加载第一批
  bool isFirst() => curPage == 1;

  T getItem(int index) {
    return getUiLayerList()[index];
  }

  List<T> getUiLayerList() {
    return (uiLayerList as List<T>);
  }

  SimplePaginatedStateData<T> setItem(int index, T itemData) {
    final uiLayerList = getUiLayerList();
    uiLayerList[index] = itemData;
    return copyWithUiLayerList(uiLayerList);
  }

  SimplePaginatedStateData<T> copyWithTipMsg(String? tipMsg) =>
      copyWith.call(tipMsg: tipMsg) as SimplePaginatedStateData<T>;

  SimplePaginatedStateData<T> copyWithUiLayerList(List<T> uiLayerList) =>
      copyWith.call(uiLayerList: uiLayerList) as SimplePaginatedStateData<T>;

  R takeIfSuccess<R>(
      {required R Function(List<T> data) onSuccess,
      required R Function() onElse}) {
    if (loadStatus == LoadStatus.success) {
      return onSuccess.call(getUiLayerList());
    } else {
      return onElse.call();
    }
  }

  R? when<R>({
    required R Function(int curPage, List<T> listData, bool hasNext) onSuccess,
    required R Function() onInitEmpty,
    required R Function() onInitError,
    required R Function() onInitLoading,
    void Function(int curPage, String? tipMsg)? onError,
    R Function(int curPage, List<T> listData, String? tipMsg)? onOther,
  }) {
    if (loadStatus == LoadStatus.error) {
      onError?.call(curPage, tipMsg);
    }

    if (curPage == 1 && uiLayerList.isEmpty) {
      if (loadStatus == LoadStatus.loading) {
        return onInitLoading.call();
      }

      if (loadStatus == LoadStatus.error) {
        return onInitError.call();
      }
      return onInitEmpty.call();
    }

    if (loadStatus == LoadStatus.success) {
      if (uiLayerList is List<T>) {
        return onSuccess.call(curPage, uiLayerList as List<T>, hasNextPage);
      } else {
        //对于分页的数据 uiLayerList 必须为List类型
        return onOther?.call(curPage, List.empty(growable: true), tipMsg);
      }
    }
    return onOther?.call(
      curPage,
      uiLayerList is List<T>
          ? uiLayerList as List<T>
          : List.empty(growable: true),
      tipMsg,
    );
  }
}
