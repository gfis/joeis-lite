package irvine.oeis.a256;
// Generated by gen_seq4.pl decexp at 2021-07-13 19:14

import irvine.math.cr.CR;
import irvine.oeis.cons.DecimalExpansionSequence;

/**
 * A256844 Decimal expansion of the generalized Euler constant gamma(3,3) (negated).
 * @author Georg Fischer
 */
public class A256844 extends DecimalExpansionSequence {

  /** Construct the sequence. */
  public A256844() {
    super(0, CR.GAMMA.divide(CR.THREE).subtract(CR.THREE.log().divide(CR.THREE)));
    next();
    next();
  }
}
