package irvine.oeis.a099;
// generated by patch_offset.pl at 2022-09-02 21:07

import irvine.math.z.Z;
import irvine.oeis.a001.A001113;

/**
 * A099986 Bisection of A001113 (digits of e).
 * @author Georg Fischer
 */
public class A099986 extends A001113 {
  
  /** Construct the sequence. */
  public A099986() {
    super(0);
  }

  @Override
  public Z next() {
    final Z result = super.next();
    super.next();
    return result;
  }
}
