package irvine.oeis.a139;

import irvine.math.z.Z;
import irvine.oeis.Sequence0;

/**
 * A139354 Let the binary expansion of n be n = Sum_{k} 2^{r_k}, let e(n) be the number of r_k&apos;s that are even, 
 * o(n) the number that are odd; sequence gives min{e(n), o(n)}.
 * @author Georg Fischer
 */
public class A139354 extends Sequence0 {

  private long mN = -1;

  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(Long.bitCount(mN & 0xAAAAAAAAL)).min(Z.valueOf(Long.bitCount(mN & 0x55555555L)));
  }
}
