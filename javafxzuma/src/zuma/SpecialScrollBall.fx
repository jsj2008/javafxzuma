/*
 * SpecialScrollBall.fx
 *
 * Created on Jan 28, 2010, 4:37:17 PM
 */

package zuma;

import zuma.components.FadeBall;

import zuma.util.Util;




/**
 * @author javatest
 */
public var SPECIAL_BOM = 0;
public var SPECIAL_BACK = 1;
public var SPECIAL_ACCURACY = 2;
public var SPECIAL_SLOW = 3;
public class SpecialScrollBall extends ScrollBall{
public var SPECIAL_TYPE = 0;
public-read var effectIndex = Util.random(4);
override public var imageIndex = Util.random(6) on replace{
        effectIndex = Util.random(4);
        if(effectIndex == 0){
            ballImage = Resources.bomImage[imageIndex];
            SPECIAL_TYPE = SPECIAL_BOM;
        }
        if(effectIndex == 1){
            ballImage = Resources.backwardsImage[imageIndex];
            SPECIAL_TYPE = SPECIAL_BACK;
        }
        if(effectIndex == 2){
            ballImage = Resources.accuracyImage[imageIndex];
            SPECIAL_TYPE = SPECIAL_ACCURACY;
        }
        if(effectIndex == 3){
            ballImage = Resources.slowImage[imageIndex];
            SPECIAL_TYPE = SPECIAL_SLOW;
        }
};
override public function atTheEndOfTransition(object : Object){
        if(rate < 0){
                 return;
            }
            if(Main.model.isInRunningQueue(this)){
                Main.model.endingRunning();
            }
            setStatus(GameBall.DEAD_STATE);
            vis = false;
            Main.model.recycleSpecial(this,object);
            Main.model.delfromRunning(this);
}
override var animball = FadeBall {
        //rotate : 90
        ball_deameter : Config.BALL_DIAMETER
        smooth: true
        fade : false
        image: bind ballImage
        cache : true
       // rotate: bind rotatedegrees
        opacity : bind opac
};
}
