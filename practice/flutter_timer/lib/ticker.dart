// All our Ticker class does is expose a tick function
// which takes the number of ticks (seconds) we want
// and returns a stream which emits the remaining seconds every second.
//計時器的數據源
//一個stream，可以訂閱並響應
class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
