package irvine.oeis.a275;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a060.A060501;

/**
 * A275849 Number of unoccupied slopes in factorial base representation of n: a(n) = A084558(n) - A060502(n).
 * @author Georg Fischer
 */
public class A275849 extends A060501 {

  @Override
  public Z next() {
    return super.next().subtract(1);
  }
}
