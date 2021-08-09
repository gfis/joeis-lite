package irvine.oeis.a038;
// manually 2020-12-30

import irvine.math.z.Z;
import irvine.oeis.InverseEulerTransform;
import irvine.oeis.Sequence;
import irvine.oeis.a274.A274981;

/**
 * A038065 Product_{k>=1}1/(1 - x^k)^a(k) = 1 + 4x.
 * @author Georg Fischer
 */
public class A038065 extends InverseEulerTransform {

  /** Construct the sequence. */
  public A038065() {
    super(new A274981(), 1);
    next();
  }
}
