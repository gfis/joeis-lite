package irvine.oeis.a126;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A126605 Final three digits of 2^n.
 * @author Georg Fischer
 */
public class A126605 implements Sequence {

  private int mN = -1;
  final private static Z THOUSAND = Z.valueOf(1000);

  @Override
  public Z next() {
    return Z.ONE.shiftLeft(++mN).mod(THOUSAND);
  }
}
