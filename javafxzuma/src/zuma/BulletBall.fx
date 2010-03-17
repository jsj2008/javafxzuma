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
public var imageIndex = Util.random(6);
var ballImage = bind Resources.ballarray[imageIndex];
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
public var tx : Number = 0;
public var ty : Number = 0;
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
        //toX: bind Main.model.getCoordx(tx,ty,dx,dy,Config.EMITTER_RANGE)-Config.BALL_DIAMETER/2 as Float
        //toY: bind Main.model.getCoordy(tx,ty,dx,dy,Config.EMITTER_RANGE)-Config.BALL_DIAMETER/2 as Float
        toX: bind Util.getCoordx(tx,ty,dx,dy,Config.EMITTER_RANGE) as Float
        toY: bind Util.getCoordy(tx,ty,dx,dy,Config.EMITTER_RANGE) as Float
        node: this
        interpolator: Interpolator.LINEAR
        duration: bind dur
        action : function () {
            state = STOPED_STATE;
            Main.model.runningbullets.remove(this);
        }
};
protected var animball = AnimBall {
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
    Main.model.playSendBulletSound();
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
public function pause(){
state = PAUSED_STATE;
move.pause();
}
public function start(){
state = RUNNING_STATE;
move.play();
}
public function stop(){
move.stop();
state = GameBall.STOPED_STATE;
vis = false;
}
public function hitmove(ball : ScrollBall,action : function(newBall : ScrollBall):Void) : ScrollBall{
        var newBall = Main.model.getNextBall(ball) as ScrollBall;
        newBall.start();
        newBall.imageIndex = imageIndex;
        newBall.rate = (ball.currentRate());
        Main.model.shiftFrom(ball);
        action(newBall);
        def hitpath = [
                MoveTo { x: translateX+Config.BALL_DIAMETER/2  y: translateY+Config.BALL_DIAMETER/2 },
                LineTo { x: newBall.translateX+Config.BALL_DIAMETER/2  y: newBall.translateY+Config.BALL_DIAMETER/2}
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
                    stop();
                    newBall.makeVisable();
                    Main.model.containsBall = newBall;
                    Main.model.findToBePurged(false,Main.model.specialEffect);
                }
        };
        hitanim.play();
        return newBall;
}
}
