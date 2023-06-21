package irvine.oeis.a340;
// Generated by gen_seq4.pl robot/dirichinv at 2023-06-14 17:15

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.DirichletInverseSequence;
import irvine.oeis.a247.A247074;

/**
 * A340145 Dirichlet inverse of A247074(x) = phi(x)/(Product_{primes p dividing x} gcd(p-1, x-1)).
 * @author Georg Fischer
 */
public class A340145 extends AbstractSequence {

  private final DirichletInverseSequence mSeq = new DirichletInverseSequence(new A247074());

  /** Construct the sequence. */
  public A340145() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq.next();
  }
}