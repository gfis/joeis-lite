package irvine.oeis.a360;
// Generated by gen_seq4.pl multm/mult at 2023-03-28 18:24

import irvine.math.z.Z;
import irvine.oeis.MultiplicativeSequence;

/**
 * A360911 Multiplicative with a(p^e) = 3*e - 2.
 * @author Georg Fischer
 */
public class A360911 extends MultiplicativeSequence {

  /** Construct the sequence. */
  public A360911() {
    super(1, (p,e) -> Z.valueOf(3 * e - 2));
  }
}