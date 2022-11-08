package irvine.oeis.a320;
// manually deris/binomx at 2022-10-26 11:22

import irvine.oeis.a000.A000593;
import irvine.oeis.transform.BinomialTransform;

/**
 * A320586 Expansion of (1/(1 - x)) * Sum_{k&gt;=1} k*x^k/(x^k + (1 - x)^k).
 * @author Georg Fischer
 */
public class A320586 extends BinomialTransform {

  /** Construct the sequence. */
  public A320586() {
    super(new A000593());
  }
}
