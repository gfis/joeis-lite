package irvine.oeis.a060;

import irvine.math.z.Z;
import irvine.oeis.recur.CoordinationSequence;

/**
 * A060026 Expansion of (1-x-x^N)/((1-x)(1-x^2)(1-x^3)...(1-x^N)) for N = 7.
 * @author Georg Fischer
 */
public class A060026 extends CoordinationSequence {

  /** Construct the sequence. */
  public A060026() {
    super(new long[] {1, -1, 0, 0, 0, 0, 0, -1}, new int[] {1, 2, 3, 4, 5, 6, 7});
  }
}
