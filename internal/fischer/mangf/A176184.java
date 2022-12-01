package irvine.oeis.a176;
// Generated by gen_seq4.pl doubled

import irvine.math.z.Z;
import irvine.oeis.DoubledSequence;
import irvine.oeis.a164.A164555;

/**
 * A176184 a(2n) = A027641(n). a(2n+1) = A164555(n).
 * @author Georg Fischer
 */
public class A176184 extends DoubledSequence {

  public A176184() {
    super(0, 2, new A164555(), 1, 1, -1, 1);
  }
}
