package irvine.oeis.a038;
// manually 2021-01-01

import irvine.math.z.Z;
import irvine.oeis.InverseWeighTransform;
import irvine.oeis.a038.A038000;

/**
 * A038001 Inverse WEIGH transform of A038000.
 * @author Georg Fischer
 */
public class A038001 extends InverseWeighTransform {

  /** Construct the sequence */
  public A038001() {
    super(new A038000());
  }
}
