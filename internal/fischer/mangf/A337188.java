package irvine.oeis.a337;
// generated by patch_offset.pl at 2022-08-27 22:36

import irvine.math.z.Z;
import irvine.oeis.recur.ConstantOrderRecurrence;

/**
 * A337188 a(n) = determinant([a(n-1), a(n-2); a(n-4), a(n-3)]) for n &gt;= 5, a(n) = n otherwise.
 * @author Georg Fischer
 */
public class A337188 extends ConstantOrderRecurrence {

  /** Construct the sequence */
  public A337188() {
    super(1, 4, 0, 1, 2, 3, 4);
  }

  @Override
  protected Z compute(final int n) {
    return a(n - 1).multiply(a(n - 3)).subtract(a(n - 2).multiply(a(n - 4)));
  }
}
