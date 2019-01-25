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

## Refresher

实现 `Refresher` 协议

```
public protocol Refresher {
    var view: UIView { get }

    var refreshHeight: CGFloat { get }
    var triggerDistance: CGFloat { get }

    var refreshAction: (() -> ())? { set get }

    func update(state: RefreshState)
    func update(progress: CGFloat)

    func startAnimating()
    func stopAnimating()
}
```

eg. 简单的 `IndicatorRefresher` 实现
```
public final class IndicatorRefresher: Refresher {

    public var refreshHeight: CGFloat = 50

    public var refreshAction: (() -> ())?

    public let indicatorView: UIActivityIndicatorView

    public init(style: UIActivityIndicatorView.Style, action: (() -> ())?) {
        self.indicatorView = UIActivityIndicatorView(style: style)
        self.refreshAction = action
    }

    public var view: UIView {
        return indicatorView
    }

    public func startAnimating() {
        indicatorView.startAnimating()
    }

    public func stopAnimating() {
        indicatorView.stopAnimating()
    }
}
```
