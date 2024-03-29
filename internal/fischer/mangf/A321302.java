package irvine.oeis.a321;
// Generated by gen_seq4.pl convprom/convprod at 2023-06-09 21:25

import irvine.oeis.a321.A321240;
import irvine.oeis.transform.ConvolutionProduct;

/**
 * A321302 Expansion of Product_{i&gt;=1, j&gt;=1, k&gt;=1, l&gt;=1} (1 - x^(i*j*k*l))/(1 + x^(i*j*k*l)).
 * @author Georg Fischer
 */
public class A321302 extends ConvolutionProduct {

  /** Construct the sequence. */
  public A321302() {
    super(0, "-1", new A321240());
  }
}
