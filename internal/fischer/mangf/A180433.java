package irvine.oeis.a180;
// manually (decexprb) at 2021-07-18

import irvine.math.cr.CR;
import irvine.math.cr.ComputableReals;
import irvine.math.z.Z;
import irvine.oeis.DecimalExpansionSequence;

/**
 * A180433 Binary string formed from the binary expansion of Pi by exchanging 0's and 1's.
 * Formula: Pi
 * @author Georg Fischer
 */
public class A180433 extends DecimalExpansionSequence {

  private static final ComputableReals REALS = ComputableReals.SINGLETON;

  /** Construct the sequence */
  public A180433() {
    super(1, CR.PI, 2);
  }
  
  @Override
  public Z next() {
    return super.next().isZero() ? Z.ONE : Z.ZERO;
  }
}
