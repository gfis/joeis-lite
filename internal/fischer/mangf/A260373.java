package irvine.oeis.a260;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a055.A055227;

/**
 * A260373 The nearest perfect square to n!
 * @author Georg Fischer
 */
public class A260373 extends A055227 {

  @Override
  public Z next() {
    return super.next().square();
  }
}
