package irvine.oeis.ca;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * Data structure and methods for the evaluation of an elementary, one-dimensional cellular automaton
 * with a fixed rule number between 0 and 255,
 * as described by Stephen Wolfram in the book "A New Kind Of Science" (ANKOS).
 * @author Georg Fischer
 */
public class ElementaryCellularAutomaton implements Sequence {

  protected int mRule; // rule number 0..255, c.f. ANKOS p. 53
  protected int mGen; // generation, starting with 1 and a single cell of some color (BLACK, WHITE)
  protected int mFormat; // 0 = binary, 1 = decimal
  protected String mCode; // type of the resulting sequence
  
  /**
   * Creates a new cellular automaton for the given rule.
   * @param rule rule number for this automaton (0-255).
   */
  public ElementaryCellularAutomaton(final int rule) {
    this(rule, "ca1triangle");
  }

  /**
   * Creates a sequence derived from the cellular automaton with the given rule.
   * @param rule rule number for this automaton (0-255).
   * @param code a String specifying the type of the sequence
   */
  public ElementaryCellularAutomaton(final int rule, final String code) {
    mRule = rule;
    mCode = code;
  }

  @Override
  public Z next() {
    return Z.ZERO;
  }
}
