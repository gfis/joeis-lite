package irvine.oeis.a293;
// manually sumdiv at 2023-04-03 19:14

import irvine.math.z.Euler;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A293820 Number of integer-sided polygons having perimeter n, modulo rotations but not reflections.
 * @author Georg Fischer
 */
public class A293820 extends AbstractSequence {

  private int mN = 2;

  /** Construct the sequence. */
  public A293820() {
    super(3);
  }

  @Override
  public Z next() {
    ++mN;
    return Integers.SINGLETON.sumdiv(mN, d -> Euler.phi(Z.valueOf(mN/d)).multiply(Z.ONE.shiftLeft(d))).divide(mN).subtract(1).subtract(Z.ONE.shiftLeft(mN / 2));
  }
}
