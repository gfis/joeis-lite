package irvine.oeis.a073;

import irvine.oeis.a002.A002517;
import irvine.oeis.a000.A000069; // odious numbers

/**
 * A065804 Earliest sequence with a(a(n))=n!.
 * @author Georg Fischer
 */
public class A073074 extends A002517 {

  /** Construct the sequence. */
  public A073074() {
    super(1, new A000069());
  }

}
