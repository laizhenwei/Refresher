# Refresher

## 使用

**自定义 Refresh Animator**

`Refresher` 支持 Header 和 Footer 刷新组件，可以通过传入 Animator 来构建 Refresher

**添加 Header/Footer Animator**

```
tableView.refresh.addHeader(NormalRefreshAnimator(action: {
    // ...
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

## RefreshAnimatable

实现 `RefreshAnimatable` 协议

```
public protocol RefreshAnimatable {
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

eg. 简单的 `IndicatorRefreshAnimator` 实现
```
final class IndicatorRefreshAnimator: RefreshAnimatable {

    var refreshHeight: CGFloat = 50

    var refreshAction: (() -> ())?

    let indicatorView: UIActivityIndicatorView

    init(style: UIActivityIndicatorView.Style, action: (() -> ())?) {
        self.indicatorView = UIActivityIndicatorView(style: style)
        self.refreshAction = action
    }

    var view: UIView {
        return indicatorView
    }

    func startAnimating() {
        indicatorView.startAnimating()
    }

    func stopAnimating() {
        indicatorView.stopAnimating()
    }
}
```

