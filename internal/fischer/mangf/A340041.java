package irvine.oeis.a340;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a058.A058044;

/**
 * A340041 The prime gap, divided by two, which surrounds p#.
 * @author Georg Fischer
 */
public class A340041 extends A058044 {

  @Override
  public Z next() {
    return super.next().divide2();
  }
}