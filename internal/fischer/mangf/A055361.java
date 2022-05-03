package irvine.oeis.a055;

import irvine.oeis.HolonomicRecurrence;

/**
 * A055361 Number of increasing mobiles (circular rooted trees) with n nodes and 7 leaves.
 * @author Georg Fischer
 */
public class A055361 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A055361() {
    super(8, A055357.computeRecurrence(7), "720,35280,915984,16939800,251869440,3213860944,36634201456,383130347344,3745749248752,34704916926064,307859356272208,2635356154189416,21904079389753056,177636951598742640,1411151699824777200,11016339248602109856,84735795554832495504,643589652574996760976,4835632438605504210576,35996671160311854885432,265824853443176521997760,1949518646146046939768592,14212216457016871731436656,103072847827248891890355568,744168174694338995070819376,5351766996277480154655668272,38356810798853291284304369104,274092466170749584734319368328,1953555422925411118445665991584,13892210701677389058758966284848,98595760001930328564147426143472,698545237418494518052562958181056,4941678846702436892253393521732304,34912457319259553567440784529034320,246367851735577188584730295405090320,1736793205375962297681725230513290072,12232845599851322380070980894154391168,86093461014868468601773733402120232912,605505538729184088326043437242721504112,4256063621074747128173315312510104039824");
  }
}
