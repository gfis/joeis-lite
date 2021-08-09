package irvine.oeis.a124;
// manually 2021-01-01

import irvine.math.z.Z;
import irvine.oeis.InverseWeighTransform;
import irvine.oeis.a003.A003400;

/**
 * A038001 Inverse WEIGH transform of A038000.
 * @author Georg Fischer
 */
public class A124059 extends InverseWeighTransform {

  /** Construct the sequence */
  public A124059() {
    super(new A003400());
  }
}
