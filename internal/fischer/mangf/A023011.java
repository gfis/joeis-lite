package irvine.oeis.a023;
// Generated by gen_seq4.pl genetf2/genetf at 2023-01-13 19:49

import irvine.math.z.Z;
import irvine.oeis.transform.GeneralizedEulerTransform;

/**
 * A023011 
 * G.f.: <code>Product_{k&gt;=1} (1/(1-x^k)^13)</code>
 * @author Georg Fischer
 */
public class A023011 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A023011() {
    super(0, 1);
  }
  
  @Override
  protected Z[] advanceF(final long k) {
    return new Z[] { Z.valueOf(13) };
  }
}
