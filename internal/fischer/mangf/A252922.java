package irvine.oeis.a252;
// manually simbinom at 2023-03-17 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A252922 a(n) = sigma(n-1) + sigma(n-2) + sigma(n-3), with a(1)=0, a(2)=1, a(3)=4.
 * @author Georg Fischer
 */
public class A252922 extends AbstractSequence {

  private int mN = 0; 
  
  public A252922() {
    super(1);
  }

  @Override
  public Z next() {
    ++mN;
    if (mN == 1) {
      return Z.ZERO;
    }
    if (mN == 2) {
      return Z.ONE;
    }
    if (mN == 3) {
      return Z.FOUR;
    }
    return Jaguar.factor(mN - 1).sigma().add(Jaguar.factor(mN - 2).sigma()).add(Jaguar.factor(mN - 3).sigma());
  }
}
