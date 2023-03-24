package irvine.oeis.a349;
// Generated by gen_seq4.pl simbinom at 2023-03-16 19:20

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A349512 a(n) = binomial(n^3 + 3*n^2 - 3*n + 1, n^3).
 * @author Georg Fischer
 */
public class A349512 extends AbstractSequence {

  private int mN = -1; 
  
  public A349512() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return Binomial.binomial(mN * mN * mN + 3 * mN * mN - 3 * mN + 1,mN * mN * mN);
  }
}
