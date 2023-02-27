package irvine.oeis.a088;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a069.A069543;

/**
 * A088410 a(n) = A069543(n)/8.
 * @author Georg Fischer
 */
public class A088410 extends A069543 {

  @Override
  public Z next() {
    return super.next().divide(8);
  }
}