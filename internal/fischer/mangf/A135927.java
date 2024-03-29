package irvine.oeis.a135;
// generated by patch_offset.pl at 2022-08-27 22:36

import irvine.math.z.Z;
import irvine.oeis.recur.ConstantOrderRecurrence;

/**
 * A135927 a(n) = a(n-1)^2 - 2 with a(1) = 10.
 * @author Georg Fischer
 */
public class A135927 extends ConstantOrderRecurrence {

  /** Construct the sequence */
  public A135927() {
    super(1, 1, 0, 10);
  }

  @Override
  protected Z compute(final int n) {
    return a(n - 1).square().subtract(2);
  }
}
