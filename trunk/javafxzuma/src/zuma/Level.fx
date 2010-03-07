/*
 * Level.fx
 *
 * Created on Jan 13, 2010, 2:20:50 PM
 */

package zuma;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

import java.util.ArrayList;

/**
 * @author javatest
 */

abstract public class Level extends UI{
public var patharray : ArrayList;
public def detector = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames : [
            KeyFrame {
                time: bind Config.DETECTOR_FREQUENCY
                action: detect
            }
        ]
}
public abstract function ready():Void;
function detect() {
        Main.model.specialEffectCount();
        Main.model.generBall();
        if(Main.model.sizeofRunning() == 10 and Main.model.defaultRate == Config.INITIAL_RATE){
                    Main.model.setDefaultRate(Config.RUNNING_RATE);
                    Main.model.restoreAllRunning();
                    Main.model.startBulletGenor();
                    Main.model.generedoffset = Config.NORMAL_OFFSET;
        }
        if(Main.model.ending){
//            Main.model.setDefaultRate(Config.END_RATE);
//            door.open();
        }
        if(Main.model.ended()){
//            door.close();
        }
        //TODO : performance issue
        //Main.model.restoreRateWhenAllPaused();
        Main.model.dectectHitandMove();
        Main.model.stopShift();
        Main.model.stopBack();
//        Main.model.stopPause();
        if(Main.model.sizeofRunning() == 0){
            Main.gamestat = 0;
        }
}
}
