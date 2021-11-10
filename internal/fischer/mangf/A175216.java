package irvine.oeis.a175;
// manually deris2/essent at 2021-11-04 

import irvine.math.z.Z;
import irvine.oeis.a008.A008864;

/**
 * A175216 Essentially the same as A135731, A055670, A028815 and A008864. [From _R. J. Mathar_, Mar 13 2010]
 * @author Georg Fischer
 */
public class A175216 extends A008864 {

  private int mN = 0;

  /** Construct the sequence. */
  public A175216() {
    super.next();
  }

  @Override
  public Z next() {
    return ++mN == 1 ? Z.FOUR : super.next();
  }
}
