package irvine.oeis.a246;
// Generated by gen_seq4.pl simple/simbinom at 2023-03-20 18:29

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A246604 a(n) = Catalan(n) - n.
 * @author Georg Fischer
 */
public class A246604 extends AbstractSequence {

  private int mN = -1; 
  
  public A246604() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return Binomial.catalan(mN).subtract(mN);
  }
}
