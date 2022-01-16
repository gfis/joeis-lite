package irvine.oeis.a226;
// manually ca.1m/ca1triangle at 2021-12-29 16:06

import irvine.math.z.Z;
import irvine.oeis.ca.Cellular1DAutomaton;

/**
 * A226464 Triangle read by rows giving successive states of cellular automaton generated by &quot;Rule 149&quot;.
 * @author Georg Fischer
 */
public class A226464 extends Cellular1DAutomaton {

  /** Construct the sequence. */
  public A226464() {
    super(86);
  }

  @Override
  public Z next() {
    return Z.ONE.subtract(super.next());
  }
}