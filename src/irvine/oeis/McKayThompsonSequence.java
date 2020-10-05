package irvine.oeis;

import irvine.math.z.Z;
import irvine.oeis.McKayThompsonTables;
import irvine.math.PowerSeries;

import java.lang.UnsupportedOperationException;
import java.util.ArrayList;
import java.util.HashMap;
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

  public static int sDebug = 0; // debugging mode: 0 = none, 1 = some (=earlyprint), 2 = more

  /**
   * Set this to True to print coefficients as soon as they are computed,
   * False to print them in ordered fashion (all coefficients of q then
   * all of q^2, etc.).
   */
  private boolean earlyprint;

  /** Empty constructor */
  public McKayThompsonSequence() {
    this("18A");
  }

  /**
   * Constructor with class code.
   * @param classCode class code in the ATLAS,
   * for example "1A", "119B", or combined like "39CD"
   **/
  public McKayThompsonSequence(final String classCode) {
    final String cl = classCode; // desired class
  }
  /** Index of the next term of the sequence to be returned by <code>next()</code> */
  protected long mN = -2;

  @Override
  public Z next() {
    return Z.valueOf(mN);
  }

  /** Number of different class codes in the ATLAS */
  public static final int MAX_CLASS = McKayThompsonTables.MAX_CLASS;

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

  /* Main storage of coefficients */
  private final HashMap<String, ArrayList<Z>> coefs = new HashMap<String, ArrayList<Z>>(MAX_CLASS);

  /* Position of first unknown coefficient for each class */
  private final HashMap<String, Integer> mLenComp = new HashMap<String, Integer>(MAX_CLASS);// coefs is the main storage of coefficients

  /**
   * Get the position of first unknown coefficient for a class
   * @param classCode get the position for this class
   * @return int
   */
  private int lencomplete(String classCode) {
    return mLenComp.get(classCode).intValue();
  }

  /**
   * Computes the sequences for a subset of class codes
   * @param selectedClasses the subset of class codes
   */
  public void compute(final String[] selectedClasses) {
    earlyprint = sDebug >= 1;
    for (String cl: selectedClasses) { // #1: fill power, boots and mLenComp
      final Z[] blist = getBoots(cl);
      final int len = blist.length;
      mLenComp.put(cl, new Integer(len));
      final ArrayList<Z> alist = new ArrayList<Z>(len);
      for (int i = 0; i < len; ++i) {
        alist.add(blist[i]);
        if (earlyprint && i > 0) {
          System.out.println(String.format("early#1 %s\t%d\t%s", cl, i, alist.get(i).toString()));
        }
      } // for i
      coefs.put(cl, alist);
    } // for cl #1
    int lenprinted = 1;
    
    boolean running = true;
    while (running) {
      for (String cl: selectedClasses) {
        // Start by forming a series with whatever contiguous
        // coefficients we have (i.e. j is the best approximation we
        // have so far on the Moonshine function for class cl).
        final int lenk = lencomplete(cl);
        ArrayList<Z> jcoefs = new ArrayList<Z>(lenk);
        for (int k = 0; k < lenk; ++k) {
          jcoefs.add(coefs.get(cl).get(k));
        }
        final PowerSeries j = new PowerSeries(0, jcoefs);
        j.addMonomial(Z.ONE, -1);
        // Now compute the first Faber polynomials of j:
        final PowerSeries[] jFaber = new PowerSeries[6];
        int ijf = 0;
        jFaber[ijf++] = new PowerSeries();
        jFaber[ijf++] = j;
        if (sDebug >= 2) {
            System.out.println("# cl=" + cl + ", j=" + j.toString());
        }
        final int min7 = Math.min(lencomplete(cl), 7); // jFaber.length + 1); // 7
        for (int n = 2; n < min7; ++n) {
          // (Here 7 is a heuristic, meaning we compute the first 6 Faber
          // polynomials: any value at least equal to 5 should work, but
          // higher values are interesting only if you wish to earlyprint
          // high coefficients.
          // Besides, if you make this higher than 10
          // you need to extend the class power maps.)
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
            if (coefs.get(cl).size() <= k * n) {
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
                      if (coefs.get(cla).size() > kk) {
                        v = v.add(Z.valueOf(n / a).multiply(coefs.get(cla).get(kk)));
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
                
                if (k * n < coefs.get(cl).size()) {
                  coefs.get(cl).set(k * n, w);
                } else {
                  coefs.get(cl).add(w);
                }
                if (sDebug >= 1) {
                  System.out.println(String.format("early#2 %s\t%d\t%s", cl, k * n, w.toString()));
                }
              } catch (UnsupportedOperationException exc) {
                System.out.println("# rtexc1 " + exc.getMessage() + ", k=" + k + ", n=" + n);
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
      for (String cl: selectedClasses) {
        final String cl2 = getPower(cl)[2];
        try {
          boolean busy = true;
          while (busy) {
            // See if lencomplete can be increased.
            while (coefs.get(cl).size() > lencomplete(cl)) {
              mLenComp.put(cl, new Integer(lencomplete(cl) + 1));
            }
            // Try to compute the first unknown coefficient
            // (lencomplete) by computing the previous coefficient in
            // 2 T_2(j) and equating.
            final int k = lencomplete(cl) - 1;
            if (coefs.get(cl).size() <= k * 2 ) {
              throw new UnsupportedOperationException("missing coefficient #2: " + String.valueOf(k * 2));
            }
            Z v = coefs.get(cl).get(k * 2).multiply(Z.TWO);
            if ((k % 2) == 0) {
              if (coefs.get(cl2).size() <= k / 2) {
                throw new UnsupportedOperationException("missing coefficient #3: " + String.valueOf(k / 2));
              }
              v = v.add(coefs.get(cl2).get(k / 2));
            }
            // At this point, v is coefficient k of j^2, computed from
            // the Hecke operators.  Now we can deduce coefficient k+1
            // of j from this:
            for (int i = 1; i < k; ++i) {
              v = v.subtract(coefs.get(cl).get(i).multiply(coefs.get(cl).get(k - i)));
            }
            if (! v.isEven()) {
              throw new IllegalArgumentException("Evenness check failed!");
            }
            v = v.divide2();
            coefs.get(cl).set(k + 1, v);
          } // while busy
        } catch (UnsupportedOperationException exc) {
            System.out.println("# rtexc2 " + exc.getMessage());
            // pass
        }
      } // foreach cl #3
      
      // Print what we've computed so far, in orderly fashion:
      if (! earlyprint) {
        int lastcomplete = lencomplete(selectedClasses[0]);
        for (String cl: selectedClasses) {
          if (lastcomplete < lencomplete(cl)) {
            lastcomplete = lencomplete(cl);
          }
        }
        for (int k = lenprinted; k < lastcomplete; ++k) {
           for (String cl: selectedClasses) {
             System.out.println(String.format("%s\t%d\t%s", cl, k, coefs.get(cl).get(k).toString()));
           }
        }
        lenprinted = lastcomplete;
      } // ! earlyprint
    } // while running
  } // compute

  /**
   * Test method
   */
  public static void main(String[] args) {
    String classCode = "1A";
    McKayThompsonSequence seq = new McKayThompsonSequence(classCode);
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
    
    // compute all
    if (args.length > 0) { // one argument: 1A,2A
      int iarg = 0;
      try {
      	seq.sDebug = Integer.parseInt(args[iarg++]);
      } catch (Exception exc) {
      }
      String alist = args[iarg++];
      String[] selectedClasses = alist.split("\\,");
      seq.compute(selectedClasses);
    }
  } // main

}
