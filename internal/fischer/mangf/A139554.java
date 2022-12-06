package irvine.oeis.a139;
// manually doubled

import irvine.math.z.Z;
import irvine.oeis.DoubledSequence;
import irvine.oeis.a139.A139550;

/**
 * A139554 a(n) = lcm(1..floor(n/4)).
 * @author Georg Fischer
 */
public class A139554 extends DoubledSequence {

  public A139554 () {
    super(0, new A139550());
  }
}
