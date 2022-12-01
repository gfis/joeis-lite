package irvine.oeis.a262;
import irvine.math.factorial.MemoryFactorial;
import irvine.math.z.Fibonacci;
import irvine.math.z.Z;
import irvine.oeis.Sequence0;

/**
 * A262776 a(n) = Fibonacci(n!) mod Fibonacci(n)!.
 * @author Georg Fischer
 */
public class A262776 extends Sequence0 {

  private int mN = -1;
  private int mF = 1;

  @Override
  public Z next() {
    ++mN;
    final Z result = MemoryFactorial.SINGLETON.factorial(Fibonacci.fibonacci(mF).intValue())
        .mod(MemoryFactorial.SINGLETON.factorial(Fibonacci.fibonacci(mN).intValue()));
    mF = mF * (mN + 1);
    return result;
  }
}
