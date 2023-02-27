package irvine.oeis.a130;
// Generated by gen_seq4.pl convprom/convprod at 2023-02-25 22:00

import irvine.oeis.a000.A000108;
import irvine.oeis.a001.A001764;
import irvine.oeis.transform.ConvolutionProduct;

/**
 * A130579 Convolution of A000108 (Catalan numbers) and A001764 (ternary trees): a(n) = Sum_{k=0..n} C(2k,k) * C(3(n-k),n-k) / [(k+1)(2(n-k)+1)].
 * @author Georg Fischer
 */
public class A130579 extends ConvolutionProduct {

  /** Construct the sequence. */
  public A130579() {
    super(0, "1,1", new A000108(),new A001764());
  }
}