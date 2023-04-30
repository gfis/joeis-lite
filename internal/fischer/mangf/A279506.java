package irvine.oeis.a279;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Z;
import irvine.oeis.a003.A003418;

/**
 * A279506 Total number of 1&apos;s in the binary expansion of A003418.
 * @author Georg Fischer
 */
public class A279506 extends A003418 {
  @Override
  public Z next() {
    return Z.valueOf(super.next().bitCount());
  }
}