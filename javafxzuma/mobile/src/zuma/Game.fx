/*
 * Game.fx
 *
 * Created on Jan 13, 2010, 2:20:50 PM
 */

package zuma;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

import java.util.ArrayList;

import zuma.components.Progress;

/**
 * @author javatest
 */

abstract public class Game extends UI{
public var patharray : ArrayList;
public def progress = Progress{
            progressImage:Resources.background_upper;
            fillImage:Resources.progress_fill
            max : bind Main.currentData.target
        };
public def detector = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames : [
            KeyFrame {
                time: bind Config.DETECTOR_FREQUENCY
                action: detect
            }
        ]
}
public abstract function setEmitter();
public abstract function ready():Void;
function detect() {
        if(progress.isCompleted()){
                Main.model.sucess = true;
        }
        Main.model.specialEffectCount();
        Main.model.generBall();
        if(Main.model.sizeofRunning() >= Main.currentData.init_ball and Main.model.defaultRate == Main.currentData.INITIAL_RATE){
                    Main.model.defaultRate = Config.RUNNING_RATE;
                    Main.model.restoreAllRunning();
                    Main.model.startBulletGenor();
                    Main.model.generedoffset = Config.NORMAL_OFFSET;
        }
        Main.model.dectectHitandMove();
        setEmitter();
        if(Main.model.ending){
            Main.model.stopGenerBall();
            Main.model.endingRunning();
//            door.open();
        }
        if(Main.model.ended()){
//            door.close();
        }
        Main.model.stopShift();
        Main.model.stopBack();
        if(Main.model.sizeofRunning() == 0){
            if(progress.isCompleted() and not Main.model.ending){
                Main.gamestat = 4;
            }else if(Main.model.ending){
                 Main.gamestat = 0;
            }else{
                Main.model.reGenerBall();
            }
        }
}
}
