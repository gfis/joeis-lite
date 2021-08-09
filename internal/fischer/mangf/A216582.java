package irvine.oeis.a216;
// manually (decexp) at 2021-07-13 17:23

import irvine.math.cr.CR;
import irvine.oeis.DecimalExpansionSequence;

/**
 * A216582 Decimal expansion of the logarithm of Pi to base 2.
 * @author Georg Fischer
 */
public class A216582 extends DecimalExpansionSequence {

  /** Construct the sequence */
  public A216582() {
    super(1, CR.PI.log().divide(CR.TWO).log());
  }
}
