package irvine.oeis.a357;
// Generated by gen_seq4.pl genet/genetfg at 2023-05-08 19:40

import irvine.math.z.Z;
import irvine.oeis.a008.A008683;
import irvine.oeis.transform.GeneralizedEulerTransform;

/**
 * A357521 Expansion of Product_{k&gt;=1} (1 - mu(k)*x^k).
 * G.f.: <code>Product_{k&gt;=1} ((1-A008683(k)*x^k))</code>
 * @author Georg Fischer
 */
public class A357521 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A357521() {
    super(0, 1);
    mSeqG = new A008683();
  }
  
  @Override
  protected Z[] advanceF(final long k) {
    return new Z[] { Z.NEG_ONE };
  }
  
  @Override
  protected Z advanceG(final long k) {
    return mSeqG.next();
  }
  
}
