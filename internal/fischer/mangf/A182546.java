package irvine.oeis.a182;
// manually (decexpr) at 2021-07-19

import irvine.math.cr.CR;
import irvine.math.cr.ComputableReals;
import irvine.oeis.DecimalExpansionSequence;

/**
 * A182546 Decimal expansion of | log_phi(i) |, where phi is the golden ratio and i is the imaginary unit.
 * Formula: acos(0)/log(phi)
 * @author Georg Fischer
 */
public class A182546 extends DecimalExpansionSequence {

  private static final ComputableReals REALS = ComputableReals.SINGLETON;

  /** Construct the sequence */
  public A182546() {
    super(1, REALS.acos(CR.ZERO).divide(CR.PHI.log()).abs());
  }
}
