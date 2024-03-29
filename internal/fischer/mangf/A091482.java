package irvine.oeis.a091;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A091482 a(n) = (3*n)^n.
 * @author Georg Fischer
 */
public class A091482 implements Sequence {

  protected int mN = -1;

  @Override
  public Z next() {
    return ++mN == 0 ? Z.ONE : Z.valueOf(3 * mN).pow(mN);
  }
}
