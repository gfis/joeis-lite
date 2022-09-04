package irvine.oeis.a256;
// Generated by gen_seq4.pl decexp at 2021-07-13 19:14

import irvine.math.cr.CR;
import irvine.oeis.cons.DecimalExpansionSequence;

/**
 * A256849 Decimal expansion of the generalized Euler constant gamma(4,5) (negated).
 * @author Georg Fischer
 */
public class A256849 extends DecimalExpansionSequence {

  /** Construct the sequence. */
  public A256849() {
    super(0, CR.GAMMA.divide(CR.FIVE).subtract(CR.PI.divide(CR.TEN.multiply(CR.TWO.multiply(CR.FIVE.subtract(CR.FIVE.sqrt())).sqrt())))
        .subtract(CR.PI.divide(CR.TWO.multiply(CR.TEN.multiply(CR.FIVE.subtract(CR.FIVE.sqrt())).sqrt()))).add(CR.FIVE.log().divide(CR.valueOf(20)))
        .subtract(CR.FIVE.subtract(CR.FIVE.sqrt()).log().divide(CR.FOUR.multiply(CR.FIVE.sqrt()))).add(CR.FIVE.add(CR.FIVE.sqrt()).log().divide(CR.FOUR.multiply(CR.FIVE.sqrt()))));
    next();
    next();
  }
}
