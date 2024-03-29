package irvine.oeis.a258;

import java.util.function.Function;

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A258774 a(n) = 1 + sigma(n) + sigma(n)^2.
 * @author Georg Fischer
 */
public class A258774 implements Sequence {

  private int mN;
  private Function<Z, Z> mLambda;
  
  /** Construct the sequence. */
  public A258774() {
    this(s -> Z.ONE.add(Z.ONE.add(s).multiply(s)));
  }

  /** 
   * Generic constructor with parameter.
   * @param lambda lambda expression in sigma
   */
  public A258774(final Function<Z, Z> lambda) {
    mN = 0;
    mLambda = lambda;
  }

  @Override
  public Z next() {
    final Z s = Jaguar.factor(++mN).sigma();
    return mLambda.apply(s);
    
  }
}
