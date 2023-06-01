package irvine.oeis.a351;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A351423 Expansion of e.g.f. -log(1 - log(1 + log(1 + log(1 + log(1+x))))).
 * E.g.f.: -log(1 - log(1 + log(1 + log(1 + log(1+x)))))
 * @author Georg Fischer
 */
public class A351423 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A351423() {
    super(1);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.subtract(RING.zero(),RING.log(RING.subtract(RING.one(),RING.log(RING.add(RING.one(),RING.log(RING.add(RING.one(),RING.log(RING.add(RING.one(),RING.log(RING.onePlusXToTheN(1),mN)),mN)),mN)),mN)),mN));
  }
}