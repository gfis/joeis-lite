package irvine.oeis.a317;

import irvine.oeis.a012.A012245;
import irvine.oeis.cons.ContinuedFractionSequence;

/**
 * A317413 Continued fraction for binary expansion of Liouville&apos;s number interpreted in base 2 (A092874).
 * @author Georg Fischer
 */
public class A317413 extends ContinuedFractionSequence {

  /** Construct the sequence */
  public A317413() {
    super(new A012245(), 2);
  }
}
