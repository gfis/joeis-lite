package irvine.oeis;

import java.util.HashMap;

import irvine.math.z.Z;
import irvine.math.MemoryFunction1;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;

/**
 * Earliest sequence with a(a(n))=f(n), where f(n) is some underlying sequence.
 * @author Georg Fischer
 */
public class NumericalAronsonSequence implements Sequence {

  private static int sDebug = 1;
  protected MemorySequence mSeq; // underlying sequence
  protected int mN; // current index
  protected int mOffset; // starting index
  protected int mAttribs; // bit mask for features; low nibble may be start value
  protected static final int EARLY = 0x10; // "Earliest sequence ..."
  protected static final int INCR = 0x20; // "...  being monotonically increasing"
  protected static final int START = 0x30; // low nibble contains start value
  protected HashMap<Integer, Z> mHmap; // n -> a(n)
  private static final int MAX_BITS = 12;
  /**
   * Constructor with parameters.
   * @param offset first index
   * @param seq underlying sequence
   * @param attribs bit mask for attributes
   */
  public NumericalAronsonSequence(final int offset, final Sequence seq, final int attribs) {
    mSeq = MemorySequence.cachedSequence(seq);
    mHmap = new HashMap<Integer, Z>(1024);
    mOffset = offset;
    mAttribs = attribs;
    mN = -1;
    while (mN < mOffset - 1) {
      mHmap.put(mN++, Z.ZERO);
    }
  }

  /**
   * Compute the next term in a chain.
   * @param n index
   * @param an a(n)
   * @return b(n) <= 4096, or -1 if b(n) is bigger
   * For example <code>chain(4, 6): a(4):=6; a(6)=a(a(4))=b(4)=5 -&gt; chain(5, 6)</code>
   */
  private void chain(final int n, final int an) {
    if (sDebug >= 1) { System.out.println("  start chain(" + n + "," + an + ")"); }
    if (mHmap.get(n) == null) {
      if (sDebug >= 1) { System.out.println("    a(" + n + ") := " + an); }
      mHmap.put(n, Z.valueOf(an));
      Z result = mSeq.a(n); // b(n)
      // mHmap.put(an, result);
      if (result.bitLength() <= MAX_BITS) { // continue the chain
        int bn = result.intValue();
        chain(an, bn);
      } else {
        result = Z.NEG_ONE; // end of  chain
      }
    } else {
      if (sDebug >= 1) { System.out.println("    a(" + n + ") already computed"); }
    }
    if (sDebug >= 1) { System.out.println("  end   chain(" + n + "," + an + ")"); }
    // return result;
  } 

  @Override
  public Z next() {
    ++mN;
    final int n = mN;
    Z result = mHmap.get(n);
    if (sDebug >= 1) { System.out.println("determine a(" + n + "): " + (result == null ? "null" : result.toString())); }
    if (result == null) { // a(n) does not yet exist
      // now determine the earliest candidate
      boolean busy = true;
      int cand = mOffset; // is this a candidate for a(n)?
/*
      if (n > mOffset && (mAttrs & INCR) == INCR) {
        cand = mHmap.get(n - 1).intValue() + 1;
      }
*/
      while (busy && cand < n) {
        final Z term = mHmap.get(cand);
        if (term != null) {
          if (sDebug >= 1) { System.out.println("  try cand:" + cand + " -> a(cand):" + term); }
          if (term.equals(mSeq.a(n))) {
            if (sDebug >= 1) { System.out.println("    = b(n), accept " + term); }
            result = term;
            busy = false;
          } else {
            if (sDebug >= 1) { System.out.println("    != b(n)"); }
          }
        } else {
          if (sDebug >= 1) { System.out.println("  try cand:" + cand + " -> a(cand) = null"); }
        } 
        ++cand;
      } // while < n
      
      if (busy) { // cand == n here
        final Z term = mSeq.a(cand); // b(cand)
        if (Z.valueOf(cand).equals(term)) {
          if (sDebug >= 1) { System.out.println("  cand = n, accept b(n):" + term); }
          result = term;
          busy = false;
        } else {
          ++cand;
        }
      }
      
      if (busy) { // cand == n + 1 here : must accept it
        result = Z.valueOf(cand);
        final Z term = mSeq.a(cand); // b(cand)
        if (Z.valueOf(cand).equals(term)) {
          result = term;
          if (sDebug >= 1) { System.out.println("  cand = n+1, accept b(n):" + result); }
        } else {
          result = Z.valueOf(++cand);
          if (sDebug >= 1) { System.out.println("  cand = n+2, accept cand:" + result); }
        }
        busy = false;
      }
    } // a(n) did not yet exist

    if (result.bitLength() <= MAX_BITS) { // start a chain
      chain(n, result.intValue());
    } 
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
      System.out.println("java -cp joeis.jar irvine.oeis.NumericalAronsonSequence "
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
    NumericalAronsonSequence aseq = new NumericalAronsonSequence(offset, bseq, attrs);
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
