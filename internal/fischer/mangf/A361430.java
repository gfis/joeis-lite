package irvine.oeis.a361;
// Generated by gen_seq4.pl multm/mult at 2023-03-28 18:24

import irvine.math.z.Z;
import irvine.oeis.MultiplicativeSequence;

/**
 * A361430 Multiplicative with a(p^e) = e - 1.
 * @author Georg Fischer
 */
public class A361430 extends MultiplicativeSequence {

  /** Construct the sequence. */
  public A361430() {
    super(1, (p,e) -> Z.valueOf(e - 1));
  }
}
