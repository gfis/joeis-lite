package irvine.oeis.a080;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A080030 a(n) is taken to be the smallest positive integer not already present which is consistent with the condition &quot;n is a member of the sequence if and only if a(n) is congruent to 1 mod 3&quot;.
 * <code>a(3m)=3m+2, a(3m+1)=6m+1, a(3m+2)=6m+4</code>.
 * @author Georg Fischer
 */
public class A080030 implements Sequence {

  private int mN = -1;

  @Override
  public Z next() {
    ++mN;
    int mod = mN / 3;
    switch (mN % 3) {
      default:
      case 0:
        return Z.valueOf(3 * mod + 2);
      case 1:
        return Z.valueOf(6 * mod + 1);
      case 2:
        return Z.valueOf(6 * mod + 4);
    }
  }
}
