package irvine.oeis.a038;

import irvine.oeis.a002.A002517;
import irvine.oeis.a000.A000041; // partitions(n)

/**
 * A038752 Earliest sequence where a(a(n))=number of partitions of n.
 * @author Georg Fischer
 */
public class A038752 extends A002517 {

  /** Construct the sequence. */
  public A038752() {
    super(0, new A000041());
  }

}
