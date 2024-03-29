package irvine.oeis.a323;

import irvine.math.z.Z;
import irvine.oeis.Combiner;
import irvine.oeis.SkipSequence;
import irvine.oeis.a126.A126760;

/**
 * A323882 Sum of A126760 and its Dirichlet inverse.
 * @author Georg Fischer
 */
public class A323882 extends Combiner {

  /** Construct the sequence. */
  public A323882() {
    super(1, new SkipSequence(new A126760(), 1), new A323881(), ADD);
  }
}
