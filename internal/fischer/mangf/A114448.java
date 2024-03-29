package irvine.oeis.a114;
// Generated by gen_seq4.pl transpose at 2022-12-15 22:44

import irvine.oeis.a060.A060154;
import irvine.oeis.triangle.Transpose;

/**
 * A114448 Array a(n,k) = n^k (mod k) read by antidiagonals (k&gt;=1, n&gt;=1).
 * @author Georg Fischer
 */
public class A114448 extends Transpose {

  /** Construct the sequence. */
  public A114448() {
    super(1, new A060154());
  }
}
