package irvine.oeis.a064;
// Generated by gen_seq4.pl convprom/convprod at 2023-02-25 22:00

import irvine.oeis.a000.A000025;
import irvine.oeis.a000.A000041;
import irvine.oeis.transform.ConvolutionProduct;

/**
 * A064053 Auxiliary sequence gamma(n) used to compute coefficients in series expansion of the mock theta function f(q) via A(n) = Sum_{r=0..n} p(r)*gamma(n-r), with p(r) the partition function A000041.
 * @author Georg Fischer
 */
public class A064053 extends ConvolutionProduct {

  /** Construct the sequence. */
  public A064053() {
    super(0, "-1,1", new A000041(),new A000025());
  }
}
