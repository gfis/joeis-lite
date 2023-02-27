package irvine.oeis.a292;
// Generated by gen_seq4.pl convinv/rootet at 2023-02-21 22:24

import irvine.oeis.SkipSequence;
import irvine.oeis.a001.A001861;
import irvine.oeis.transform.RootSequence;

/**
 * A292831 Expansion of 1 - 2*x - 2*x^2/(1 - 3*x - 4*x^2/(1 - 4*x - 6*x^2/(1 - 5*x - 8*x^2/(1 - 6*x - 10*x^2/(...))))), a continued fraction.
 * @author Georg Fischer
 */
public class A292831 extends RootSequence {

  /** Construct the sequence. */
  public A292831() {
    super(0, new SkipSequence(new A001861(), 1), -1, 1);
  }
}