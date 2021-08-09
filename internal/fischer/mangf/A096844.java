package irvine.oeis.a096;
// manually 2021-06-26

import irvine.oeis.a098.A098941;

/**
 * A096844 Numbers where 0 is the only even decimal digit.
 * @author Georg Fischer
 */
public class A096844 extends A098941 {

  /** Construct the sequence. */
  public A096844() {
    super("[013579]*0[013579]*");
    mN = -1; // not offset1
  }
}