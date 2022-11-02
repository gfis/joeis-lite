package irvine.oeis.a157;
// manually holsig/holos at 2022-09-30 16:15

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A157993 Number of n-colorings of the Coxeter graph.
 * @author Georg Fischer
 */
public class A157993 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A157993() {
    super(0, 
        "[0,1,-29,406,-3654,23751,-118755,475020,-1560780,4292145,-10015005,20030010,-34597290,51895935,-67863915,77558760,-77558760,67863915,-51895935,34597290,-20030010,10015005,-4292145,1560780,-475020,118755,-23751,3654,-406,29,-1]", 
        "0,0,0,786240,397543795824,3153491495915040,2897591335142535360,709217913680036905200,70921407068068519599840,3718329027062088400988544,119720148366778311215868480,2633253678249157711210367520,42653023518489941374251310800,537529269805074949808436270240,5493210704195489330580702987264,47000075931056592553942034986320,345264759569768431457589299436480,2222049758638421515606628012812800,12736180745261948960099661577645440,65901379767784877289157154130633984,311337252180562482613144448322784560,1355780973846438202134032151648222240,5486466480885364635614163201132187200,20776041379482787562645349870749803440,74064766970805974144421612712631980704,249868769287496482195728858622016419200,801407590071419017348881758576118244800,2453510290487738738146426687028836140000,7195577080093821598537089379493294052240,20279877380802204253626765505181382539424",
        0);
  }
}