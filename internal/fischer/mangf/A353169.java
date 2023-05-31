package irvine.oeis.a353;
// Generated by gen_seq4.pl genet/genetfg at 2023-05-08 19:40

import irvine.math.z.Z;
import irvine.oeis.a000.A000040;
import irvine.oeis.transform.GeneralizedEulerTransform;

/**
 * A353169 Expansion of Product_{k&gt;=1} (1 + x^k)^prime(k+1).
 * G.f.: <code>Product_{k&gt;=1} ((1+x^k)^A000040(k+1))</code>
 * @author Georg Fischer
 */
public class A353169 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A353169() {
    super(0, 1);
    mSeqF = new A000040();
    mSeqF.next();
  }
  
  @Override
  protected Z[] advanceF(final long k) {
    return new Z[] { mSeqF.next().negate() };
  }
  
  @Override
  protected Z advanceG(final long k) {
    return Z.NEG_ONE;
  }
  
}
