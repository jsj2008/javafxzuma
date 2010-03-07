/*
 * Level1.fx
 *
 * Created on Mar 4, 2010, 3:06:17 PM
 */

package zuma;


import javafx.animation.transition.FadeTransition;
import javafx.animation.transition.ParallelTransition;
import javafx.animation.transition.ScaleTransition;
import javafx.scene.Group;
import javafx.scene.image.ImageView;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;
import javafx.util.Math;
import zuma.components.AnimText;
import zuma.util.Util;
/**
 * @author javatest
 */

public class Level1 extends Level{
var degrees : Double= 90;
var curx : Double= 0;
var cury : Double= 0;
def emitter = Emitter{translateX: Level1Config.EMITTER_X - Config.EMITTER_DIAMETER/2
                      translateY: Level1Config.EMITTER_X - Config.EMITTER_DIAMETER/2
                      tx : Level1Config.EMITTER_X
                      ty : Level1Config.EMITTER_X
                      degrees : bind degrees};
def scoreText = AnimText{visible:false};
var pointer = Pointer{opacity:0.5};
def totlescoreText = AnimText{translateX:30,translateY:70};
var door = EndDoor{translateX : Level1Config.END_DOOR_X, translateY : Level1Config.END_DOOR_Y};
public-read var group: Group = Group {
            content: [
            emitter]};
var backgroundview = ImageView {
                fitHeight : Config.WINDOW_HEIGHT
                fitWidth : Config.WINDOW_WIDTH
                image: Level1Config.background
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
var initial_rate = 1;
function generBall() : Void{
       var ball = Main.model.generBall();
       if(ball == null){
               return;
       }
       ball.rate = (initial_rate);
}
function setEmitter() {
   var deg = Util.getDegrees(Level1Config.EMITTER_X,Level1Config.EMITTER_Y,curx,cury,100000000);
   degrees = deg -90;
   var ball = Main.model.getMinDegreesBall(deg,Level1Config.EMITTER_X,Level1Config.EMITTER_Y);
   //set pointer
   if(ball != null){
       var cos = Math.cos(Math.toRadians(deg));
       var sin = Math.sin(Math.toRadians(deg));
       var ox = ball.translateX + Config.BALL_DIAMETER/2 - Level1Config.EMITTER_X;
       var oy = ball.translateY + Config.BALL_DIAMETER/2 - Level1Config.EMITTER_Y;
       /*
       * r^2 - 2(cos*ox+sin*oy)r + ox^2+oy^2-r^2 = 0
       * take the lesser one
       * a = 1
       * b = -2(cos*ox+sin*oy)
       * c = ox^2 + oy ^2 - (Config.BALL_DIAMETER/2)^2
       * r = (-b - sqrt(b^2-4ac))/2a
       */
       var a = 1;
       var b = -2*(cos*ox+sin*oy);
       var c = ox*ox + oy*oy - Util.square((Config.BALL_DIAMETER/2));
       var r = (-b - Math.sqrt(b*b - 4*a*c))/2*a;
       pointer.visible = true;
       pointer.topx = r*cos + Level1Config.EMITTER_X;
       pointer.topy = r*sin + Level1Config.EMITTER_Y;
       pointer.botm_left_x = Util.getCoordxByDegree(Level1Config.EMITTER_X,Level1Config.EMITTER_Y, deg+10, Config.EMITTER_DIAMETER/2);
       pointer.botm_lefx_y = Util.getCoordyByDegree(Level1Config.EMITTER_X,Level1Config.EMITTER_Y, deg+10, Config.EMITTER_DIAMETER/2);
       pointer.botm_right_x = Util.getCoordxByDegree(Level1Config.EMITTER_X,Level1Config.EMITTER_Y, deg-10, Config.EMITTER_DIAMETER/2);
       pointer.botm_right_y = Util.getCoordyByDegree(Level1Config.EMITTER_X,Level1Config.EMITTER_Y, deg-10, Config.EMITTER_DIAMETER/2);
       pointer.genPoints();
       pointer.color = Main.model.currentbullet.imageIndex;
   }else{
       pointer.visible = false;
   }
   var bx : Float = Util.getCoordx(Level1Config.EMITTER_X,Level1Config.EMITTER_Y,curx,cury, Config.EMITTER_DIAMETER/2-15);
   var by : Float = Util.getCoordy(Level1Config.EMITTER_X,Level1Config.EMITTER_Y,curx,cury, Config.EMITTER_DIAMETER/2-15);
   Main.model.currentbullet.setTXY(bx-Config.BALL_DIAMETER/2, by-Config.BALL_DIAMETER/2);
}
public var gamecontent = [backgroundview,Resources.track,door,specialimageview,
                group,scoreText,totlescoreText,pointer
        ];
override public function ready():Void{
    patharray =  MapLoader.getMap(Level1Config.PATH_DATA_FILE);
    while (sizeof Main.model.getBullets() < Config.PRE_CREATE_BULLET){
         def ball0 = BulletBall{group : group, tx : Level1Config.EMITTER_X - Config.BALL_DIAMETER/2, ty : Level1Config.EMITTER_Y - Config.BALL_DIAMETER/2};
         Main.model.addBullet(ball0);
    }
    while (Main.model.sizeofRecycled() < Config.PRE_CREATE_BALL){
         def ball0 = ScrollBall{patharray : patharray};
//         insert ball0 into group.content;
         insert ball0.effectplayer into group.content;
         ball0.setStatus(GameBall.DEAD_STATE);
         ball0.vis = false;
         Main.model.recycleBall(ball0);
    }
    while(Main.model.sizeofRecycledSpecial() < Config.PRE_CREATE_BALL_SPECIAL){
         def ball0 = SpecialScrollBall{patharray : patharray};
//         insert ball0 into group.content;
         ball0.setStatus(GameBall.DEAD_STATE);
         ball0.vis = false;
         Main.model.recycleSpecial(ball0);
    }
    for(bullet in Main.model.getBullets()){
            bullet.rate = 1;
    }
    Main.model.setSpecialEffect(sepcialEffect);
    Main.model.setScoreUpdator(popScore,addScore);
    Main.mainscene.content = gamecontent;
    Main.model.detectThread = detector;
}
override public function start(){
    ready();
    detector.play();
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
