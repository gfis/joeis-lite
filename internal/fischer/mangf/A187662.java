package irvine.oeis.a187;
// Generated by gen_seq4.pl convprom/convprod at 2023-02-25 22:00

import irvine.oeis.a007.A007820;
import irvine.oeis.a187.A187535;
import irvine.oeis.transform.ConvolutionProduct;

/**
 * A187662 Convolution of the (signless) central Lah numbers (A187535) and the central Stirling numbers of the second kind (A007820).
 * @author Georg Fischer
 */
public class A187662 extends ConvolutionProduct {

  /** Construct the sequence. */
  public A187662() {
    super(0, "1,1", new A187535(),new A007820());
  }
}
