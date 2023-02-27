package irvine.oeis.a352;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a200.A200993;

/**
 * A352181 a(n) = A200993(n)/2.
 * @author Georg Fischer
 */
public class A352181 extends A200993 {

  @Override
  public Z next() {
    return super.next().divide2();
  }
}