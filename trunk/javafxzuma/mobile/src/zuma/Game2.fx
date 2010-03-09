/*
 * Game2.fx
 *
 * Created on Mar 5, 2010, 11:47:39 AM
 */

package zuma;

import javafx.animation.transition.FadeTransition;
import javafx.animation.transition.ParallelTransition;
import javafx.animation.transition.ScaleTransition;
import javafx.scene.Group;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.util.Math;
import zuma.components.AnimText;
import zuma.util.Util;


/**
 * @author javatest
 */

public class Game2 extends Game{
var degrees : Double= 180;
def emitter = Emitter{translateX: Main.currentData.EMITTER_X
                      translateY: Main.currentData.EMITTER_Y
                      degrees : bind degrees};
def scoreText = AnimText{visible:false};
var pointer = Pointer{opacity:0.5};
def totlescoreText = AnimText{translateX:10,translateY:20};
var backgroundbuttom = ImageView {
                translateY : 280+21
                image: Resources.background_bottom
                focusTraversable: true
                visible: true
                };
var backgroundview = ImageView {
                image: Main.currentData.background
                focusTraversable: true
                visible: true
                onMousePressed: function( e: MouseEvent ):Void {
//                    Logger.log("currentbullet is {Main.model.getCurrentBullet()}");
                    Main.model.currentbullet.dx = e.x - Config.BALL_DIAMETER/2;
                    Main.model.currentbullet.dy = e.y - Config.BALL_DIAMETER/2;
                    emitter.dx = e.x - Config.EMITTER_DIAMETER/2;
                    emitter.dy = e.y - Config.EMITTER_DIAMETER/2;
//                    Logger.log("before send, bullet is at {Main.model.getCurrentBullet().translateX} {Main.model.getCurrentBullet().translateY}");
                    Main.model.currentbullet.translate();
                    if(Main.model.runningbullets.size() >= 1){
                            Main.model.runningbullets.poll();
                    }
                    Main.model.runningbullets.add(Main.model.currentbullet);
                    emitter.hitmove();
                    Main.model.setCurrentBullet(null);
                    if(e.middleButtonDown){
                            println("--runningBalls--");
                            var count = 0;
                            for(ball in Main.model.runningBalls){
                                    count++;
                                    println("ball {count} ---------------------");
                                    (ball as ScrollBall).debuginfo();
                            }
                            println("default rate is {Main.model.defaultRate}");
                            println("sizeof runnning {Main.model.sizeofRunning()}");
                            if(detector.paused){
                                    detector.play();
                            }else{
                                    detector.pause();
                            }
                    }
                }
                onMouseMoved: function( e: MouseEvent ):Void {
                    Main.model.curx = e.x;
                    Main.model.cury = e.y;
//                    setEmitter();
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
function addScore(score : Integer):Void{
        totlescoreText.addText(score);
        progress.current = progress.current + score/10;
}
var shiftball : ScrollBall;
var initial_rate = 1;
function generBall() : Void{
       var ball = Main.model.generBall();
       if(ball == null){
               return;
       }
       ball.rate = (initial_rate);
}
override function setEmitter() {
   var deg = 270;
   emitter.translateX = Main.model.curx - Config.EMITTER_DIAMETER/2;
   var eox = Main.model.curx;
   var eoy = emitter.translateY + Config.EMITTER_DIAMETER/2;
   emitter.tx = eox;
   emitter.ty = eoy;
   var ball = Main.model.pointedball;
   //set pointer
   if(ball != null){
       var ox = ball.translateX + Config.BALL_DIAMETER/2;
       var oy = ball.translateY + Config.BALL_DIAMETER/2;
       pointer.visible = true;
       pointer.topx = Main.model.curx;
       pointer.topy = Math.sqrt(Util.square(Config.BALL_DIAMETER/2)-Util.square(Main.model.curx - ox)) + oy;
       pointer.botm_left_x = Util.getCoordxByDegree(eox,eoy, deg+10, Config.EMITTER_DIAMETER/2);
       pointer.botm_lefx_y = Util.getCoordyByDegree(eox,eoy, deg+10, Config.EMITTER_DIAMETER/2);
       pointer.botm_right_x = Util.getCoordxByDegree(eox,eoy, deg-10, Config.EMITTER_DIAMETER/2);
       pointer.botm_right_y = Util.getCoordyByDegree(eox,eoy, deg-10, Config.EMITTER_DIAMETER/2);
       pointer.genPoints();
       pointer.color = Main.model.currentbullet.imageIndex;
   }else{
       pointer.visible = false;
   }
//   var bx : Float = Util.getCoordx(Config.EMITTER_X,Config.EMITTER_Y,curx,cury, Config.EMITTER_DIAMETER/2-15);
//   var by : Float = Util.getCoordy(Config.EMITTER_X,Config.EMITTER_Y,curx,cury, Config.EMITTER_DIAMETER/2-15);
   Main.model.currentbullet.setTXY(Main.model.curx-Config.BALL_DIAMETER/2, emitter.translateY-Config.BALL_DIAMETER/2+20);
}
public var gamecontent = Group {
        translateY : 21
        content : [backgroundview,specialimageview,emitter,scoreText,pointer]
        };
public var totlecontent = [backgroundbuttom,progress,totlescoreText,gamecontent];
override public function ready():Void{
    patharray =  MapLoader.getMap(Main.currentData.PATH_DATA_FILE);
    while (sizeof Main.model.getBullets() < Config.PRE_CREATE_BULLET){
         def ball0 = BulletBall{group : gamecontent,tx : bind emitter.translateX+Config.EMITTER_DIAMETER/2-Config.BALL_DIAMETER/2,ty : bind emitter.translateY+Config.EMITTER_DIAMETER/2-Config.BALL_DIAMETER/2};
         Main.model.addBullet(ball0);
    }
    while (Main.model.sizeofRecycled() < Config.PRE_CREATE_BALL){
         def ball0 = ScrollBall{patharray : patharray};
         insert ball0 into gamecontent.content;
         insert ball0.effectplayer into gamecontent.content;
         ball0.setStatus(GameBall.DEAD_STATE);
         ball0.vis = false;
         Main.model.recycleBall(ball0,null);
    }
    while(Main.model.sizeofRecycledSpecial() < Config.PRE_CREATE_BALL_SPECIAL){
         def ball0 = SpecialScrollBall{patharray : patharray};
         insert ball0 into gamecontent.content;
         ball0.setStatus(GameBall.DEAD_STATE);
         ball0.vis = false;
         Main.model.recycleSpecial(ball0,null);
    }
    for(bullet in Main.model.getBullets()){
            bullet.rate = 1;
    }
    Main.model.setSpecialEffect(sepcialEffect);
    Main.model.setScoreUpdator(popScore,addScore);
    Main.model.detectThread = detector;
    Main.mainscene.content = totlecontent;
}
override public function start(){
    detector.play();
    ready();
}
override public function stop():Void{
    detector.stop();
    Main.mainscene.content = [];
}
override public function pause(){
    detector.pause();
}
override public function resume(){
    detector.play();
}
}
