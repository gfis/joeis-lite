package irvine.oeis.a191;
// manually 2021-11-15

import irvine.math.z.Z;
import irvine.oeis.a190.A190803;

/**
 * A191145 Increasing sequence S generated by these rules:  a(1)=1, and if x is in S then both 3x+2 and 4x+3 are in S
 * @author Georg Fischer
 */
public class A191145 extends A190803 {

  @Override
  public void insertTerms(final Z x) {
    insert(x.multiply(3).add(Z.TWO));
    insert(x.multiply(4).add(Z.THREE));
  }
}