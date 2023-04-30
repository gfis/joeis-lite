package irvine.oeis.a228;
// Generated by gen_seq4.pl simbinom at 2023-03-16 19:20

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A228509 a(n) = binomial(n^2+n+1,n) * (n+1) / (n^2+n+1) for n&gt;=0.
 * @author Georg Fischer
 */
public class A228509 extends AbstractSequence {

  private int mN = -1; 
  
  public A228509() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return Binomial.binomial(mN * mN + mN + 1,mN).multiply(mN + 1).divide(mN * mN + mN + 1);
  }
}