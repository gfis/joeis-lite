package irvine.oeis.a356;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A356818 Expansion of e.g.f. exp(-x * (exp(x) + 1)).
 * E.g.f.: exp(-x * (exp(x) + 1))
 * @author Georg Fischer
 */
public class A356818 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A356818() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.subtract(RING.zero(),RING.multiply(RING.x(),RING.add(RING.exp(RING.x(),mN),RING.one()),mN)),mN);
  }
}
