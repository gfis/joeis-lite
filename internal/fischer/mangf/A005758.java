package irvine.oeis.a005;
// Generated by gen_seq4.pl genetf2/genetf at 2023-01-13 19:49

import irvine.math.z.Z;
import irvine.oeis.transform.GeneralizedEulerTransform;

/**
 * A005758 
 * G.f.: <code>Product_{k&gt;=1} (1/(1-x^k)^12)</code>
 * @author Georg Fischer
 */
public class A005758 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A005758() {
    super(0, 1);
  }
  
  @Override
  protected Z[] advanceF(final long k) {
    return new Z[] { Z.valueOf(12) };
  }
}