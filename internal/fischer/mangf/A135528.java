package irvine.oeis.a135;
// generated by patch_offset.pl at 2022-09-02 08:43

import irvine.math.z.Z;
import irvine.oeis.ca.Cellular1DAutomaton;

/**
 * A135528 1, then repeat 1,0.
 * @author Georg Fischer
 */
public class A135528 extends Cellular1DAutomaton {

  /** Construct the sequence. */
  public A135528() {
    super(1, 117, 1);
  }

  @Override
  public Z next() {
    return super.nextMiddle();
  }
}