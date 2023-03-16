package irvine.oeis.a075;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Fibonacci;
import irvine.math.z.Z;
import irvine.oeis.a030.A030059;

/**
 * A075736 Fibonacci numbers F(k) as k runs through the products of an odd number of distinct primes A030059 (mu(k)=-1).
 * @author Georg Fischer
 */
public class A075736 extends A030059 {
  @Override
  public Z next() {
    return Fibonacci.fibonacci(super.next().intValue());
  }
}
