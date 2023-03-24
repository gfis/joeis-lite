package irvine.oeis.a081;
// Generated by gen_seq4.pl simbinom at 2023-03-16 19:20

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A081623 Number of ways in which the points on an n X n square lattice can be equally occupied with spin &quot;up&quot; and spin &quot;down&quot; particles. If n is odd, we arbitrarily take the lattice to contain one more spin &quot;up&quot; particle than the number of spin &quot;down&quot; particles.
 * @author Georg Fischer
 */
public class A081623 extends AbstractSequence {

  private int mN = -1; 
  
  public A081623() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return Binomial.binomial(mN * mN,(mN * mN)/2);
  }
}
