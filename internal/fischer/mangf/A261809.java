package irvine.oeis.a261;
// manually primen/primenp at 2022-04-04 14:04

import irvine.math.factorial.MemoryFactorial;
import irvine.math.z.Z;
import irvine.oeis.a060.A060822;

/**
 * A261809 a(n) = n! - prime(n).
 * @author Georg Fischer
 */
public class A261809 extends A060822 {
  
  /** Construct the sequence. */
  public A261809() {
    super(1, (n,p) -> MemoryFactorial.SINGLETON.factorial(n).subtract(p));
  }
}
