package irvine.oeis.a289;
// Generated by gen_seq4.pl rootet at 2023-02-18 22:29

import irvine.math.z.Z;
import irvine.oeis.SkipSequence;
import irvine.oeis.a289.A289063;
import irvine.oeis.transform.RootSequence;

/**
 * A289561 Coefficients of 1/(q*(j(q)-1728))^2 where j(q) is the elliptic modular invariant.
 * (k=-48)
 * @author Georg Fischer
 */
public class A289561 extends RootSequence {

  /** Construct the sequence. */
  public A289561() {
    super(0, new SkipSequence(new A289063(), 1), -48, 24);
  }
}
