package irvine.oeis.a065;
// Generated by gen_seq4.pl simbinom at 2023-03-16 19:20

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A065942 Central column of triangle A065941.
 * @author Georg Fischer
 */
public class A065942 extends AbstractSequence {

  private int mN = -1; 
  
  public A065942() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return Binomial.binomial(mN + mN/2,mN);
  }
}