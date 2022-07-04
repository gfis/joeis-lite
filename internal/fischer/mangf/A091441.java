package irvine.oeis.a091;
// manually trecpas

import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A091441 Table (by antidiagonals) of permutations of two types of objects such that each cycle contains at least one object of each type. Each type of object is labeled from its own label set.
 * @author Georg Fischer
 */
public class A091441 extends Triangle {

  /** Construct the sequence. */
  public A091441 () {
    hasRAM(false);
  }

  @Override
  protected Z compute(final int n, final int k) {
    return n == 0 ? Z.ONE : get(n - 1, k - 1).multiply(k + 1).add(get(n - 1, k).multiply(n - k + 1));
  }
}
