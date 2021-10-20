package irvine.oeis.a071;
// manually binom at 2021-10-15

import irvine.oeis.transform.BinomialTransform;
import irvine.oeis.a002.A002487;

/**
 * A071014 Binomial transform of A002487.
 * @author Georg Fischer
 */
public class A071014 extends BinomialTransform {

  /** Construct the sequence. */
  public A071014() {
    super(new A002487(), 2);
  }
}
