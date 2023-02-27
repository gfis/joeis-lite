package irvine.oeis.a334;
// Generated by gen_seq4.pl ietman at 2023-02-13 09:44

import irvine.oeis.a000.A000568;
import irvine.oeis.transform.InverseEulerTransform;

/**
 * A334335 Inverse Euler transform of A000568.
 * @author Georg Fischer
 */
public class A334335 extends InverseEulerTransform {

  /** Construct the sequence. */
  public A334335() {
    super(1, new A000568(), 1);
    next();
  }
}