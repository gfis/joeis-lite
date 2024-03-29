package irvine.oeis.a191;
// manually a190803 at 2021-09-02 11:27

import irvine.math.z.Z;
import irvine.oeis.a190.A190803;

/**
 * A191290 Increasing sequence generated by these rules:  a(1)=1, and if x is in a then 2x+1 and x(x+1)/2 are in a.
 * @author Georg Fischer
 */
public class A191290 extends A190803 {

  @Override
  public void insertTerms(final Z x) {
    insert(x.multiply2().add(Z.ONE));
    insert(x.multiply(x.add(Z.ONE)).divide2());
  }

}
