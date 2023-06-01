package irvine.oeis.a114;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A114937 Number of connected (5,n)-hypergraphs (without empty edges).
 * E.g.f.: (1/120)*(exp(31*x) - 5*exp(16*x) + 10*exp(15*x) - 10*exp(10*x) + 20*exp(9*x) - 40*exp(8*x) + 65*exp(7*x) - 90*exp(6*x) + 144*exp(5*x) - 165*exp(4*x) + 120*exp(3*x) - 50*exp(2*x) + 24*exp(x) - 24)
 * @author Georg Fischer
 */
public class A114937 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A114937() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.multiply(RING.series(RING.one(),RING.monomial(new Q(120),0),mN),RING.subtract(RING.add(RING.subtract(RING.add(RING.subtract(RING.add(RING.subtract(RING.add(RING.subtract(RING.add(RING.subtract(RING.add(RING.subtract(RING.exp(RING.monomial(new Q(31),1),mN),RING.multiply(RING.monomial(new Q(5),0),RING.exp(RING.monomial(new Q(16),1),mN),mN)),RING.multiply(RING.monomial(new Q(10),0),RING.exp(RING.monomial(new Q(15),1),mN),mN)),RING.multiply(RING.monomial(new Q(10),0),RING.exp(RING.monomial(new Q(10),1),mN),mN)),RING.multiply(RING.monomial(new Q(20),0),RING.exp(RING.monomial(new Q(9),1),mN),mN)),RING.multiply(RING.monomial(new Q(40),0),RING.exp(RING.monomial(new Q(8),1),mN),mN)),RING.multiply(RING.monomial(new Q(65),0),RING.exp(RING.monomial(new Q(7),1),mN),mN)),RING.multiply(RING.monomial(new Q(90),0),RING.exp(RING.monomial(new Q(6),1),mN),mN)),RING.multiply(RING.monomial(new Q(144),0),RING.exp(RING.monomial(new Q(5),1),mN),mN)),RING.multiply(RING.monomial(new Q(165),0),RING.exp(RING.monomial(new Q(4),1),mN),mN)),RING.multiply(RING.monomial(new Q(120),0),RING.exp(RING.monomial(new Q(3),1),mN),mN)),RING.multiply(RING.monomial(new Q(50),0),RING.exp(RING.monomial(new Q(2),1),mN),mN)),RING.multiply(RING.monomial(new Q(24),0),RING.exp(RING.x(),mN),mN)),RING.monomial(new Q(24),0)),mN);
  }
}