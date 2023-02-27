package irvine.oeis.a064;
// Generated by gen_seq4.pl build/parm4 at 2023-02-21 22:23

import irvine.math.z.Z;
import irvine.oeis.a064.A064560;
/**
 * A064566 Reciprocal of n terminates with an infinite repetition of digit 7. Multiples of 10 are omitted.
 * @author Georg Fischer
 */
public class A064566 extends A064560 {

  /** Construct the sequence. */
  public A064566() {
    super(1, i -> Z.ONE.shiftLeft(6*i - 4).multiply(Z.NINE), i -> Z.FIVE.pow(6*i - 2).multiply(Z.NINE));
  }
}