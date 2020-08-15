package irvine.oeis;

import java.util.ArrayList;
import irvine.math.Mobius;
import irvine.math.z.Z;
import irvine.math.z.ZUtils;
/**
 * Apply the Euler transform to some other sequence.
 * The program follows closely the code of the OEIS implementations
 * for Maple (N.J.A. Sloane) and Mathematica (Olivier Gerard),
 * see https://oeis.org/wiki/Sequence_transforms
 * @author Georg Fischer
 */
public class EulerTransform implements Sequence {

  private final Sequence mSeq;
  private final ArrayList<Z> mAs = new ArrayList<>(); // underlaying sequence
  private final ArrayList<Z> mBs = new ArrayList<>(); // resulting sequence
  private final ArrayList<Z> mCs = new ArrayList<>(); // auxiliary sequence 
  protected final Z[] mInits; // initial terms to be prepended
  protected int mIn; // index for initial terms
  protected int mN;

  /**
   * Create the Euler transform of the given sequence,
   * with additional terms prepended.
   * @param seq underlying sequence
   * @param inits additional terms to be prepended
   */
  public EulerTransform(final Sequence seq, final Z... inits) {
    mSeq = seq;
    mInits = inits;
    mIn = 0;
    mN = 0;
    mAs.add(Z.ZERO); // [0] not used
    mBs.add(Z.ZERO); // [0] is not returned
    mCs.add(Z.ZERO); // [0] starts the sum
  }

  /**
   * Create a new sequence with additional terms at the front.
   * @param seq main sequence
   */
  public EulerTransform(final Sequence seq) {
    this(seq, new Z[0]);
  }

  /**
   * Create a new sequence with additional terms at the front.
   * @param seq main sequence
   * @param inits additional terms to be prepended
   */
  public EulerTransform(final Sequence seq, final long... inits) {
    this(seq, ZUtils.toZ(inits));
  }
  /**
   * Return a term.
   * @return the next term of the transformed sequence.
   */
  @Override
  public Z next() { // during prepend phase
    if (mIn < mInits.length) {
      return mInits[mIn ++];
    }
    // normal, transformed terms
    mN ++; // starts with 1
    Z aNext = mSeq.next();
    mAs.add(aNext == null ? Z.ZERO : aNext); // get next a(n)
    mCs.add(Z.ZERO); // allocate c[n]
    for (int i = mN; i <= mN; ++i) {
      Z cSum = Z.ZERO; // start sum
      for (int d = 1; d <= i; ++d) { // compute c[n] = sum ...
        if (i % d == 0) { // "did(i,d)"
          cSum = cSum.add(Z.valueOf(d).multiply(mAs.get(d)));
        }
      } // for d
      mCs.set(i, cSum); // = c[n]
    } // for i
    int i = mN;
    Z bSum = mCs.get(i); 
    for (int d = 1; d < i; ++d) {
      bSum = bSum.add(mCs.get(d).multiply(mBs.get(i - d)));
    } // for d
    bSum = bSum.divide(Z.valueOf(i));
    mBs.add(bSum);
    return bSum;
  } 

  /**
   * Utility function: "did it divide?".
   * @param m first, nonnegative operand
   * @param n second, positive operand
   */
  public static int did(final int m, final int n) {
    return m % n == 0 ? 1 : 0;
  }
  
  /**
   * Utility function : MobiousMu or 0.
   * @param m first, nonnegative operand
   * @param n second, positive operand
   */
  public static int mob(final int m, final int n) {
    return m % n == 0 ? Mobius.mobius(m / n) : 0;
  }

}
