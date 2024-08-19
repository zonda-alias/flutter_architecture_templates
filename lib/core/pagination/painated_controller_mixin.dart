import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/logger_util.dart';
import 'simple_pagination_data.dart';

mixin EasyPaginatedTaskMixin<UiLayerItemModel>
// ignore: invalid_use_of_internal_member
//AsyncNotifierBase
    on AutoDisposeAsyncNotifier<IndicatorResult> {
  Future<IndicatorResult> fetchPageData(int pageNum);

  Future<IndicatorResult> loadNextData() async {
    if (state.isLoading) {
      logger.i("${getTaskName()} loadNextData is already run ~ ~ ");
      return IndicatorResult.none;
    }

    final curPaginatedData = getCurPaginatedData();
    if (curPaginatedData.loadStatus == LoadStatus.loading) {
      logger.e("${getTaskName()} loadNextData may be error~ ~ ");
    }

    /*确认当前需要加载的页码*/
    int loadedPage = curPaginatedData.curPage;
    if (curPaginatedData.isOnSuccess()) {
      loadedPage = loadedPage + 1;
    }

    logger.i("${getTaskName()} in loadNextData page: $loadedPage");

    if (curPaginatedData.hasNextPage) {
      return await fetchPageData(loadedPage);
    } else {
      logger.i("${getTaskName()} loadNextData isn't hasNextPage ~ ~ ");
    }
    return IndicatorResult.noMore;
  }

  @protected
  String getTaskName() => "EasyPaginatedTask";

  @protected
  SimplePaginatedStateData<UiLayerItemModel> getCurPaginatedData();
}

mixin EasyPaginatedNotifierMixin<UiLayerItemModel>
// ignore: invalid_use_of_internal_member
//NotifierBase
    on AutoDisposeNotifier<SimplePaginatedStateData<UiLayerItemModel>> {
  ///添加首批或下一批数据到分页集合
  void addPaginatedData(
    SimplePaginatedStateData<UiLayerItemModel> paginatedStateData,
  ) {
    final newUILayerList =
        paginatedStateData.uiLayerList as List<UiLayerItemModel>;
    if (paginatedStateData.isFirst()) {
      state = paginatedStateData.copyWith.call(
        uiLayerList: newUILayerList,
      ) as SimplePaginatedStateData<UiLayerItemModel>;
    } else {
      final oldUILayerList = state.uiLayerList as List<UiLayerItemModel>;
      state = paginatedStateData.copyWith.call(
        uiLayerList: oldUILayerList..addAll(newUILayerList),
      ) as SimplePaginatedStateData<UiLayerItemModel>;
    }
  }

  ///通知UI层请求第[pageNum]页的数据失败
  ///注意这里的失败是指"客户端没有得到接口任何有效json的异常"
  void toError(int pageNum) {
    state = state.copyWith.call(loadStatus: LoadStatus.error, curPage: pageNum)
        as SimplePaginatedStateData<UiLayerItemModel>;
  }

  void toLoading() {
    if (state.loadStatus != LoadStatus.loading) {
      state = state.copyWith.call(loadStatus: LoadStatus.loading)
          as SimplePaginatedStateData<UiLayerItemModel>;
    }
  }
}
