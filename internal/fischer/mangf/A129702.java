package irvine.oeis.a129;

import irvine.math.cr.CR;
import irvine.oeis.EgyptianFractionSequence;

/**
 * A129702 Egyptian Fraction representation for the cube root of 2.
 * @author Georg Fischer
 */
public class A129702 extends EgyptianFractionSequence {

  /** Construct the sequence */
  public A129702() {
    super(CR.valueOf(2).log().divide(CR.THREE).exp());
    next();
  }
}
