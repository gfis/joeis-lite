package irvine.oeis.a139;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a109.A109611;

/**
 * A139690 a(n) = A109611(n) + 2.
 * @author Georg Fischer
 */
public class A139690 extends A109611 {

  @Override
  public Z next() {
    return super.next().add(2);
  }
}
