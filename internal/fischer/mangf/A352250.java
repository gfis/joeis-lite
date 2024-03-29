package irvine.oeis.a352;
// Generated by gen_seq4.pl robots/egfue at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A352250 Expansion of e.g.f. 1 / (1 - x * sin(x)) (even powers only).
 * E.g.f.: 1 / (1 - x * sin(x))
 * @author Georg Fischer
 */
public class A352250 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A352250() {
    super(0, 0, 2);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.one(),RING.multiply(RING.x(),RING.sin(RING.x(),mN),mN)),mN);
  }
}
