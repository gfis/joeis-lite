package irvine.oeis.a297;
// manually 2021-07-05

import irvine.math.z.Z;
import irvine.oeis.MobiusTransformSequence;
import irvine.oeis.SkipSequence;
import irvine.oeis.a000.A000120;

/**
 * A297115 Möbius transform of A000120, binary weight of n.
 * @author Georg Fischer
 */
public class A297115 extends SkipSequence {
  
  public A297115() {
    super(new MobiusTransformSequence(new A000120(), 1), 1);
  }
}
