package irvine.oeis.a199;
// Generated by gen_seq4.pl simbinom at 2023-03-16 19:20

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A199748 a(n) = binomial(n*(3*n-1)/2, n).
 * @author Georg Fischer
 */
public class A199748 extends AbstractSequence {

  private int mN = -1; 
  
  public A199748() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return Binomial.binomial(mN * (3 * mN - 1)/2,mN);
  }
}
