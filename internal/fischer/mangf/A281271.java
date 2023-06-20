package irvine.oeis.a281;
// manually 2023-06-09

import irvine.math.z.Z;
import irvine.oeis.transform.GeneralizedEulerTransform;


/**
 * A281271 Expansion of Product_{k&gt;=1} (1 + x^(5*k-2)).
 * G.f.: <code>Product_{k&gt;=1} ((1+x^(5*k-2)))</code>
 * @author Georg Fischer
 */
public class A281271 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A281271() {
    super(0, 1, k -> new Z[]{Z.NEG_ONE}, k -> Z.NEG_ONE, k -> Z.valueOf(5 * k - 2));
    mNextH = advanceH(mKh);
  }
}
