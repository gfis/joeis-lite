package irvine.oeis.a346;
// Generated by gen_seq4.pl holfsig/holos at 2023-05-05 23:17

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A346321 Number of permutations of [n] having six cycles of the form (c1, c2, ..., c_m) where c1 = min_{i&gt;=1} c_i and c_j = min_{i&gt;=j} c_i or c_j = max_{i&gt;=j} c_i.
 * @author Georg Fischer
 */
public class A346321 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A346321() {
    super(6, "[0,52183852646400,-290924978503680,758836566687744,-1231344289972224,1394246317768704,-1171275127980032,757761436024832,-386804516978688,158334587600896,-52534235435008,14222131077120,-3151736133632,571843371008,-84702207744,10178341888,-981976576,74858880,-4402160,192416,-5880,112,-1]", "1,21,322,4284,52941,627627,7264499,82948008,940359420,10628025408,120071145376,1358324810752,15403850755456,175232115148032,2000450203866368,22922052379355136,263639657993643008,3043516686354636800,35260990780587196416,409914386080322027520,4780624372236181700608,55920920838265964003328,655940007685340763979776,7713569308390476527173632,90918266095675603115835392,1073884906493255585296809984,12708256292824783977676013568", 0);
  }
}
