package irvine.oeis.a358;
// Generated by gen_seq4.pl decexro at 2023-01-13 08:23

import irvine.math.cr.CR;
import irvine.math.polynomial.Polynomial;
import irvine.oeis.cons.PolynomialRootExpansionSequence;
/**
 * A358939 Decimal expansion of the real root of x^5 + x^3 - 1.
 * Polynomial: x^5+x^3-1
 * @author Georg Fischer
 */
public class A358939 extends PolynomialRootExpansionSequence {

  /** Construct the sequence */
  public A358939() {
    super(0, Polynomial.create(-1,0,0,1,0,1), CR.valueOf(0.8), CR.valueOf(0.9));
  }
}
