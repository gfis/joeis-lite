package irvine.oeis.a074;
// generated by patch_offset.pl at 2022-08-27 22:36

import irvine.math.z.Z;
import irvine.oeis.recur.ConstantOrderRecurrence;

/**
 * A074394 a(n) = a(n-1)*a(n-2) - a(n-3) with a(1) = 1, a(2) = 2, and a(3) = 3.
 * @author Georg Fischer
 */
public class A074394 extends ConstantOrderRecurrence {

  /** Construct the sequence */
  public A074394() {
    super(1, 3, 0, 1, 2, 3);
  }

  @Override
  protected Z compute(final int n) {
    return a(n - 1).multiply(a(n - 2)).subtract(a(n - 3));
  }
}
