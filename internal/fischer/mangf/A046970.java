package irvine.oeis.a046;

import irvine.factor.factor.Cheetah;
import irvine.math.z.Z;
import irvine.math.Mobius;
import irvine.oeis.Sequence;

/**
 * A046970 Dirichlet inverse of the Jordan function J_2 (A007434).
 * a(n) = Sum_{d|n} mu(d)*d^2.
 * @author Georg Fischer
 */
public class A046970 implements Sequence {

  protected long mN; // current index
  
  /** Construct the sequence */
  public A046970() {
    mN = 0;
  }

  @Override
  public Z next() {
    Z sum = Z.ZERO;
    for (final Z d : Cheetah.factor(++mN).divisors()) {
      sum = sum.add(d.square().multiply(Mobius.mobius(d.longValue())));
    }
    return sum;
  }
}