package irvine.oeis.a321;

import irvine.factor.factor.Cheetah;
import irvine.math.z.Z;
import irvine.math.MemoryFunction1;
import irvine.math.Mobius;
import irvine.oeis.Sequence;
import irvine.oeis.a007.A007434;

/**
 * A321322 a(n) = Sum_{d|n} mu(n/d)*J_2(d), where J_2() is the Jordan function (A007434).
 * @author Georg Fischer
 */
public class A321322 extends A007434 {

  protected long mN = 0;
  protected Sequence mSeq = new A007434();
  
  /** Construct the sequence */
  public A321322() {
  }

  @Override
  public Z next() {
    Z sum = Z.ZERO;
    for (final Z d : Cheetah.factor(++mN).divisors()) {
      sum = sum.add(  .multiply(Mobius.mobius(mN / d.longValue())));
    }
    return sum;
  }
}