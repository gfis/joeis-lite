package irvine.oeis.a360;
// Generated by gen_seq4.pl multm/mult at 2023-03-28 18:24

import irvine.math.z.Z;
import irvine.oeis.MultiplicativeSequence;

/**
 * A360908 Multiplicative with a(p^e) = 2*e - 1.
 * @author Georg Fischer
 */
public class A360908 extends MultiplicativeSequence {

  /** Construct the sequence. */
  public A360908() {
    super(1, (p,e) -> Z.valueOf(2 * e - 1));
  }
}
