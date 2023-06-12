package irvine.oeis.a319;
// Generated by gen_seq4.pl convprom/convprod at 2023-06-09 21:25

import irvine.oeis.a280.A280263;
import irvine.oeis.transform.ConvolutionProduct;

/**
 * A319244 Expansion of Product_{k&gt;0} (1 - x^(k^3))/(1 + x^(k^3)).
 * @author Georg Fischer
 */
public class A319244 extends ConvolutionProduct {

  /** Construct the sequence. */
  public A319244() {
    super(0, "-1", new A280263());
  }
}
