package irvine.oeis.a139;
// manually A139056/parmof2 at 2022-05-24 11:23

import irvine.oeis.a139.A139160;

/**
 * A139194 Natural numbers of the form (prime(n)!-6)/6.
 * @author Georg Fischer
 */
public class A139194 extends A139160 {

  /** Construct the sequence. */
  public A139194() {
    super(1, -6);
    next();
  }
}
