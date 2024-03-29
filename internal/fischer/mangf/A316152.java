package irvine.oeis.a316;
// Generated by gen_seq4.pl ietman at 2023-02-13 09:44

import irvine.oeis.a000.A000290;
import irvine.oeis.transform.InverseEulerTransform;

/**
 * A316152 Inverse Euler transform of n^2.
 * @author Georg Fischer
 */
public class A316152 extends InverseEulerTransform {

  /** Construct the sequence. */
  public A316152() {
    super(1, new A000290(), 1);
    next();
  }
}
