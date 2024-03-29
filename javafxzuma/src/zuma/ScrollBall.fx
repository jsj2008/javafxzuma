/*
 * ScrollBall.fx
 *
 * Created on Jan 18, 2010, 4:25:25 PM
 */

package zuma;

import javafx.scene.Node;
import javafx.util.Math;
import javafx.animation.transition.OrientationType;
import javafx.animation.transition.ScaleTransition;
import javafx.animation.transition.FadeTransition;
import javafx.animation.transition.ParallelTransition;


import javafx.scene.image.Image;
import zuma.components.AnimBall;

import zuma.components.Ball;
import zuma.components.SVGTransition;

import zuma.util.Util;

import zuma.components.ImagesPlayer;
import zuma.Resources;

import java.util.ArrayList;

/**
 * @author perkin tang
 */

public class ScrollBall extends GameBall{
public var patharray : ArrayList;
public-read var statusList : Boolean[] = [false,false,false,false,false,false,false,false];
var MAX_CHADOWS = 10;
var MAX_GIVEN = 5;
public var fromIndex = 0;
public var stopped = false;
public var animball : Ball= AnimBall {
        rate : bind rate with inverse
        rotate : -90
        ball_deameter : Config.BALL_DIAMETER
        smooth: true
        image: bind ballImage
        cache : true
        maxrate : (Config.MOVE_ROLL_FREQUENCY/Config.DETECTOR_FREQUENCY) as Integer
        scaleX : bind scaleX
        scaleY : bind scaleY
       // rotate: bind rotatedegrees
        opacity : bind opac
};
public var rate : Integer = 1 on replace{
        if(rate == Config.RUNNING_RATE or rate == Config.SPECIAL_ACC_RATE or rate == Config.SPECIAL_SLOW_RATE or rate == Config.SPECIAL_BACK_RATE){
                stopped = false;
                setStatus(GameBall.RUNNING_STATE);
        }
        if(rate == Config.BACK_RATE){
                if(not isInStatus(GameBall.HIT_MOVING_STATE)){
                    stopped = false;
                    setStatus(GameBall.BACK_RUNNING_STATE);
                }
        }
        if(rate == Config.SHIFT_RATE){
                stopped = false;
                setStatus(GameBall.SHIFT_RUNNING_STATE);
        }
        if(rate == Config.END_RATE){
                stopped = true;
        }
        if(rate == Config.PAUSED_STOPPED_RATE){
                if(not isInStatus(GameBall.HIT_MOVING_STATE)){
                    if(stopped){
                        setStatus(DEAD_STATE);
                    }else{
                        stopped = false;
                        setStatus(GameBall.PAUSED_STATE);
                    }
                }
        }
};
public var imageIndex = Util.random(6) on replace{
        ballImage = Resources.ballarray[imageIndex];
};
protected var ballImage : Image;
override public var  translateX = -100;
override public var  translateY = -100;
//public var offsetX = Config.BALL_DIAMETER/2;
//public var offsetY = Config.BALL_DIAMETER/2;
public var opac = 1.0;
public var vis = true on replace{
   if(vis == true){
         opac = 1.0;
         opacity = 1.0;
   }else{
         opac = 0;
         opacity = 0.0;
   }
};
init{
//  Logger.log("new ball");
}
override public function create(): Node {
        animball;
}
public function setStatus(status : Integer){
    statusList[status] = true;
}
public function unsetStatus(status : Integer){
    statusList[status] = false;
}
public function isInStatus(status : Integer){
    return statusList[status];
}
public function clearStatus(){
    statusList =  [false,false,false,false,false,false,false];
}
public var anim1 = SVGTransition {
        rate: bind rate with inverse
        node: this
        fromIndex : bind fromIndex
        //offsetX : bind offsetX
        //offsetY : bind offsetY
        pathArray : bind patharray
        orientation : OrientationType.ORTHOGONAL_TO_TANGENT
        maxrate : (Config.MOVE_ROLL_FREQUENCY/Config.DETECTOR_FREQUENCY) as Integer
        action : atTheEndOfTransition
        onError : onError
};
public function atTheEndOfTransition(object : Object):Void{
        Main.model.ending = true;
        Main.model.recycleBall(this,object);
}
public function onError(object : Object):Void{
        Main.model.recycleBall(this,object);
}
var scaleTransition = ScaleTransition {
        duration: 0.5s node: this
        byX: 1.5 byY: 1.5
        repeatCount:2
        autoReverse: true
        action : function () {
            makeUnvisable();
        }
    }
var parTransition = ParallelTransition {
        node: this
        content: [
            FadeTransition { duration: 0.8s fromValue: 1.0 toValue: 0
                },
            ScaleTransition { duration: 1s fromX : 1 fromY : 1 byX: 1.5 byY: 1.5
                },
        ]
        action : function(){
            this.scaleX = 1;
            this.scaleY = 1;
        }
}
public def effectplayer = ImagesPlayer{max : sizeof Resources.purgeffectImage+1 ,repeatCount:sizeof Resources.purgeffectImage,images: Resources.purgeffectImage,rate : 1,opacity:0,width:Config.BALL_DIAMETER*3,height:Config.BALL_DIAMETER*3};
public function ScalingAndUnvisable(){
    makeUnvisable();
//    var exploded = ExplodedBall{group : (Main.ui as Game2).gamecontent,x : translateX + Config.BALL_DIAMETER/2, y : translateY + Config.BALL_DIAMETER/2};
    effectplayer.translateX = translateX + Config.BALL_DIAMETER/2 - Config.BALL_DIAMETER/2*Config.BALL_PURGE_RATIO;
    effectplayer.translateY = translateY + Config.BALL_DIAMETER/2 - Config.BALL_DIAMETER/2*Config.BALL_PURGE_RATIO;
    effectplayer.opacity = 1.0;
    effectplayer.play();
//    exploded.start();
}
public function show(){
    vis = true;
}
public function currentRate(){
    return this.rate;
}
function isRightPosition(ball : ScrollBall){
    var bx = ball.translateX + Config.BALL_DIAMETER/2;
    var by = ball.translateY + Config.BALL_DIAMETER/2;
    var tx = this.translateX + Config.BALL_DIAMETER/2;
    var ty = this.translateY + Config.BALL_DIAMETER/2;
    var tmp = Math.sqrt(Util.square(bx-tx)+Util.square(by-ty));
    if(tmp<Config.BALL_DIAMETER){
        return true;
    }
    return false;
}
public function makeVisable(){
    this.vis = true;
}
public function makeUnvisable(){
    this.vis = false;
}
public function start(){
    setStatus(GameBall.RUNNING_STATE);
    unsetStatus(GameBall.DEAD_STATE);
    anim1.play();
    animball.start();
    //rotatetimeline.play();
}
public function restart(){
    setStatus(GameBall.RUNNING_STATE);
    unsetStatus(GameBall.DEAD_STATE);
    anim1.playFromStart();
    vis = true;
    animball.start();
    //rotatetimeline.play();
}
public function pause(){
    setStatus(GameBall.PAUSED_STATE);
    anim1.pause();
    animball.pause();
    //rotatetimeline.pause();
}
public function stop(){
    anim1.stop();
    Main.model.recycleBall(this,null);
}
public function stop(it : Object){
    anim1.stop();
    Main.model.recycleBall(this,it);
}
public function debuginfo(){
    println("status : ({statusList[0]},{statusList[1]},{statusList[2]},{statusList[3]},{statusList[4]},{statusList[5]},{statusList[6]})");
    anim1.debuginfo();
}
public function sameStatusWith(ball : ScrollBall):Boolean{
    for(index in [0..7]){
         if(not statusList[index] == ball.statusList[index]){
                return false;
         }
    }
    return true;
}
public function overredBall(ball : ScrollBall){
     return anim1.getCount() > ball.anim1.getCount();
}
public function svgCount(){
    return anim1.getCount();
}
}
