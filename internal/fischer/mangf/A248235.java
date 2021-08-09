package irvine.oeis.a248;

import irvine.math.cr.CR;
import irvine.oeis.EgyptianFractionSequence;

/**
 * A248235 Egyptian fraction representation of sqrt(5) (A002163) using a greedy function.
 * @author Georg Fischer
 */
  public class A248235 extends EgyptianFractionSequence {

  /** Construct the sequence */
  public A248235() {
    super(CR.valueOf(5).sqrt());
  }
}
