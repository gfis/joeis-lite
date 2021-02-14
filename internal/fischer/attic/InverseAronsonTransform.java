package irvine.oeis;

import irvine.math.z.Z;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;

/**
 * Earliest sequence with a(a(n))=f(n), where f(n) is some underlying sequence.
 * @author Georg Fischer
 */
public class InverseAronsonTransform extends MemorySequence {

  private static int sDebug = 0;
  protected MemorySequence mSeq; // underlying sequence
  protected int mN; // current index
  protected int mOffset; // starting index
  protected int mAttrs; // bit mask for attributes
  protected long[] mInitTerms; // fixed leading terms 
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
    mInitTerms = initTerms;
    mN = offset - 1;
    for (int k = 0; k < offset; ++k) {
      add(Z.ZERO);
    }
  }

  @Override
  protected Z computeNext() {
    final int n = size();
    ++mN;
    if (mN - mOffset < mInitTerms.length) {
      return Z.valueOf(mInitTerms[mN - mOffset]);
    }
    final Z aaMust = mSeq.a(mN); // a(a(n)) must have this value
    if (sDebug >= 1) { System.out.println("----\n  determine a(" + mN + ") such that a(a(" + mN + "))=" + aaMust); }
/*
    if (mN == mOffset) {
      return mSeq.a(mN);
    }
*/
    Z result = null;
    // first look whether there is any previous a(k) = mN
    for (int k = mOffset; k < mN; ++k) {
      if (sDebug >= 2) { System.out.println("  test k:" + k); }
      if (get(k).equals(Z.valueOf(mN))) {
        if (sDebug >= 1) { System.out.println("    previous=mN:" + mN); }
        return mSeq.a(k);
      }
    }
    // now determine the earliest candidate
    boolean busy = true;
    int cand = mOffset; // is this a candidate for a(n)?
    if (mN > mOffset && (mAttrs & INCR) == INCR) {
      cand = get(mN - 1).intValue() + 1;
    }
    while (busy) { // && cand <= n) {

      if (cand > mN) {
        if (sDebug >= 1) { System.out.println("  cand:" + cand + " > mN:" + mN); }
        result = Z.valueOf(cand);
        busy = false;

      } else if (cand == mN) {
        if (sDebug >= 1) { System.out.println("  cand:" + cand + " = mN:" + mN); }
        final int aCand = cand;
        final Z aaCand = aCand < n ? get(aCand) : Z.valueOf(cand);
        if (sDebug >= 1) { System.out.println("    aCand: " + aCand + ", aaCand1:" + aaCand + " <=> aaMust:" + aaMust + " ?"); }
        if (aaCand.equals(aaMust)) {
          if (sDebug >= 1) { System.out.println("      equals1, add cand:" + cand); }
          result = Z.valueOf(cand);
          busy = false;
        } else {
          // continue
          if (sDebug >= 1) { System.out.println("      continue"); }
        }

      } else { // cand < mN
        if (sDebug >= 1) { System.out.println("  cand:" + cand + " < mN:" + mN); }
        final Z aaCand = get(cand);
        if (sDebug >= 1) { System.out.println("    aaCand1:" + aaCand + " <=> aaMust:" + aaMust + " ?"); }
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
          if (sDebug >= 3) { System.out.println("  verify k:" + k); }
          if (get(k).equals(result)) {
            if (sDebug >= 1) { System.out.println("    previously"); }
            prev = true;
          }
          ++k;
        } // while verifying
        busy = prev;
      } // verify
/*
      if (! busy) { // test next a(a(n+1))
        if (sDebug >= 1) { System.out.println("  test a(a(" + cand + "))"); }
        if (cand == mN + 1 && cand != mSeq.a(cand).intValue()) {
          if (sDebug >= 1) { System.out.println("    a(a(" + cand + ")) !=, continue"); }
          busy = true;
        }
      } // test a(a(n+1))
*/
      ++cand;
    } // while

    if (sDebug >= 1) { System.out.println("result=" + result); }
    return result;
  }

  /**
   * Test method
   * @param args command line arguments:
   * <code>[-d debug] [-i initerms] [-m maxterms] [-p matrix]</code>
   */
  public static void main(final String[] args) {
    int attrs = EARLY;
    boolean bfile = false;
    int maxTerms = 16;
    int offset = 0;
    Sequence bseq = null;
    if (args.length == 0) { // no arguments
      System.out.println("java -cp joeis.jar irvine.oeis.InverseAronsonTransform "
          + "[-a attrs] [-b] [-d debug] [-n maxterms]  [-o offset] [-s aseqno]\n");
    } else {
      sDebug = 0;
      int iarg = 0;
      while (iarg < args.length) { // evaluate options
        try {
          switch (args[iarg++]) {
            case "-a":
              attrs = Integer.parseInt(args[iarg++]);
              break;
            case "-b":
              bfile = true;
              break;
            case "-d":
              sDebug = Integer.parseInt(args[iarg++]);
              break;
            case "-n":
              maxTerms = Integer.parseInt(args[iarg++]);
              break;
            case "-o":
              offset = Integer.parseInt(args[iarg++]);
              break;
            case "-s":
              String aseqno = args[iarg++];
              final String className = "irvine.oeis.a" + aseqno.substring(1, 4) + '.' + aseqno;
              bseq = (Sequence) Class.forName(className).getDeclaredConstructor().newInstance();
              break;
            default:
              break;
          }
        } catch (final Exception exc) {
          System.err.println(exc.getMessage());
          exc.printStackTrace();
        }
      } // while options
    }
    InverseAronsonTransform aseq = new InverseAronsonTransform(offset, bseq, attrs, 0);
    String sep = "\t";
    if (! bfile) {
      System.out.print("A000000\t" + offset);
    }
    int n = 0;
    while (n < maxTerms) {
      if (bfile) {
        System.out.println(n + " " + aseq.next().toString());
      } else {
        System.out.print(sep + aseq.next().toString());
      }
      sep = ",";
      ++n;
    } // while n
    if (! bfile) {
      System.out.println();
    }
  } // main

}
