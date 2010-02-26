/*
 * Main.fx
 *
 * Created on Jan 13, 2010, 11:17:31 AM
 */

package zuma;

import javafx.animation.Timeline;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.Group;
import javafx.animation.KeyFrame;
import javafx.scene.Scene;
import javafx.stage.Stage;
import zuma.BulletBall;
import zuma.Resources;
import zuma.ScrollBall;
import zuma.Model;

import javafx.animation.transition.FadeTransition;
import javafx.animation.transition.ParallelTransition;
import javafx.animation.transition.ScaleTransition;

import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;

import zuma.util.Util;
import zuma.components.AnimText;

import javafx.util.Math;

/**
 * @author javatest
 */

var degrees : Double= 90;
var curx : Double= 0;
var cury : Double= 0;
//def eh : Thread.UncaughtExceptionHandler = Thread.UncaughtExceptionHandler{
//                        var defaultUncaughtExceptionHandler;
//                        function init() {
//                            defaultUncaughtExceptionHandler = Thread.getDefaultUncaughtExceptionHandler();
//                        }
//                        override function uncaughtException(t : Thread , e : Throwable) {
//                             e.printStackTrace();
//                        }
//                        };
def emitter = Emitter{translateX: Config.EMITTER_X - Config.EMITTER_DIAMETER/2
                      translateY: Config.EMITTER_X - Config.EMITTER_DIAMETER/2
                      degrees : bind degrees};
def scoreText = AnimText{visible:false};
var pointer = Pointer{opacity:0.5};
def totlescoreText = AnimText{translateX:30,translateY:70};
var door = EndDoor{translateX : Config.END_DOOR_X, translateY : Config.END_DOOR_Y};
var group: Group = Group {
            content: [
            emitter]};

var backgroundview = ImageView {
                fitHeight : Config.WINDOW_HEIGHT
                fitWidth : Config.WINDOW_WIDTH
                image: Resources.background
                focusTraversable: true
                visible: true
                onMousePressed: function( e: MouseEvent ):Void {
//                    Logger.log("currentbullet is {Model.getCurrentBullet()}");
                    Model.getCurrentBullet().dx = e.x - Config.BALL_DIAMETER/2;
                    Model.getCurrentBullet().dy = e.y - Config.BALL_DIAMETER/2;
                    emitter.dx = e.x - Config.EMITTER_DIAMETER/2;
                    emitter.dy = e.y - Config.EMITTER_DIAMETER/2;
//                    Logger.log("before send, bullet is at {Model.getCurrentBullet().translateX} {Model.getCurrentBullet().translateY}");
                    Model.getCurrentBullet().translate();
                    emitter.hitmove();
                    Model.setCurrentBullet(null);

                }
                onMouseMoved: function( e: MouseEvent ):Void {
                    curx = e.x;
                    cury = e.y;
                    setEmitter();
                }
                //debug
                onKeyPressed: function( e: KeyEvent ):Void {
                    if(e.code == KeyCode.VK_ENTER){
                            println("--runningBalls--");
                            for(ball in Model.runningBalls){
                                    (ball as ScrollBall).debuginfo();
                            }
                            println("default rate is {Model.defaultRate}");
                    }
                }
}
def specialimageview = ImageView {
        fitWidth : Config.BALL_DIAMETER
        fitHeight : Config.BALL_DIAMETER
        translateX :  -100
        translateY :  -100
        image: Resources.specialEffectImage[0];
        cache : false
        opacity : 0
};
var specialparTransition = ParallelTransition {
        node: specialimageview
        content: [
            FadeTransition { duration: 0.8s fromValue:0.0  toValue: 1.0
                },
            ScaleTransition { duration: 1s fromX : 1 fromY : 1 byX: 4.5 byY: 4.5
                },
        ]
        action : function(){
            specialimageview.opacity = 0;
        }
}
function sepcialEffect(x : Number,y : Number,type : Integer){
        specialimageview.translateX = x;
        specialimageview.translateY = y;
        specialimageview.image = Resources.specialEffectImage[type];
        specialimageview.toFront();
        specialparTransition.playFromStart();
}
function popScore(x : Number,y : Number,score : Integer,color : Integer){
        scoreText.translateX = x;
        scoreText.translateY = y;
        scoreText.setUpText("+{score}", color);
}
function addScore(score : Integer){
        totlescoreText.addText(score);
}
var shiftball : ScrollBall;
def detector = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames : [
            KeyFrame {
                time: Config.DETECTOR_FREQUENCY
                action: function () {
                    Model.specialEffectCount();
                    Model.generBall();
                    if(Model.sizeofRunning() == 0){
                        generBall();
                    }
                    if(Model.sizeofRunning() == 10 and Model.defaultRate == Config.INITIAL_RATE){
                                Model.restoreAllRunning();
                                Model.startBulletGenor();
                                Model.setDefaultRate(Config.RUNNING_RATE);
                    }
                    if(Model.ending){
                            door.open();
                    }
                    if(Model.ended()){
                            door.close();
                    }
                    Model.restoreRateWhenAllPaused();
                    Model.stopShift();
                    Model.stopBack();
                    Model.stopPause();
                    Model.dectectHit();
                    
                }
            }
        ]
}
var initial_rate = 1;
function generBall() : Void{
       var ball = Model.generBall();
       if(ball == null){
               return;
       }
       ball.setRate(initial_rate);
}
function setEmitter() {
   var deg = Util.getDegrees(Config.EMITTER_X,Config.EMITTER_Y,curx,cury,100000000);
   degrees = deg -90;
   var ball = Model.getMinDegreesBall(deg);
   //set pointer
   if(ball != null){
       var cos = Math.cos(Math.toRadians(deg));
       var sin = Math.sin(Math.toRadians(deg));
       var ox = ball.translateX + Config.BALL_DIAMETER/2 - Config.EMITTER_X;
       var oy = ball.translateY + Config.BALL_DIAMETER/2 - Config.EMITTER_Y;
       //r^2 - 2(cos*ox+sin*oy)r + ox^2+oy^2-r^2 = 0
       //take the lesser one
       // a = 1
       // b = -2(cos*ox+sin*oy)
       // c = ox^2 + oy ^2 - (Config.BALL_DIAMETER/2)^2
       // r = (-b - sqrt(b^2-4ac))/2a
       var a = 1;
       var b = -2*(cos*ox+sin*oy);
       var c = ox*ox + oy*oy - Util.square((Config.BALL_DIAMETER/2));
       var r = (-b - Math.sqrt(b*b - 4*a*c))/2*a;
       pointer.visible = true;
       pointer.topx = r*cos + Config.EMITTER_X;
       pointer.topy = r*sin + Config.EMITTER_Y;
       pointer.botm_left_x = Util.getCoordxByDegree(Config.EMITTER_X,Config.EMITTER_Y, deg+10, Config.EMITTER_DIAMETER/2);
       pointer.botm_lefx_y = Util.getCoordyByDegree(Config.EMITTER_X,Config.EMITTER_Y, deg+10, Config.EMITTER_DIAMETER/2);
       pointer.botm_right_x = Util.getCoordxByDegree(Config.EMITTER_X,Config.EMITTER_Y, deg-10, Config.EMITTER_DIAMETER/2);
       pointer.botm_right_y = Util.getCoordyByDegree(Config.EMITTER_X,Config.EMITTER_Y, deg-10, Config.EMITTER_DIAMETER/2);
       pointer.genPoints();
   }else{
       pointer.visible = false;
   }
   var bx : Float = Util.getCoordx(Config.EMITTER_X,Config.EMITTER_Y,curx,cury, Config.EMITTER_DIAMETER/2-15);
   var by : Float = Util.getCoordy(Config.EMITTER_X,Config.EMITTER_Y,curx,cury, Config.EMITTER_DIAMETER/2-15);
   Model.getCurrentBullet().setTXY(bx-Config.BALL_DIAMETER/2, by-Config.BALL_DIAMETER/2);
}
function startgame(){
//    Thread.setDefaultUncaughtExceptionHandler(eh);
    Model.setSpecialEffect(sepcialEffect);
    Model.setScoreUpdator(popScore,addScore);
    while (sizeof Model.getBullets() < Config.PRE_CREATE_BULLET){
         def ball0 = BulletBall{group : group};
         Model.addBullet(ball0);
    }
//    Model.setCurrentBullet();
    while (Model.sizeofRecycled() < Config.PRE_CREATE_BALL){
         def ball0 = ScrollBall{};
         insert ball0 into group.content;
         ball0.setStatus(GameBall.DEAD_STATE);
         ball0.vis = false;
         Model.recycleBall(ball0);
    }
    while(Model.sizeofRecycledSpecial() < Config.PRE_CREATE_BALL_SPECIAL){
         def ball0 = SpecialScrollBall{};
         insert ball0 into group.content;
         ball0.setStatus(GameBall.DEAD_STATE);
         ball0.vis = false;
         Model.recycleSpecial(ball0);
    }
    for(bullet in Model.getBullets()){
            bullet.rate = 1;
    }
    detector.play();
}
Stage {
    title: "JavaFX Zuma"
    width: Config.WINDOW_WIDTH+15
    height: Config.WINDOW_HEIGHT+35
    scene: Scene {
        content: [backgroundview,Resources.track,door,specialimageview,
                group,scoreText,totlescoreText,pointer
        ]
    }
}
startgame();