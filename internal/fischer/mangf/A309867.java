package irvine.oeis.a309;
// Generated by gen_seq4.pl convprom/convprod at 2023-06-09 21:25

import irvine.oeis.a322.A322204;
import irvine.oeis.transform.ConvolutionProduct;

/**
 * A309867 Expansion of Product_{k&gt;0} (1+sqrt(1-4*x^k))/2.
 * @author Georg Fischer
 */
public class A309867 extends ConvolutionProduct {

  /** Construct the sequence. */
  public A309867() {
    super(0, "-1", new A322204());
  }
}
