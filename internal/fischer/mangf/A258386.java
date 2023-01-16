package irvine.oeis.a258;
// Generated by gen_seq4.pl prodeta 0 at 2020-10-13 17:55

import irvine.math.z.Z;
import irvine.oeis.transform.EulerTransform;

/**
 * A258386 Expansion of Product_{k&gt;=1} 1/(1-x^k)^(k+(-1)^k).
 * @author Georg Fischer
 */
public class A258386 extends EulerTransform {

  /** Construct the sequence. */
  public A258386() {
    super(0, 1);
  }

  @Override
  protected Z advance() {
    return Z.valueOf(mN + (mN % 2 == 0 ? 1 : -1));
  }

}
