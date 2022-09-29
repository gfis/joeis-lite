package irvine.oeis.a256;
// Generated by gen_seq4.pl dersimple at 2021-08-25 19:44

import irvine.math.z.Z;
import irvine.oeis.a255.A255434;

/**
 * A256020 a(n) = Sum_{i=1..n-1} (i^4 * a(i)), a(1)=1.
 * @author Georg Fischer
 */
public class A256020 extends A255434 {

  private int mN = 0;
  {
    super.next();
  }

  @Override
  public int getOffset() {
    return 1;
  }

  @Override
  public Z next() {
    ++mN;
    return mN <= 1 ? Z.ONE : super.next().divide2();
  }
}
