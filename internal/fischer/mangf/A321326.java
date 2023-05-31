package irvine.oeis.a321;
// Generated by gen_seq4.pl genet/genetf at 2023-05-08 19:40

import irvine.math.z.Z;
import irvine.oeis.a067.A067856;
import irvine.oeis.transform.GeneralizedEulerTransform;

/**
 * A321326 G.f. satisfies: A(x) = (1 - x) * Product_{k&gt;0} A(x^(2*k)) / Product_{k&gt;1} A(x^(2*k-1)).
 * G.f.: <code>Product_{k&gt;=1} ((1-x^k)^A067856(k))</code>
 * @author Georg Fischer
 */
public class A321326 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A321326() {
    super(0, 1);
    mSeqF = new A067856();
  }
  
  @Override
  protected Z[] advanceF(final long k) {
    return new Z[] { mSeqF.next().negate() };
  }
  
}
