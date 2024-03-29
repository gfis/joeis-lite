package irvine.oeis.a358;
// Generated by gen_seq4.pl decexro at 2023-01-13 08:23

import irvine.math.cr.CR;
import irvine.math.polynomial.Polynomial;
import irvine.oeis.cons.PolynomialRootExpansionSequence;
/**
 * A358181 Decimal expansion of the real root of x^3 - 2*x^2 - x - 1.
 * Polynomial: x^3-2*x^2-x-1
 * @author Georg Fischer
 */
public class A358181 extends PolynomialRootExpansionSequence {

  /** Construct the sequence */
  public A358181() {
    super(1, Polynomial.create(-1,-1,-2,1), CR.valueOf(2), CR.valueOf(3));
  }
}
