package irvine.oeis.a144;
// Generated by gen_seq4.pl transpose at 2022-10-25 23:07

import irvine.math.z.Z;
import irvine.oeis.a202.A202191;
import irvine.oeis.triangle.Transpose;

/**
 * A144401 Padovan ( A000931) version of A038137: expansion of polynomials as antidiagonal: p(x,n)=1/(1-x-x^3)^n.
 * @author Georg Fischer
 */
public class A144401 extends Transpose {

  public A144401() {
    super(new A202191());
  }
}
