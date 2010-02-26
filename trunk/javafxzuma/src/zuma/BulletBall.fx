/*
 * Bullet.fx
 *
 * Created on Jan 18, 2010, 4:23:46 PM
 */

package zuma;

import javafx.scene.Node;

import javafx.animation.Interpolator;
import javafx.animation.transition.TranslateTransition;
import javafx.animation.transition.AnimationPath;
import javafx.animation.transition.OrientationType;
import javafx.animation.transition.PathTransition;
import javafx.scene.shape.Path;
import javafx.scene.shape.MoveTo;
import zuma.ScrollBall;
import javafx.scene.Group;

import zuma.components.AnimBall;

import javafx.scene.shape.LineTo;

import zuma.util.Util;



/**
 * @author javatest
 */

public class BulletBall extends GameBall{
public-read var state = STOPED_STATE;
public var imageIndex = Util.random(6) on replace{
    ballImage = Resources.ballarray[imageIndex];
};
var ballImage = Resources.ballarray[imageIndex];
public var rate : Number = 1;
public var dur : Duration = Config.BULLET_DURIATION;
public var opac = 1.0;
public var vis = false on replace{
   if(vis == true){
         opac = 1.0;
         opacity = 1.0;
   }else{
         opac = 0;
         opacity = 0.0;
   }
};
public var tx = (Config.EMITTER_X - Config.BALL_DIAMETER/2);
public var ty = (Config.EMITTER_Y - Config.BALL_DIAMETER/2);
//public var tx = (Config.EMITTER_X);
//public var ty = (Config.EMITTER_Y);
override public var translateX = -100;
override public var translateY = -100;
public var dx : Float = 0;
public var dy : Float = 0;
public var rotatedegrees = 0;
public var group : Group;
init{
    insert this into group.content;
}
public def move = TranslateTransition {
        rate: bind rate
        //toX: bind Model.getCoordx(tx,ty,dx,dy,Config.EMITTER_RANGE)-Config.BALL_DIAMETER/2 as Float
        //toY: bind Model.getCoordy(tx,ty,dx,dy,Config.EMITTER_RANGE)-Config.BALL_DIAMETER/2 as Float
        toX: bind Util.getCoordx(tx,ty,dx,dy,Config.EMITTER_RANGE) as Float
        toY: bind Util.getCoordy(tx,ty,dx,dy,Config.EMITTER_RANGE) as Float
        node: this
        interpolator: Interpolator.LINEAR
        duration: bind dur
        action : function () {
            state = STOPED_STATE;
            
        }
};
var animball = AnimBall {
        ball_deameter : Config.BALL_DIAMETER
        smooth: true
        image: bind ballImage
        cache : false;
        opacity : bind opac
        rotate: bind rotatedegrees;
    };
override public function create(): Node {
        animball
}
public function translate(){
    state = RUNNING_STATE;
    this.toFront();
    move.playFromStart();
    Model.playSendBulletSound();
}
public function ready(){
    translateX = tx;
    translateY = ty;
//    Logger.log("bullet ready at {translateX} {translateY}, layoutbounds at {this.layoutBounds.minX} {this.layoutBounds.minY}");
    vis = true;
}
public function setTXY(x: Float,y : Float){
    translateX = x;
    translateY = y;
}
public function background(){
state = BACKGROUND_STATE;
vis = false;
}
public function pause(){
state = PAUSED_STATE;
move.pause();
}
public function start(){
state = RUNNING_STATE;
move.play();
}
public function hitmove(ball : ScrollBall,atEnd : function(newBall : ScrollBall):Void) : ScrollBall{
//        Logger.log("sizeof queue is {Model.sizeofRunning()}");
        var newBall = Model.getNextBall(ball) as ScrollBall;
        newBall.start();
        newBall.imageIndex = imageIndex;
        newBall.setRate(ball.currentRate());
        Model.shiftFrom(ball);
        Model.addtoRunningAt(newBall, ball);
        if(ball.isInStatus(GameBall.PAUSED_STATE)){
                newBall.setStatus(GameBall.PAUSED_STATE);
        }
        if(ball.isInStatus(GameBall.BACK_RUNNING_STATE)){
                newBall.setStatus(GameBall.BACK_RUNNING_STATE);
        }
        if(ball.isInStatus(GameBall.SHIFT_RUNNING_STATE)){
                newBall.setStatus(GameBall.SHIFT_RUNNING_STATE);
        }
        def hitpath = [
                MoveTo { x: translateX+16  y: translateY+16 },
                LineTo {x: newBall.translateX+16  y: newBall.translateY+16}
        ];
        def hittrack = Path {
                elements: hitpath
        };
        var hitanim = PathTransition {
                node: this
                path: AnimationPath.createFromPath(hittrack)
                orientation: OrientationType.ORTHOGONAL_TO_TANGENT
                interpolator: Interpolator.EASEIN
                duration: Config.BULLET_HIT_DURIATION;
                action : function () {
                    Model.stopShift();
                    background();
                    move.play();
                    newBall.makeVisable();
                    Model.containsBall = newBall;
                    Model.findToBePurged(Model.specialEffect);
                    atEnd(newBall);
                }
        };
        hitanim.play();
        return newBall;
}
}
