package irvine.oeis.a299;
// Generated by gen_seq4.pl rootet at 2023-02-18 22:29

import irvine.math.z.Z;
import irvine.oeis.SkipSequence;
import irvine.oeis.a289.A289210;
import irvine.oeis.transform.RootSequence;

/**
 * A299943 Coefficients in expansion of (E_4^3/E_6^2)^(1/36).
 * (k=8)
 * @author Georg Fischer
 */
public class A299943 extends RootSequence {

  /** Construct the sequence. */
  public A299943() {
    super(0, new SkipSequence(new A289210(), 1), -8, 288);
  }
}
