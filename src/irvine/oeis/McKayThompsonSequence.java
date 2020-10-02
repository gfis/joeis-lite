package irvine.oeis;

import irvine.math.z.Z;
import irvine.math.PowerSeries;
import irvine.oeis.McKayThompsonTables;

/**
 * McKay-Thompson series for the monster group.
 * Derived from <code>moonshine.py</code> of
 * David A. Madore <david.madore@ens.fr> - 2007-07-31 - Public Domain
 * Cf. https://web.archive.org/web/20130925003421/http://mathforum.org/kb/thread.jspa?forumID=253&threadID=1602206&messageID=5836094 
 * @author Georg Fischer
 */
public abstract class McKayThompsonSequence implements Sequence {

  /** Empty constructor */
  public McKayThompsonSequence() {
    this("18A");
  }
  
  /** 
   * Constructor with class designation 
   * @param name a class name form the ATLAS, for example "18A"
   **/
  public McKayThompsonSequence(String className) {
    
  }
  
  protected long mN = -2; 
  
  @Override
  public Z next() {
    return Z.valueOf(mN);
  }
}
