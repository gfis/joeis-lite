package irvine.oeis.a332;
// Generated by gen_seq4.pl simbinom at 2023-03-16 19:20

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A332231 a(n) = 1/n! * ((n+1)*n)!/Gamma(1 + (n+1)*n/2) * Gamma(1 + (n-1)*n/2)/((n-1)*n)!.
 * @author Georg Fischer
 */
public class A332231 extends AbstractSequence {

  private int mN = -1; 
  
  public A332231() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return Binomial.binomial(mN * (mN + 1),2 * mN).multiply(Binomial.binomial(2 * mN,mN)).divide(Binomial.binomial(mN * (mN + 1) / 2,mN));
  }
}
