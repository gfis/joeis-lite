package irvine.oeis.a064;
// generated by patch_offset.pl at 2022-09-02 08:43

import irvine.math.z.Z;
import irvine.oeis.ca.Cellular1DAutomaton;

/**
 * A064455 a(2n) = 3n, a(2n-1) = n.
 * @author Georg Fischer
 */
public class A064455 extends Cellular1DAutomaton {

  /** Construct the sequence. */
  public A064455() {
    super(1, 54, 1);
  }

  @Override
  public Z next() {
    return super.nextBlackCount();
  }
}
