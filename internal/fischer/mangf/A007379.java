package irvine.oeis.a007;

import irvine.oeis.a002.A002517;
import irvine.oeis.a008.A008586; // a(n) = 4*n

/**
 * A007379 Earliest sequence with a(a(n)) = 4n.
 * @author Georg Fischer
 */
public class A007379 extends A002517 {

  /** Construct the sequence. */
  public A007379() {
    super(0, new A008586());
  }

}
