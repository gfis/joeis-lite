package irvine.oeis.a255;
// Generated by gen_seq4.pl decexp at 2021-07-12 23:03

import irvine.math.cr.CR;
import irvine.oeis.cons.DecimalExpansionSequence;

/**
 * A255240 Decimal expansion of 1/(2*cos(Pi/7)).
 * @author Georg Fischer
 */
public class A255240 extends DecimalExpansionSequence {

  /** Construct the sequence. */
  public A255240() {
    super(0, CR.ONE.divide(CR.TWO.multiply(CR.PI.divide(CR.SEVEN).cos())));
  }
}
