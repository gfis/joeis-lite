package irvine.oeis.a327;
// Generated by gen_seq4.pl deris/binomx at 2022-12-15 10:39

import irvine.oeis.a327.A327362;
import irvine.oeis.transform.BinomialTransformSequence;

/**
 * A327364 Number of labeled simple graphs with n vertices, a connected edge-set, and at least one endpoint (vertex of degree 1).
 * @author Georg Fischer
 */
public class A327364 extends BinomialTransformSequence {

  /** Construct the sequence. */
  public A327364() {
    super(new A327362(), 0);
  }
}
