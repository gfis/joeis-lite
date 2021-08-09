package irvine.oeis.a038;
// manually 2020-12-30

import irvine.math.z.Z;
import irvine.oeis.InverseEulerTransform;
import irvine.oeis.Sequence;
import irvine.oeis.a152.A152623;

/**
 * A038065 Product_{k>=1}1/(1 - x^k)^a(k) = 1 + 5x.
 * @author Georg Fischer
 */
public class A038066 extends InverseEulerTransform {

  /** Construct the sequence. */
  public A038066() {
    super(new A152623(), 1);
    next();
  }
}
