package irvine.oeis.a109;
// Generated by gen_seq4.pl rootet at 2023-02-19 11:44

import irvine.math.z.Z;
import irvine.oeis.SkipSequence;
import irvine.oeis.a004.A004672;
import irvine.oeis.transform.RootSequence;

/**
 * A109148 G.f.: 48th root of theta series of lattice in A004672.
 * G.f.: 48th root of theta series of lattice in A004672.
 * @author Georg Fischer
 */
public class A109148 extends RootSequence {

  /** Construct the sequence. */
  public A109148() {
    super(0, new SkipSequence(new A004672(), 1), 1, 48);
  }
}
