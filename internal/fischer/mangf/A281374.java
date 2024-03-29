package irvine.oeis.a281;
// Generated by gen_seq4.pl rootet at 2023-02-21 22:24

import irvine.oeis.SkipSequence;
import irvine.oeis.a006.A006352;
import irvine.oeis.transform.RootSequence;

/**
 * A281374 Coefficients in q-expansion of E_2^2, where E_2 is the Eisenstein series shown in A006352.
 * @author Georg Fischer
 */
public class A281374 extends RootSequence {

  /** Construct the sequence. */
  public A281374() {
    super(0, new SkipSequence(new A006352(), 1), 2, 1);
  }
}
