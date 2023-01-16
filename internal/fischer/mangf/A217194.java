package irvine.oeis.a217;
// Generated by gen_seq4.pl prodeta 0 at 2020-10-13 17:55

import irvine.math.z.Z;
import irvine.oeis.transform.EulerTransform;

/**
 * A217194 Number of unlabeled simple graphs with n nodes of 2 colors whose components are path graphs.
 * @author Georg Fischer
 */
public class A217194 extends EulerTransform {

  /** Construct the sequence. */
  public A217194() {
    super(0, 1);
  }

  @Override
  protected Z advance() {
    return Z.TWO.pow(mN - 1).add(Z.TWO.pow((mN + 1) / 2 - 1));
  }

}
