import 'package:freezed_annotation/freezed_annotation.dart';

import '../pagination/simple_pagination_data.dart';
import '../pagination/simple_single_data.dart';
import '../utils/kotlin_flavor.dart';

part 'api_response.freezed.dart';

part 'api_response.g.dart';

@Freezed(
  genericArgumentFactories: true,
  toJson: true,
)
class ApiResponseResult<T> with _$ApiResponseResult {
  const factory ApiResponseResult({
    ///错误码
    @JsonKey(name: "code") int? errorCode,

    ///错误提示
    @JsonKey(name: "message") String? errorMsg,

    ///当前页码数
    int? pageNum,

    ///当前每页最大个数
    int? pageSize,

    ///是否成功
    bool? success,

    ///当前系统时间
    int? sysTime,

    ///总页数
    int? totalPages,

    ///总个数
    int? totalRecords,
    int? total,

    ///接口数据
    T? data,
  }) = _ApiResponseResult;

  factory ApiResponseResult.fromJson(
          Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$ApiResponseResultFromJson(json, fromJsonT);
}

extension ApiResponseResultExt on ApiResponseResult {
  ///获取非空的列表集合
  List<T> getNonNullItemDataList<T>() => run(() {
        if (data is List) {
          return data?.fold(
                <T>[],
                (previousValue, element) {
                  final acc = previousValue ?? <T>[];
                  if (element != null && element is T) {
                    acc.add(element);
                  }
                  return acc;
                },
              ) ??
              <T>[];
        }
        return <T>[];
      });

  T? getDataOrNull<T>() => run(() {
        return (data is T) ? (data as T) : null;
      });

  ///是否成功
  bool isSuccess() => success ?? false;

  ///是否还有下一批
  bool hasMore() =>
      ((totalPages ?? 0) > 0 && (totalPages ?? 0) > (pageNum ?? 0)) ||
      getNonNullItemDataList().length < (total ?? 0);

  ///通过接口响应的数据结果"apiResult", 以及当前加载的页数[pageNum],封装当前加载的分页数据集合
  SimplePaginatedStateData<T> createPaginatedData<T>(int pageNum) {
    return SimplePaginatedStateData(
      curPage: pageNum,
      loadStatus: isSuccess() ? LoadStatus.success : LoadStatus.error,
      uiLayerList: getNonNullItemDataList(),
      hasNextPage: isSuccess() ? hasMore() : true,
      tipMsg: errorMsg,
    );
  }

  SimplePaginatedStateData<UILayerT>
      createCustomPaginatedData<UILayerT, ApiLayerT>(
    int pageNum,
    UILayerT Function(ApiLayerT) convertFun,
  ) =>
          SimplePaginatedStateData(
            curPage: pageNum,
            loadStatus: isSuccess() ? LoadStatus.success : LoadStatus.error,
            uiLayerList: run(() {
              if (data is List) {
                return (data as List<ApiLayerT?>).fold(
                      <UILayerT>[],
                      (previousValue, element) {
                        final acc = previousValue ?? <UILayerT>[];
                        if (element != null) {
                          acc.add(convertFun.call(element));
                        }
                        return acc;
                      },
                    ) ??
                    <UILayerT>[];
              }
              return <UILayerT>[];
            }),
            hasNextPage: isSuccess() ? hasMore() : true,
            tipMsg: errorMsg,
          );

  SimpleSingleResultData<T> createSinglePageData<T>() {
    return SimpleSingleResultData(
      loadStatus: isSuccess() ? LoadStatus.success : LoadStatus.error,
      uiLayerData: getDataOrNull(),
      tipMsg: errorMsg,
    );
  }
}

extension MapArgumentsExt on Map<String, dynamic>? {
  T? getValueOrNull<T>(String key) => run(() {
        final valueObj = this?[key];
        return (valueObj is T) ? valueObj : null;
      });

  T getValueOrElse<T>(String key, T Function() onElse) => run(() {
        final valueObj = this?[key];
        return (valueObj is T) ? valueObj : onElse.call();
      });
}
