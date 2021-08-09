package irvine.oeis.a171;
// manually 2021-06-24

import irvine.math.z.Z;
import irvine.oeis.a001.A001146;
import irvine.oeis.PrependSequence;

/**
 * A171163 Number of children at height n in a doubly logarithmic tree. Leaves are at height 0.
 * @author Georg Fischer
 */
public class A171163 extends PrependSequence {

  public A171163() {
    super(new A001146(), 0, 2);
  }
}
