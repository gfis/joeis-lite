package irvine.oeis.a067;
// Generated by gen_seq4.pl simple/simbinom at 2023-03-20 18:29

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A067770 a(n) = Catalan(n) mod (n+2).
 * @author Georg Fischer
 */
public class A067770 extends AbstractSequence {

  private int mN = -1; 
  
  public A067770() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return Binomial.catalan(mN).mod(Z.TWO.add(mN));
  }
}