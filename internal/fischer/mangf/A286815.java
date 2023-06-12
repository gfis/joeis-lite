package irvine.oeis.a286;
// Generated by gen_seq4.pl transpose at 2023-06-02 09:39

import irvine.math.z.Z;
import irvine.oeis.a319.A319574;
import irvine.oeis.triangle.Transpose;

/**
 * A286815 Square array A(n,k), n&gt;=0, k&gt;=0, read by antidiagonals, where column k is the expansion of (Product_{j&gt;=1} (1 - x^(2*j))^5/((1 - x^j)*(1 - x^(4*j)))^2)^k.
 * @author Georg Fischer
 */
public class A286815 extends Transpose {

  /** Construct the sequence. */
  public A286815() {
    super(new A319574());
  }
}
