package irvine.oeis;

import irvine.math.z.Z;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;

/**
 * Earliest sequence with a(a(n))=f(n), where f(n) is some underlying sequence.
 * @author Georg Fischer
 */
public class InverseAronsonTransform extends MemorySequence {

  private static final int DEBUG = 1;
  protected MemorySequence mSeq; // underlying sequence
  protected int mN; // current index
  protected int mOffset; // starting index
  protected int mAttrs; // bit mask for attributes
  protected static final int EARLY = 1; // Earliest sequence ...
  protected static final int INCR = 2; // ...  being monotonically increasing
  
  /**
   * Constructor with parameters.
   * @param offset first index 
   * @param seq underlying sequence
   * @param attrs bit mask for attributes
   */
  public InverseAronsonTransform(final int offset, final Sequence seq, final int attrs, final long ... initTerms) {
    mSeq = MemorySequence.cachedSequence(seq);
    mOffset = offset;
    mAttrs = attrs;
    mN = offset - 1;
  }

  @Override
  protected Z computeNext() {
    final int n = size();
    ++mN;
    final Z aaMust = mSeq.a(mN); // a(a(n)) must have this value
    if (DEBUG >= 1) { System.out.println("----\n  determine a(" + mN + ") such that a(a(" + mN + "))=" + aaMust); }
    if (mN == mOffset) {
      return mSeq.a(mN);
    }
    Z result = null; 
    // first look whether there is any previous a(k) = mN
    for (int k = mOffset; k < mN; ++k) {
      if (DEBUG >= 2) { System.out.println("  test k:" + k); }
      if (get(k).equals(Z.valueOf(mN))) {
        if (DEBUG >= 1) { System.out.println("    previous=mN:" + mN); }
        return mSeq.a(k);
      }
    }
    // now determine the earliest candidate
    // now compute the term to be returned in the next call
    boolean busy = true;
    int cand = mOffset; // is this a candidate for a(n)?
    while (busy) { // && cand <= n) {
        
      if (cand > mN) {
        if (DEBUG >= 1) { System.out.println("  cand:" + cand + " > mN:" + mN); }
        result = Z.valueOf(cand);
        busy = false;
        
      } else if (cand == mN) {
        if (DEBUG >= 1) { System.out.println("  cand:" + cand + " = mN:" + mN); }
        final int aCand = cand;
        final Z aaCand = aCand < n ? get(aCand) : Z.valueOf(cand);
        if (DEBUG >= 1) { System.out.println("    aCand: " + aCand + ", aaCand1:" + aaCand + " <=> aaMust:" + aaMust + " ?"); }
        if (aaCand.equals(aaMust)) {
          if (DEBUG >= 1) { System.out.println("      equals1, add cand:" + cand); }
          result = Z.valueOf(cand);
          busy = false;
        } else {
          // continue 
          if (DEBUG >= 1) { System.out.println("      continue"); }
        }
        
      } else { // cand < mN
        if (DEBUG >= 1) { System.out.println("  cand:" + cand + " < mN:" + mN); }
        final Z aaCand = get(cand);
        if (DEBUG >= 1) { System.out.println("    aaCand1:" + aaCand + " <=> aaMust:" + aaMust + " ?"); }
        if (aaCand.equals(aaMust)) {
          result = Z.valueOf(cand);
          busy = false;
        } else {
          // continue 
        } 
      } // cand < mN
      if (! busy) { // verify that we did not have this result previously  
        boolean prev = false;
        int k = mOffset;
        while (! prev && k < mN) {
          if (DEBUG >= 2) { System.out.println("  verify k:" + k); }
          if (get(k).equals(result)) {
            if (DEBUG >= 1) { System.out.println("    previously"); }
            prev = true;
          }
          ++k;
        } // while verifying
        busy = prev;
      } // verify
      ++cand;
    } // while
    if (DEBUG >= 1) { System.out.println("result=" + result); }
    return result;
  }
}
