# Refresher

## 使用

**自定义 Refresher**

`Refresher` 只提供刷新功能，和基础 UI 组件，业务需要自定义刷新 UI 组件。

**添加 Header、Footer，绑定 Action**

```
tableView.refresh.addHeader(NormalRefresher(action: {
    // excute action
}))
```

**开始、结束刷新**

```
tableView.refresh.beginHeaderRefreshing()
tableView.refresh.endHeaderRefreshing()

tableView.refresh.beginFooterRefreshing()
tableView.refresh.endFooterRefreshing(noMoreData: Bool = false)
```

**状态**

```
tableView.refresh.isHeaderRefreshing
tableView.refresh.isFooterRefreshing
```

