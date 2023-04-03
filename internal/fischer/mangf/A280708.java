package irvine.oeis.a280;
// manually deris/essent at 2023-03-24 13:24

import irvine.oeis.PrependSequence;
import irvine.oeis.a052.A052349;

/**
 * A280708 Lexicographically earliest sequence such that no subsequence sums to a prime.
 * @author Georg Fischer
 */
public class A280708 extends PrependSequence {

  /** Construct the sequence. */
  public A280708() {
    super(1, new A052349(), 1);
  }
}
