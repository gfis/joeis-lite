package irvine.oeis.a120;
// manually holsig/holos at 2022-09-30 16:15

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A120410 a(n) = n^1*(n+1)^2*(n+2)^3*(n+3)^4*(n+4)^5*(n+5)^6*(n+6)^7/(1!*2!*3!*4!*5!*6!*7!).
 * @author Georg Fischer
 */
public class A120410 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A120410() {
    super(0, 
        "[0,1,-29,406,-3654,23751,-118755,475020,-1560780,4292145,-10015005,20030010,-34597290,51895935,-67863915,77558760,-77558760,67863915,-51895935,34597290,-20030010,10015005,-4292145,1560780,-475020,118755,-23751,3654,-406,29,-1]", 
        "0,26471025,11014635520,1306613597184,72013536000000,2320337450970000,49989108969676800,785820119347897920,9577928124440387712,94609025993497640625,783056974947287040000,5572874347584082739200,34808179069805870776320,193986366711798174329088,977740312126712832000000,4507277364789593012640000,19183925991904418575353600,75991560189700242553780545,282078001776798053802049536,986988571992596250000000000,3272057307351812980000000000,10323877552205370822776250000,31123676327820644298931200000,89966321744589523750077288000,250124665047687400247550000000,670691388929837735484007790625,1738827420003727147343963750400,4368456253541687001392527441920,10656479409017087878465421574144,25287636935006693792243776000000",
        0);
    }
}
