/* Complementary equations, similiar to holonomic recurrences
 * @(#) $Id$
 * 2020-09-24, Georg Fischer
 */
package irvine.oeis;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.HolonomicRecurrence;
import irvine.oeis.Sequence;

import java.util.TreeSet;

/**
 * A complementary equation system has a recurrence equation for sequence A coupled with
 * one or more sequences B, C and so on that are built with the elements <strong>not yet</strong>
 * existing in any one of the sequences involved.
 * A value of <code>sMex</code> indicates that the sequence element must be determined
 * by the <code>mex</code> operator.
 * <code>Long</code> values are sufficient fo rthe terms since the union of the sequences involved
 * always is the set of the positive integers.
 * @author Georg Fischer
 */
public class ComplementaryEquationSequence extends HolonomicRecurrence {
  static int sDebug = 0; // 0 = no debugging, 1 = some, 2 = more
  static final int sMex = -29061947; // some value lower than all possible sequence terms

  protected final TreeSet<Long> mSet;// the set of added terms
  protected long mFree; // guess for the numerically first, free (not yet added) element in mSet
  protected long[][] mBuffers; // cyclic arrays (rings) for the last k values of the sequences a, b, c and so on.

  /** 
   * Empty Constructor. 
   */
  public ComplementaryEquationSequence() {
    this("[[0],[1]]", new String[] { "[1]" });
  }

  /**
   * Construct a holonomic recurrence sequence for A from String parameters.
   *
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be specified accordingly.
   * @param initTerms initial values of a[0..k], b[0..k], c[0..k] and so on, 
   * as an array of String vectors, k is the order of the recurrence, that is the number of elements
   * a[n-1], a[n-2], a[n-k] used to compute a[n]. If the arrays b, c and so on are shorter than k,
   * they are filled up with {@link #sMex}.
   * t
   * for example "new String[] { [0,1,2,3] }".
   */
  public ComplementaryEquationSequence(final String matrix, final String[] initTerms) {
    super(0, matrix, initTerms[0], 0); // all sequences with offset 0
    // sets super.mOrder
    setGfType(2);
    mSet = new TreeSet<Long>(); 
    mSet.add(0L); // zero is never a term
    mFree = 1; // this will be added next
    super.mN = -1; // incremented by next() to give the offset of the result of next().
    mBuffers = new long[initTerms.length][mOrder]; 
    for (int i = 0; i < initTerms.length; ++i) {
      String [] elems = initTerms[i].replaceAll("[^\\d\\-\\,]", "").split("\\,");
      for (int j = 0; j < mOrder; ++j) {
        if (j < elems.length) {
          try {
            mBuffers[i][j] = Long.parseLong(elems[j]);
          } catch (Exception exc) {
            mBuffers[i][j] = sMex;
          }
        } else {
            mBuffers[i][j] = sMex;
        }
      } // for j
    } // for i
  }

  /**
   * Return the least element not yet added to the set {@link #mSet}.
   * @param collection some array of values
   * @return mex ("minimum excluded") value: the least value not yet in the set of non-negative terms
   */
  protected long mex() {
    while (mSet.contains(mFree)) {
      ++mFree;
    }
    mSet.add(mFree);
    long result = mFree;
    ++mFree;
    return result;
  }

  /**
   * Return the element of the complementary sequence b(n).
   * @param n index of the sequence
   * @return an element of <code>mBuffer[1]</code>
   */
  protected long getB(final int n) {
    return mBuffers[1][(n + mOrder) % mOrder];
  }

  /**
   * Return the element of the complementary sequence c(n).
   * @param n index of the sequence
   * @return an element of <code>mBuffer[2]</code>
   */
  protected long getC(final int n) {
    return mBuffers[2][(n + mOrder) % mOrder];
  }

  /**
   * For <code>gftype=2</code>, add some arbitrary value to the constant term in the recurrence equation.
   * @param n index of the term a(n) to be computed
   * @return value to be added to the constant term.
   */
  @Override
  public Z addFunction(final int n) {
    mBuffers[1][n % mOrder] = mex(); // add b(n)
    return Z.valueOf(n < mOrder ? 0L : getB(n - 2));
  }

  @Override
  public Z next() {
    Z result = super.next();
    mSet.add(result.longValue());
    return result;
  }
  
  /**
   * Test method
   * @param args command line arguments: 
   * <code>[-d debug] [-i initerms] [-m maxterms] [-p matrix]</code>
   */
  public static void main(String[] args) {
    int maxTerms     = 16;
    String matrix = "[[0],[1],[1],[-1]]"; // Fibonacci 
    String[] initTerms = new String[] { "[1,2]" };
    ComplementaryEquationSequence complet = null;
    if (args.length == 0) {
      complet = new ComplementaryEquationSequence(matrix, initTerms);
      System.out.println("1, 3, 11, 53, 345, 2947, 31411, 400437, 5927921, 99816515, 1882741659, 39310397557"); // A081367
    } else {
      sDebug = 0;
      int iarg = 0;
      while (iarg < args.length) {
        String opt = args[iarg++];
        try {
          if (false) {
          } else if (opt.equals("-d")) {
            sDebug  = Integer.parseInt(args[iarg++]);
          } else if (opt.equals("-i")) {
            initTerms = new String[] { args[iarg++], "" };
          } else if (opt.equals("-m")) {
            maxTerms  = Integer.parseInt(args[iarg++]);
          } else if (opt.equals("-p")) {
            matrix    = args[iarg++];
          }
        } catch (Exception exc) {
        }
      } // while
      complet = new ComplementaryEquationSequence(matrix, initTerms);
    }
    int n = 0;
    while (n < maxTerms) {
      System.out.print(complet.next().toString() + ",");
      n ++;
    } // while n
    System.out.println();
  } // main

}
