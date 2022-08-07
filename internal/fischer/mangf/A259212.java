package irvine.oeis.a259;
// manually hygeom at 2022-08-06 15:16

import irvine.math.factorial.MemoryFactorial;
import irvine.math.z.Z;
import irvine.oeis.HypergeometricSequence;

/**
 * A259212 A total of n married couples, including a mathematician M and his wife W, are to be seated at the 2n chairs around a circular table. M and W are the first couple allowed to choose chairs, and they choose two chairs next to each other. The sequence gives th
 * @author Georg Fischer
 */
public class A259212 extends HypergeometricSequence {

  private int mN = 0;
  
  /** Construct the sequence. */
  public A259212() {
    super(1, 3,1, "[[1],[1,-1],[0,1],[1/2],[1/4]]");
  }

  @Override
  public Z next() {
    ++mN;
    if (mN == 1) {
      super.next();
      return Z.ZERO;
    } else {
      return super.nextQ().multiply(((mN & 1) == 1) ? 1 : -1).multiply(MemoryFactorial.SINGLETON.factorial(mN-1)).num();
    }
  }
}
