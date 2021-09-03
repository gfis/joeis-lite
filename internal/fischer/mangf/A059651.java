package irvine.oeis.a059;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A059651 a(n) = [[(k^2)*n]-(k*[k*n])], where k = cube root of 2 and [] is the floor function.
 * @author Georg Fischer
 */
public class A059651 extends FloorSequence {

  private final CR mK = CR.TWO.pow(CR.ONE_THIRD);

  /** Construct the sequence */
  public A059651() {
    super(0);
  }

  @Override
  public Z evalCR(final long mN) {
    return CR.valueOf(mK.pow(2).multiply(CR.valueOf(mN)).floor())
        .subtract(mK.multiply(mK.multiply(CR.valueOf(mN)).floor())).floor();
  }

}
