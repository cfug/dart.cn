{{site.alert.version-note}}

  In Dart 1.x, async functions immediately suspended execution. In Dart 2,
  instead of immediately suspending, async functions execute synchronously until
  the first `await` or `return`.

  在 Dart 1.x 版本中，异步方法会立即暂停执行。而在 Dart 2 中
  异步方法不是立即挂起，而是同步执行直到
  第一次 `await` 或 `return`。

{{site.alert.end}}
