package irvine.oeis.a352;
// manually 2023-06-10

import irvine.math.z.Z;
import irvine.oeis.transform.GeneralizedEulerTransform;

/**
 * A352402 Expansion of Product_{k>=1} 1 / (1 + 2^(k-1)*x^k).
 * @author Georg Fischer
 */
public class A352402 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A352402() {
    super(0, 1, k -> new Z[]{Z.ONE}, k -> Z.TWO.pow(k - 1).negate());
  }
}
