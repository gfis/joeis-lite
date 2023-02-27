package irvine.oeis.a244;
// Generated by gen_seq4.pl rootet at 2023-02-21 22:24

import irvine.oeis.SkipSequence;
import irvine.oeis.a244.A244525;
import irvine.oeis.transform.RootSequence;

/**
 * A244560 Expansion of f(-x^1, -x^7)^2 in powers of x where f() is Ramanujan&apos;s two-variable theta function.
 * @author Georg Fischer
 */
public class A244560 extends RootSequence {

  /** Construct the sequence. */
  public A244560() {
    super(0, new SkipSequence(new A244525(), 1), 2, 1);
  }
}
