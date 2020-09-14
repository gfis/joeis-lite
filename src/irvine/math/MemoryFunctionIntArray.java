package irvine.math;

import java.util.HashMap;

/**
 * Definition of a five argument function that remembers previously computed results.
 * @author Georg Fische
 * @param <R> result type
 */
public abstract class MemoryFunctionInt5<R> extends HashMap<String, R> {

  private final StringBuffer mKeyBuf = new StringBuffer(64);
  /**
   * Compute the function at specified parameters.
   * @param a array of int parameters
   * @return value of function
   */
  protected abstract R compute(final int[] a);

  /**
   * Return the value of the function at specified parameters.
   * @param a array of int parameters
   * @return value of function
   */
  public R get(final int[] a) {
  	mKeyBuf.setLength(0);
  	for (int i = a.length - 1; i >= 0; --i) {
  		mKeyBuf.append(a[i]);
  		if (i > 0) {
  			mKeyBuf.append(',');
  		}
    } 
    final String key = mKeyBuf.toString();
    final R res = get(key);
    if (res != null) {
      return res;
    }
    final R r = compute(a);
    put(key, r);
    return r;
  }
}
