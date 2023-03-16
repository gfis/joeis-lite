package irvine.oeis.a140;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Z;
import irvine.oeis.a049.A049606;

/**
 * A140105 Trailing zeros removed from n! in binary.
 * @author Georg Fischer
 */
public class A140105 extends A049606 {
  @Override
  public Z next() {
    return new Z(super.next().toString(2));
  }
}
