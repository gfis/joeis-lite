package irvine.oeis.a065;

import irvine.oeis.InverseAronsonTransform;
import irvine.oeis.a000.A000142; // a(n) = n!

/**
 * A065804 Earliest sequence with a(a(n))=n!.
 * @author Georg Fischer
 */
public class A065804 extends InverseAronsonTransform {

  /** Construct the sequence. */
  public A065804() {
    super(0, new A000142(), 0);
  }

}
