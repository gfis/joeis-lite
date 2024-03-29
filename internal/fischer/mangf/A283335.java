package irvine.oeis.a283;
// Generated by gen_seq4.pl prodeta 0 at 2020-10-13 17:55

import irvine.math.z.Z;
import irvine.oeis.transform.EulerTransform;

/**
 * A283335 Expansion of exp( Sum_{n&gt;=1} -A062796(n)/n*x^n ) in powers of x.
 * @author Georg Fischer
 */
public class A283335 extends EulerTransform {

  /** Construct the sequence. */
  public A283335() {
    super(0, 1);
  }

  @Override
  protected Z advance() {
    return Z.valueOf(mN).pow(mN - 1).negate();
  }
}
