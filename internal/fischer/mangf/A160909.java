package irvine.oeis.a160;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a180.A180363;

/**
 * A160909 Row sums of triangle defined in A096539.
 * @author Georg Fischer
 */
public class A160909 extends A180363 {

  @Override
  public Z next() {
    return super.next().subtract(1);
  }
}