package irvine.oeis.a204;
// manually triuple at 2021-10-24 21:04

import irvine.math.z.Z;
import irvine.oeis.triangle.UpperLeftTriangle;

/**
 * A204143 Symmetric matrix based on f(i,j)=max(ceiling(i/j),ceiling(j/i)), by antidiagonals.
 * @author Georg Fischer
 */
public class A204143 extends UpperLeftTriangle {

  /** Construct the sequence. */
  public A204143() {
    super(1, 1, -1);
  }
  
  public static int ceil(final int i, final int j) {
    return i % j == 0 ? i / j : i / j + 1;
  }
  
  @Override
  public Z matrixElement(final int i, final int j) {
    return Z.valueOf(Math.max(ceil(i, j), ceil(j, i)));
  }
}
