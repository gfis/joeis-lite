/* Complementary equations, similiar to holonomic recurrences
 * @(#) $Id$
 * 2020-09-24, Georg Fischer
 */
package irvine.oeis;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.HolonomicRecurrence;
import irvine.oeis.Sequence;

import java.util.ArrayList;
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
  public static final long sMex = -29061947; // some value lower than all possible sequence terms

  protected final TreeSet<Long> mUnion;// the set of added terms
  protected long mFree; // guess for the numerically first, free (not yet added) element in mUnion
  protected ArrayList<ArrayList<Long>> mSeqs; // arrays for the sequences a, b, c and so on.

  /** 
   * Empty Constructor. 
   */
  public ComplementaryEquationSequence() {
    this("[[0],[1]]", new String[] { "[1]" });
  }

  /**
   * Construct a holonomic recurrence sequence for A from String parameters.
   *
   * @param matrix polynomials as coefficients of <code>n^i, i=0..m</code>,
   *               as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *               in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *               The brackets must be specified accordingly.
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
    mUnion = new TreeSet<Long>(); 
    mUnion.add(0L); // zero is never a term
    mFree = 1; // this will be added next
    super.mN = -1; // incremented by next() to give the offset of the result of next().
    mSeqs = new ArrayList<ArrayList<Long>>(5); 
    long elem = 0L;
    for (int i = 0; i < initTerms.length; ++i) {
      mSeqs.add(new ArrayList<Long>(256));
      String [] elems = initTerms[i].replaceAll("[^\\d\\-\\,]", "").split("\\,");
      for (int j = 0; j < mOrder; ++j) {
        if (j < elems.length) {
          try {
            elem = Long.parseLong(elems[j]);
            mUnion.add(elem);
          } catch (Exception exc) {
            elem = sMex;
          }
          mSeqs.get(i).add(elem);
        } else {
          // elem = sMex;
          // do not add it to mUnion
        }
      } // for j
    } // for i
  }

  /**
   * Return the least element not yet added to the set {@link #mUnion}.
   * @param collection some array of values
   * @return mex ("minimum excluded") value: the least value not yet in the set of non-negative terms
   */
  protected long mex() {
    while (mUnion.contains(mFree)) {
      ++mFree;
    }
    mUnion.add(mFree);
    long result = mFree;
    ++mFree;
    return result;
  }

  /**
   * Return a term of one of the complementary sequences.
   * If the element is not yet defined, 
   * it becomes the least element not yet contained in {@link #mUnion} (mex function).
   * @param seqNo number of the sequence: 0 = a, 1 = b, 2 = c and so on-
   * @param index index of the term in the sequence
   * @return <code>mSeqs.get(seqNo).get(index)</code>
   */
  protected long getTerm(final int seqNo, final int index) {
    ArrayList<Long> list = mSeqs.get(seqNo);
    long result = 0L;
    if (index >= list.size()) {
      result = mex();
      list.add(result);
    } else {
      result = list.get(index);
      if (result == sMex) {
        result = mex();
        list.set(index, result);
      }
    }
    if (sDebug >= 0) {
      System.out.println(" # getTerm " + (new char[] { 'a', 'b', 'c', 'd', 'e', 'f' })[seqNo] 
          + "(" + index + ")=" + result + " # ");
    }
    return result;
  }

  /**
   * Convenience access to sequence <code>a</code>
   * @param index index of the term in the sequence
   * @return the indexed element, possibly determined by the <code>mex()</code> function
   */
  protected long a(final int index) {
    return getTerm(0, index);
  }

  /**
   * Convenience access to sequence <code>b</code>
   * @param index index of the term in the sequence
   * @return the indexed element, possibly determined by the <code>mex()</code> function
   */
  protected long b(final int index) {
    return getTerm(1, index);
  }

  /**
   * Convenience access to sequence <code>c</code>
   * @param index index of the term in the sequence
   * @return the indexed element, possibly determined by the <code>mex()</code> function
   */
  protected long c(final int index) {
    return getTerm(2, index);
  }

  /**
   * Convenience access to sequence <code>d</code>
   * @param index index of the term in the sequence
   * @return the indexed element, possibly determined by the <code>mex()</code> function
   */
  protected long d(final int index) {
    return getTerm(3, index);
  }

  /**
   * Convenience access to sequence <code>e</code>
   * @param index index of the term in the sequence
   * @return the indexed element, possibly determined by the <code>mex()</code> function
   */
  protected long e(final int index) {
    return getTerm(4, index);
  }

  /**
   * For <code>gftype=2</code>, add some arbitrary value to the constant term in the recurrence equation.
   * @param n index of the term a(n) in the holonomic recurrence currently to be computed
   * @return value to be added to the constant term.
   */
  @Override
  public Z adjunct(final int n) {
    return Z.valueOf(b(n - 2));
  }

  @Override
  public Z next() {
    Z result = super.next();
    final long an = result.longValue();
    mUnion.add(an);
    mSeqs.get(0).add(an); // sequence <code>a</code> never uses mex()
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
