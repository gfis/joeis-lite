package irvine.oeis.a331;

import irvine.math.z.Z;
import irvine.oeis.HypergeometricSequence;

/**
 * A331656 a(n) = Sum_{k=0..n} binomial(n,k) * binomial(n+k,k) * n^k.
 * Hypergeometric2F1([-n, n + 1], [1], -n]
 * @author Georg Fischer
 */
public class A331656 extends HypergeometricSequence {

  private int mN;

  /** Construct the sequence. */
  public A331656() {
    super(0, 2, 1, "[[0,-1],[1,1], [1], [0,-1]]");
  }
}
