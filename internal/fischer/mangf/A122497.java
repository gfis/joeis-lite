package irvine.oeis.a122;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a059.A059448;

/**
 * A122497 Let f(S) denote the interchange of 1&apos;s and 2&apos;s in S. Let S_0 = 1, S_{N+1} = f(S_N).S_N, where the dot indicates concatenation. Sequence gives S_0.S_1.S_2.S_3....
 * @author Georg Fischer
 */
public class A122497 extends A059448 {

  @Override
  public Z next() {
    return super.next().add(1);
  }
}
