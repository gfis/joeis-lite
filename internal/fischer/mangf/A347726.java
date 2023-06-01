package irvine.oeis.a347;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A347726 Expansion of e.g.f.: exp(x / (1-x)^x).
 * E.g.f.: exp(x / (1-x)^x)
 * @author Georg Fischer
 */
public class A347726 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A347726() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.series(RING.x(),RING.exp(RING.multiply(RING.log(RING.oneMinusXToTheN(1),mN),RING.x(),mN),mN),mN),mN);
  }
}