package irvine.oeis.a246;

import irvine.math.z.Z;
import irvine.oeis.a057.A057889;

/**
 * A246200 Self-inverse permutation of natural numbers: a(n) = A057889(3*n) / 3.
 * @author Georg Fischer
 */
public class A246200 extends A057889 {

  private int mN = -1;

  @Override
  public Z next() {
    Z result = super.next().divide(3);
    super.next();
    super.next();
    return result;
  }
}
