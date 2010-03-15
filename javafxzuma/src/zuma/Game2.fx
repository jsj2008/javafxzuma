/*
 * Game2.fx
 *
 * Created on Mar 5, 2010, 11:47:39 AM
 */

package zuma;

import javafx.scene.Group;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.util.Math;
import zuma.components.AnimText;
import zuma.util.Util;
import java.lang.Void;
import zuma.PowerBullet;



/**
 * @author javatest
 */

public class Game2 extends Game{
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
//                    if(Main.model.runningbullets.size() >= 1){
//                            Main.model.runningbullets.poll();
//                    }
                    Main.model.runningbullets.add(Main.model.currentbullet);
                    emitter.hitmove();
                    Main.model.setCurrentBullet(null);
                    if(e.middleButtonDown){
                            println("emmiter at {Main.model.curx} {Main.currentData.EMITTER_Y + Config.EMITTER_DIAMETER/2}");
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
function sepcialEffect(x : Number,y : Number,type : Integer):Void{
        var bonus = Main.model.getBonusFromRecycled();
        bonus.powerType = type;
        bonus.startx = x;
        bonus.starty = y;
        bonus.translateX = 0;
        bonus.translateY = 0;
        bonus.toFront();
        bonus.start();
//        bonus.opacity = 1;
//        bonus.translateX = 200;
//        bonus.translateY = 305;
        println("bonus {bonus.translateX} {bonus.translateY}");
        Main.model.addtoRunningBonus(bonus);
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
   Main.model.currentbullet.setTXY(Main.model.curx-Config.BALL_DIAMETER/2, emitter.translateY-Config.BALL_DIAMETER/2+5);
}
public var gamecontent = Group {
        translateY : 21
        content : [backgroundview,emitter,scoreText,pointer]
        };
public var totlecontent = [backgroundbuttom,progress,totlescoreText,gamecontent];
override public function ready():Void{
    patharray =  MapLoader.getMap(Main.currentData.PATH_DATA_FILE);
    while (sizeof Main.model.bullets < Config.PRE_CREATE_BULLET){
         def ball0 = BulletBall{group : gamecontent,tx : bind emitter.translateX+Config.EMITTER_DIAMETER/2-Config.BALL_DIAMETER/2,ty : bind emitter.translateY+Config.EMITTER_DIAMETER/2-Config.BALL_DIAMETER/2};
         Main.model.addBullet(ball0);
    }
    while (sizeof Main.model.powerBullets < Config.PRE_CREATE_SPEAR){
         def ball0 = PowerBullet{group : gamecontent,tx : bind emitter.translateX+Config.EMITTER_DIAMETER/2-Config.BALL_DIAMETER/2,ty : bind emitter.translateY+Config.EMITTER_DIAMETER/2-Config.BALL_DIAMETER/2};
         Main.model.addPowerBullet(ball0);
    }
    while (Main.model.sizeofRecycledBonus() < Config.PRE_CREATE_BONUS){
         def bonus = Bonus{group : gamecontent};
         Main.model.recycleBonus(bonus);
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
    for(bullet in Main.model.bullets){
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
