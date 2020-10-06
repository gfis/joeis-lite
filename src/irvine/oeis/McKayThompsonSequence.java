package irvine.oeis;

import irvine.math.z.Z;
import irvine.oeis.McKayThompsonTables;
import irvine.math.PowerSeries;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

/**
 * McKay-Thompson series for the monster group.
 * Derived from <code>moonshine.py</code> of
 * David A. Madore <david.madore@ens.fr> - 2007-07-31 - Public Domain
 * Cf. https://web.archive.org/web/20130925003421/http://mathforum.org/kb/thread.jspa?forumID=253&threadID=1602206&messageID=5836094
 * @author Georg Fischer
 * <br>
 * The Python program computes the coefficients of the Moonshine
 * functions (McKay-Thompson series) by using the action of the
 * generalized Hecke operators (or "replicability").
 * <br>
 * The coefficients of the Moonshine functions are the values of the
 * characters of certain "head modules" ("Hauptmoduln") on the various
 * conjugacy classes (of cyclic subgroups) of the Monster group.  For
 * the identity class ("1A"), we get the ordinary j function.
 * <br>
 * To explain the principle of computation, first describe the
 * situation for the ordinary j function: if
 * <pre>
 *   j(q) = 1/q + c1 q + c2 q^2 + c3 q^3 + ...
 * </pre>
 * (we use the normalization 0 for the constant term), there exists a
 * unique, easily computed, monic polynomial of degree n (the n-th
 * Faber polynomial for j), F_n, such that F_n(j) starts like 1/q^n +
 * terms of order at least 1 in q.  Now modular theory tells us that
 * F_n(j) actually gives (n times) the n-th Hecke operator T_n acting
 * on j, i.e., something like
 * <pre>
 *   2 T_2(j) = 1/q^2 + 2 c2 q + (2c4+c1) q^2 + 2 c6 q^3 + (2c8+c2) q^4 + ...
 *   3 T_3(j) = 1/q^3 + 3 c3 q + 3 c6 q^2 + (3c9+c1) q^3 + 3c12 q^4 + ...
 *   4 T_4(j) = 1/q^4 + 4 c4 q + (4c8+2c2) q^2 + 4c12 q^3 + (4c16+2c4+c1) q^4 + ...
 * </pre>
 * etc.  This relation F_n(j) = n T_n(j) can be used both ways:
 * computing F_n(j) allows us to compute higher (divisible)
 * coefficients from lower ones, but in the other direction, computing
 * F_2(j) with the highest unknown coefficient as an indeterminate
 * allows us to compute the latter from others.
 * <br>
 * In the case of replicable functions, the same thing is almost true,
 * except that the Hecke operators are "twisted": the coefficients come
 * from the "replicas" of the function, e.g.,
 * <pre>
 *   2 T*_2(f) = 1/q^2 + 2 c2 q + (2c4+c'1) q^2 + 2 c6 q^3 + (2c8+c'2) q^4 + ...
 * </pre>
 * where c' are the coefficients of the second replica of f; for
 * Moonshine functions, the replicas are the Moonshine functions of the
 * corresponding powers of the conjugacy class.
 * <br>
 */
public class McKayThompsonSequence implements Sequence {

  /** debugging mode: 0 = none, 1 = some (=earlyprint), 2 = more */
  public static int sDebug = 0;

  /** List of class codes necessary for the computation of the first code in the list */
  protected String[] mSelectedClasses;
  
  /** List of intial terms (a(-1) and a(0)) */
  protected long[] mPrefix;
  
  /** Index of the next term of the sequence to be returned by <code>next()</code> */
  protected int mN;

  /** Empty constructor */
  public McKayThompsonSequence() {
    this(new String[] { "1A" }, new long[] { -1, 0 });
  }

  /**
   * Constructor with array of class codes.
   * @param selectedClasses class codes from the ATLAS,
   * for example "1A", "119B", or combined like "39CD"
   * @param prefix values for a(-1) and a(0)
   */
  public McKayThompsonSequence(final String[] selectedClasses, final long[] prefix) {
    mSelectedClasses = selectedClasses;
    mPrefix = prefix;
    mN = -2; // first term is a(-1)
    initialize();
  }

  /**
   * Constructor with a single class code.
   * @param classCode class code from the ATLAS,
   * for example "1A", "119B", or combined like "39CD"
   * @param prefix values for a(-1) and a(0)
   */
  public McKayThompsonSequence(final String classCode, final long[] prefix) {
    this(transitiveClosure(classCode), prefix);
  }

  /** Number of different class codes in the ATLAS */
  public static final int MAX_CLASS = McKayThompsonTables.MAX_CLASS;

  /** 
   * Number Faber polynomials.
   * Must be lower than the length of the power and boot coefficient lists
   */
  public static final int MAX_FABER = 7;

  /**
   * Get a list of class codes for powers
   * @param classCode get the powers for this class
   * @return a list of class codes
   */
  protected String[] getPower(final String classCode) {
    return McKayThompsonTables.sPowerMap.get(classCode);
  }

  /**
   * Get a list of boot coefficients
   * @param classCode get the boot coefficients for this class
   * @return a list of boot coefficients
   */
  protected Z[] getBoots(final String classCode) {
    final Long[] bootL = McKayThompsonTables.sBootsMap.get(classCode);
    final Z[] bootZ = new Z[bootL.length];
    for (int i = 0; i < bootL.length; ++i) {
        bootZ[i] = Z.valueOf(bootL[i]);
    }
    return bootZ;
  }

  /* Main matrix for storage of coefficients */
  private final HashMap<String, Z> mMatrix = new HashMap<String, Z>(4096); // main storage of coefficients

  /**
   * Get a matrix element
   * @param row class code, for example "1A"
   * @param col column index
   * @return a coefficient
   */
  protected Z getElem(final String row, final int col) {
    return mMatrix.get(row + String.valueOf(col));
  }

  /**
   * Put a matrix element
   * @param row class code, for example "1A"
   * @param col column index
   * @param coefficient to be set in the matrix
   */
  protected void putElem(final String row, final int col, final Z value) {
    mMatrix.put(row + String.valueOf(col), value);
  }

  /**
   * Determine whether the matrix contains a specific element
   * @param row class code, for example "1A"
   * @param col column index
   * @return true if the matrix contains element row,col; false otherwise
   */
  protected boolean containsElem(final String row, final int col) {
    return getElem(row, col) != null;
  }

  /* Position of first unknown coefficient for each class */
  private final HashMap<String, Integer> mLenComp = new HashMap<String, Integer>(MAX_CLASS);

  /**
   * Get the position of first unknown coefficient for a class
   * @param classCode get the position for this class
   * @return int
   */
  private int getComplete(final String classCode) {
    return mLenComp.get(classCode).intValue();
  }

  /**
   * Set the position of first unknown coefficient for a class
   * @param classCode set the position for this class
   * @param position set this position
   */
  private void setComplete(final String classCode, final int position) {
    mLenComp.put(classCode, new Integer(position));
  }

  /**
   * Set this to True to print coefficients as soon as they are computed,
   * False to print them in ordered fashion (all coefficients of q then
   * all of q^2, etc.).
   */
  private boolean earlyprint;

  /** Number of coefficients already printed */
  private int lenprinted;

  /** Maximum index for b-file output (standalone version, -c) */
  public int mMaxTerm;

  /**
   * Initialize the data structures
   */
  private void initialize() {
    earlyprint = sDebug >= 1;
    for (String cl: mSelectedClasses) { // #1: fill power, boots and mLenComp
      final Z[] blist = getBoots(cl);
      final int len = blist.length;
      setComplete(cl, len);
      for (int i = 0; i < len; ++i) {
        if (earlyprint) {
          System.out.println(String.format("# early.1 %s\t%d\t%s", cl, i, blist[i].toString()));
        }
        putElem(cl, i, blist[i]);
      } // for i
    } // for cl #1
    lenprinted = 1;
    mN = -2;
  }

  /**
   * Compute the next term of the sequence
   * @return a(mN)
   */
  @Override
  public Z next() {
    ++mN;
    if (mN < mPrefix.length - 1) { // take known values for a(-1) and a(0)
      return Z.valueOf(mPrefix[mN + 1]);
    } else {
      while (getComplete(mSelectedClasses[0]) <= mN) {
        iterate();
      }
      return getElem(mSelectedClasses[0], mN);
    }
  }

  /** accumulate the transitive closure here */
  private final static HashSet<String> sClosure = new HashSet<String>(32);
  
  /**
   * Compute the transitive closure of the powers of a class code
   * @param classCode starting element
   * @return the set of the powers for <code>classCode</code>, their powers and so on.
   * The first element is the input parameter.
   */
  public static String[] transitiveClosure(final String classCode) {
    enclose(classCode);
    final String[] result = new String[sClosure.size()];
    final Iterator<String> tcIter = sClosure.iterator();
    int ir = 0;
    result[ir++] = classCode; // [0]
    while (tcIter.hasNext()) {
      final String cl = tcIter.next();
      if (! cl.equals(classCode)) {
        result[ir++] = cl;
      }
    }
    return result;
  } // transitiveClosure
  
  /**
   * Recursively add a classCode and all of its powers to the transitive closure
   * @param classCode starting element
   */
  private static void enclose(final String classCode) {
    if (sClosure.add(classCode)) { // was not yet stored
      for (String power: McKayThompsonTables.sPowerMap.get(classCode)) {
        enclose(power);
      }
    }
    // else already enclosed
  } // enclose
  
  /**
   * Computes the sequences for a subset of class codes
   */
  public void compute() {
    boolean running = true;
    while (running) {
      iterate();
      if (! earlyprint) { // Print what we've computed so far, in orderly fashion:
        int lastcomplete = getComplete(mSelectedClasses[0]);
        for (String cl: mSelectedClasses) {
          if (lastcomplete < getComplete(cl)) {
            lastcomplete = getComplete(cl);
          }
        }
        for (int k = lenprinted; k < lastcomplete; ++k) {
          if (k > mMaxTerm) {
            running = false;
          } else {
            String cl = mSelectedClasses[0];
            System.out.println(String.valueOf(k) + " " + getElem(cl, k).toString());
          }
        }
        lenprinted = lastcomplete;
      } // ! earlyprint
    } // while running
  }

  /**
   * Compute one iteration for a subset of class codes
   */
  public void iterate() {
    for (String cl: mSelectedClasses) {
      // Start by forming a series with whatever contiguous
      // coefficients we have (i.e. j is the best approximation we
      // have so far on the Moonshine function for class cl).
      final int lenCl = getComplete(cl);
      ArrayList<Z> jcoefs = new ArrayList<Z>(lenCl);
      for (int k = 0; k < lenCl; ++k) {
        jcoefs.add(getElem(cl, k));
      }
      final PowerSeries j = new PowerSeries(0, jcoefs);
      j.addMonomial(Z.ONE, -1);
      // Now compute the first Faber polynomials of j:
      final PowerSeries[] jFaber = new PowerSeries[MAX_FABER];
      int ijf = 0;
      jFaber[ijf++] = new PowerSeries();
      jFaber[ijf++] = j;
      if (sDebug >= 2) {
          System.out.println("# cl=" + cl + ", j=" + j.toString());
      }
      final int minComplete = Math.min(getComplete(cl), MAX_FABER);
      for (int n = 2; n < minComplete; ++n) {
        // Here MAX_FABER=7 is a heuristic, meaning we compute the first 6 Faber
        // polynomials: any value at least equal to 5 should work, but
        // higher values are interesting only if you wish to earlyprint
        // high coefficients.
        // Besides, if you make this higher than 10 you need to extend the class power maps.
        final PowerSeries jn = jFaber[n - 1].multiply(j);
        if (sDebug >= 2) {
            System.out.println("#1 n=" + n + ", jn=" + jn.toString() + ", precis=" + jn.precis());
        }
        for (int k = n - 2; k > 0; --k) {
            jn.addMonomialTimes(jn.getCoeff(- k).negate(), 0 ,jFaber[k]);
        }
        jn.addMonomial(jn.getCoeff(0).negate(), 0);
        if (sDebug >= 2) {
            System.out.println("#2 n=" + n + ", jn=" + jn.toString() + ", precis=" + jn.precis());
        }
        jFaber[ijf++] = jn;
        // At this point, jn is the n-th Faber polynomial of j.
        for (int k = 1; k < jn.precis(); ++k) {
          if (! containsElem(cl, k * n)) {
            // Compute a coefficient from the action of the n-th
            // Hecke operator (with just n*coefs[k*n], the one we
            // will deduce, missing from the sum):
            if (sDebug >= 2) {
               System.out.println("# n-th Hecke, n=" + n + ", k=" + k);
            }
            try {
              Z v = Z.ZERO;
              for (int d = 1; d < n; ++d) { // d = all in strictDivisors
                if ((n % d) == 0) { // d divides n
                  final int a = n / d;
                  final String cla = getPower(cl)[a];
                  if (sDebug >= 2) {
                    System.out.println("# d=" + d + ", k=" + k + ", n=" + n + ", a=" + a + ", cla=" + cla);
                  }
                  if ((k % a) == 0) {
                    final int kk = (k / a) * d;
                    if (containsElem(cla, kk)) {
                      v = v.add(Z.valueOf(n / a).multiply(getElem(cla, kk)));
                    } else {
                      throw new UnsupportedOperationException("missing coefficient #1: " + String.valueOf(kk));
                    }
                  }
                } // if d divides n
              } // foreach divisor
              Z w = jn.getCoeff(k).subtract(v);
              if (sDebug >= 2) {
                 System.out.println("# w=" + w.toString() + ", v=" + v.toString());
              }
              if (! w.remainder(Z.valueOf(n)).equals(Z.ZERO)) {
                throw new IllegalArgumentException("divisibility check failed");
              }
              w = w.divide(Z.valueOf(n));
              putElem(cl, k * n, w);
              if (sDebug >= 1) {
                System.out.println("# early.2 cl=" + cl + ", k=" + k + ", n=" + n + ", w=" + w.toString());
              }
            } catch (UnsupportedOperationException exc) {
              if (sDebug >= 1) {
                System.out.println("# " + exc.getMessage() + ", k=" + k + ", n=" + n);
              }
            }
          } // if
        } // foreach k
      } // for n
    } // for cl #2

    // Now try the other way around: deduce some lower coefficients
    // from the higher ones (known through the Hecke operators).  We
    // only use T_2 here, so we only deal with F_2(j), which is
    // essentially j^2 (up to a constant -2*c1 we don't care about
    // since we're interested only in one, higher, coefficient).
    for (String cl: mSelectedClasses) {
      final String cl2 = getPower(cl)[2];
      try {
        boolean busy = true;
        while (busy) {
          // See if getComplete can be increased.
          while (containsElem(cl, getComplete(cl))) {
            setComplete(cl, getComplete(cl) + 1);
          }
          // Try to compute the first unknown coefficient
          // (getComplete()) by computing the previous coefficient in
          // 2 T_2(j) and equating.
          final int k = getComplete(cl) - 1;
          if (! containsElem(cl, k * 2)) {
            throw new UnsupportedOperationException("missing coefficient #2: " + String.valueOf(k * 2));
          }
          Z v = getElem(cl, k * 2).multiply2();
          if ((k % 2) == 0) {
            if (! containsElem(cl2, k / 2)) {
              throw new UnsupportedOperationException("missing coefficient #3: " + String.valueOf(k / 2));
            }
            v = v.add(getElem(cl2, k / 2));
          }
          // At this point, v is coefficient k of j^2, computed from
          // the Hecke operators.  Now we can deduce coefficient k+1
          // of j from this:
          for (int i = 1; i < k; ++i) {
            v = v.subtract(getElem(cl, i).multiply(getElem(cl, k - i)));
          }
          if (! v.isEven()) {
            throw new IllegalArgumentException("Evenness check failed!");
          }
          v = v.divide2();
          putElem(cl, k + 1, v);
          if (sDebug >= 1) {
              System.out.println("# early.3 cl=" + cl + ", v=" + v.toString());
          }
        } // while busy
      } catch (UnsupportedOperationException exc) {
          if (sDebug >= 1) {
            System.out.println("# " + exc.getMessage());
          }
          // pass
      }
    } // foreach cl #3
  } // iterate

  /**
   * Test method
   * @param args commandline arguments, a list of options:
   * <ul>
   * <li>-d  debugging mode (0 = none (default), 1 = some, 2 = more)</li>
   * <li>-c  list of class codes, with all divisors</li>
   * <li>-n  number of terms to be computed</li>
   * <li>-p  comma-separated list of terms to be prefixed</li>
   * <li>-tc compute the transitive closure a single class code</li>
   * </ul>
   */
  public static void main(String[] args) {
    String classCode = "1A";
    if (args.length == 0) {
      final McKayThompsonSequence seq = new McKayThompsonSequence(new String[] { classCode }, new long[] { -1, 0 });
      seq.sDebug = 1;
      // preliminary access routine test
      System.out.print("power: \"" + classCode + "\" -> " );
      classCode = "119AB";
      final String[] powers = seq.getPower(classCode);
      String sep = "";
      for (int i = 0; i < powers.length; ++i) {
          System.out.print(sep + "\"" + powers[i] + "\"");
          sep = ",";
      }
      System.out.println();
      System.out.print("boots: \"" + classCode + "\" -> " );
      classCode = "2A";
      final Z[] boots = seq.getBoots(classCode);
      sep = "";
      for (int i = 0; i < boots.length; ++i) {
          System.out.print(sep + boots[i].toString());
          sep = ",";
      }
      System.out.println();
    } else { // some arguments: 1A,2A
      String[] selectedClasses = new String[] {"3A", "1A" };
      int maxTerm = 1000;
      int sDebug = 0;
      int action = 0; // -c
      int iarg = 0;
      long[] tlist = new long[] { -1, 0 };
      while (iarg < args.length) {
        try {
          switch (args[iarg++]) {
            case "-d":
              sDebug = Integer.parseInt(args[iarg++]);
              break;
            case "-a":
              action = 1;
            case "-c":
              selectedClasses = args[iarg++].split("\\, *");
              break;
            case "-n":
              maxTerm = Integer.parseInt(args[iarg++]);
              break;
            case "-p":
              String[] plist = args[iarg++].split("\\, *");
              tlist = new long[plist.length];
              for (int iterm = 0; iterm < plist.length; ++iterm) {
                tlist[iterm] = Integer.parseInt(plist[iterm]);
              }
              break;
            case "-tc":
              action = 2;
              classCode = args[iarg++];
              break;
            default:
              break;
          }
        } catch (final RuntimeException exc) {
          // ignored
        }
      } // while
      final McKayThompsonSequence seq = selectedClasses.length == 1 
          ? new McKayThompsonSequence(selectedClasses[0], tlist)
          : new McKayThompsonSequence(selectedClasses   , tlist)
          ;
      seq.sDebug = sDebug;
      seq.mMaxTerm = maxTerm;
      try {
        switch (action) {
          default:
          case 0: // -c
            System.out.println("# b-file generated by irvine.oeis.McKayThompsonSequence");
            seq.compute();
            break;
          case 1: // -a
            for (int n = -1; n <= seq.mMaxTerm; ++n) {
              System.out.println(n + " " + seq.next().toString());
            }
            break;
          case 2:
            System.out.println("transitiveClosure(" + classCode + ") = ");
            for (String cl: seq.transitiveClosure(classCode)) {
              System.out.print(cl + " ");
            }
            System.out.println();
            break;
        } // switch action
      } catch (Exception exc) {
        System.out.println(exc.getMessage());
        exc.printStackTrace();
      }
    } // some arguments
  } // main

}
