package irvine.oeis.a119;
// Generated by gen_seq4.pl simple/simbinom at 2023-03-20 18:29

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A119549 Binomial( Catalan(n), 4).
 * @author Georg Fischer
 */
public class A119549 extends AbstractSequence {

  private int mN = -1; 
  
  public A119549() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return Binomial.binomial(Binomial.catalan(mN),Z.FOUR);
  }
}