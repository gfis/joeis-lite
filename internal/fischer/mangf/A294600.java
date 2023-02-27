package irvine.oeis.a294;
// Generated by gen_seq4.pl convinv/rootet at 2023-02-21 22:24

import irvine.oeis.SkipSequence;
import irvine.oeis.a053.A053255;
import irvine.oeis.transform.RootSequence;

/**
 * A294600 Expansion of 1/(Sum_{i&gt;=0} q^(2*i*(i+1))/Product_{j=0..i} (1 + q^(2*j+1) + q^(4*j+2))).
 * @author Georg Fischer
 */
public class A294600 extends RootSequence {

  /** Construct the sequence. */
  public A294600() {
    super(0, new SkipSequence(new A053255(), 1), -1, 1);
  }
}
