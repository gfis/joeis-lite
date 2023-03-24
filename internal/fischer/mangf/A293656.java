package irvine.oeis.a293;
// Generated by gen_seq4.pl simbinom at 2023-03-16 19:20

import irvine.math.factorial.MemoryFactorial;
import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A293656 a(n) = binomial(n+1,2)*n!/n!!.
 * @author Georg Fischer
 */
public class A293656 extends AbstractSequence {

  private int mN = 0; 
  
  public A293656() {
    super(1);
  }

  @Override
  public Z next() {
    ++mN;
    return Binomial.binomial(mN + 1,2).multiply(MemoryFactorial.SINGLETON.factorial(mN)).divide(MemoryFactorial.SINGLETON.doubleFactorial(mN));
  }
}
