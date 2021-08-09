package irvine.oeis.a006;

import irvine.math.cr.CR;
import irvine.oeis.EgyptianFractionSequence;

/**
 * A006487 Denominators of greedy Egyptian fraction for square root of 2.
 * @author Georg Fischer
 */
public class A006487 extends EgyptianFractionSequence {

  /** Construct the sequence */
  public A006487() {
    super(CR.valueOf(2).sqrt());
  }
}
