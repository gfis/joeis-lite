package irvine.oeis;

import irvine.math.z.Z;
import java.util.HashMap;

/**
 * Number of walks within N^3 (the first octant of Z^3) starting at (0,0,0).
 * @author Georg Fischer
 */
public class WalkCubeSequence implements Sequence {

  protected Z mK; // current number with some property
  protected int mN; // index of current term to be returned
  protected int mOffset; // OEIS offset1 as of generation time
  protected HashMap<String, Long> mCache;
  /**
   * Construct an instance which selects all numbers
   * that have some property in the runs of digits to some base.
   * @param offset first valid term has this index
   */
  protected WalkCubeSequence(final int offset) {
    mOffset = offset;
    mN = offset - 1;
    mK = Z.valueOf(mN);
    mCache = new HashMap<String, Long>(16384);
  }

  //=====================================
  /**
   * Get the next term of the sequence.
   * @return the next term
   */
  @Override
  public Z next() {
    ++mN;
    long sum = 0;
    int i, j, k, m;
    m = mN;
    for (i = 0; i <= m; i ++) {
      for (j = 0; j <= m; j ++) {
        for (k = 0; k <= m; k ++) {
          sum += aux(i, j, k, m);
        } // for k
      } // for j
    } // for i
    return Z.valueOf(sum);
  } // next

  /**
   * Determine the number of possible next steps
   * for some point in the m^3 cube.
   * @param i x coordinate of the point
   * @param j y coordinate of the point
   * @param k z coordinate of the point
   * @param m current edge length of the cube
   * @return number of possible steps starting at this point
   */
  protected long aux(int i, int j, int k, int m) {
    String key = i + "," + j + "," + k + "," + m;
    Object obj = mCache.get(key);
    long result = 0;
    if (obj == null) {
      if  (  i > m || j > m || k > m 
          || i < 0 || j < 0 || k < 0
          ) {
        // result = 0;
      } else if (m == 0) {
        if (key.substring(0, 5).equals("0,0,0")) {
          result = 1; // the Kronecker delta
        } else {
          // result = 0;
        }
      } else {
        int mn1 = m - 1;
        int ip1 = i + 1;
        result
        = aux(i - 1, j    , k    , mn1)
        + aux(ip1  , j - 1, k    , mn1)
        + aux(ip1  , j + 1, k - 1, mn1)
        + aux(ip1  , j + 1, k + 1, mn1)
        ;
      }
      mCache.put(key, result);
      // value == null
    } else {
      result = (long) obj;
    } 
    return result;
  } // aux

  /**
   * Get some property of the next number.
   * This method is an example only.
   * It is typically overwritten in order to return some other property.
   * @return property of the next number
   */
  protected Z getNextProperty() {
    mK = mK.add(Z.ONE);
    return getProperty();
  } // getNextProperty

  /**
   * Get the next term of a sequence which fulfills some property.
   * @return the next number with the property
   */
  protected Z getNextWithProperty() {
    long loopCheck = 100000000L;
    while (loopCheck > 0) {
      mK = mK.add(Z.ONE);
      if (isOk()) {
        loopCheck = -1;
        break;
      }
      loopCheck --;
    } // while busy
    if (loopCheck == 0) {
      throw new IllegalArgumentException("more than 10^8 iterations in WalkCubeSequence.getNextWithProperty()");
    }
    return mK;
  } // getNextWithProperty

  /**
   * Get some property of the current number.
   * This method is an example only.
   * It is typically overwritten in order to return some other property.
   * @return a property of the current number <em>mK</em>.
   */
  protected Z getProperty() {
    return mK;
  } // getProperty

  /**
   * Determine whether the current number has the property which includes it in the sequence.
   * This method is an example only.
   * It is typically overwritten in order to test some other property.
   * @return true iff the current number <em>mK</em> has some property.
   */
  protected boolean isOk() {
    return true;
  } // isOk

  /**
   * Get the index of the current term of the sequence.
   * @return the index starting with the offset of the sequence
   */
  protected int getIndex() {
    return mN;
  } // getIndex

  //=====================================
  /** Test method - not yet implemented.
   *  @param args command line arguments: [noterms]
   *  Show various elements related to the runds of digits for some base in n.
   */
  public static void main(String[] args) {
    int iarg = 0;
    int noTerms = 16;
    if (iarg < args.length) {
      try {
        noTerms = Integer.parseInt(args[iarg ++]);
      } catch (Exception exc) {
      }
    }
    WalkCubeSequence seq = new WalkCubeSequence(1);
    int n = 0;
    long startTime = System.currentTimeMillis();
	int iterm = 1;
	while (iterm <= noTerms) {
	  ++n;
	  System.out.println(n + " " + seq.next().toString());
	} // while
	System.err.println("# elapsed time: " + String.valueOf(System.currentTimeMillis() - startTime) + "\n");
  } // main

} // WalkCubeSequence
