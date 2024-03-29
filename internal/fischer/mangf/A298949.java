package irvine.oeis.a298;
// Generated by gen_seq4.pl convinv/rootet at 2023-02-21 22:24

import irvine.oeis.SkipSequence;
import irvine.oeis.a000.A000119;
import irvine.oeis.transform.RootSequence;

/**
 * A298949 Expansion of Product_{k&gt;=2} 1/(1 + x^{F_k}) where F_k are the Fibonacci numbers.
 * @author Georg Fischer
 */
public class A298949 extends RootSequence {

  /** Construct the sequence. */
  public A298949() {
    super(0, new SkipSequence(new A000119(), 1), -1, 1);
  }
}
