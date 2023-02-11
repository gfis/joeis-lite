package irvine.oeis.a038;
// generated by patch_offset.pl at 2023-02-08 12:41

import irvine.oeis.transform.InverseEulerTransform;
import irvine.oeis.a152.A152623;

/**
 * A038066 Product_{k&gt;=1} 1/(1 - x^k)^a(k) = 1 + 5x.
 * @author Georg Fischer
 */
public class A038066 extends InverseEulerTransform {

  /** Construct the sequence. */
  public A038066() {
    super(1, new A152623(), 1);
    next();
  }
}
