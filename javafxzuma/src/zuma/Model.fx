/*
 * Model.fx
 *
 * Created on Jan 14, 2010, 5:40:49 PM
 */

package zuma;

/**
 * @author javatest
 */
import javafx.util.Math;
import java.util.Stack;
import java.util.LinkedList;
import java.util.Iterator;


import zuma.util.Util;
import zuma.SpecialScrollBall;


import zuma.components.Schedulable;
import java.util.ListIterator;

import javafx.animation.Timeline;

import zuma.GameBall;

import java.util.Collections;

public class Model {
//public var lastGenered : ScrollBall = null;
public var containsBall : ScrollBall = null;
public-read var runningBalls : LinkedList = new LinkedList();
public-read var runningBonus : LinkedList = new LinkedList();
public var runningbullets : LinkedList =  new LinkedList();
//purge special ball listener
public-read var specialEffect : function(x : Number,y : Number,type : Integer);
//score changed listener
public-read var popScore : function(x : Number,y : Number,score : Integer,color : Integer);
public-read var addScore : function(score : Integer);
public var ending = false;
public var sucess = false;
public var detectThread : Timeline;
//x and y of cursor
public var curx : Double= 0;
public var cury : Double= 0;
//the ball the pointer currently pointed
public var pointedball : ScrollBall;
public-read var hitmoving : Boolean = false;
public-read var pauseing : Boolean = false;
var hitmoveneedstop : Boolean = false;
var hitmovecheckcount : Integer = Config.HIT_MOVE_CHECK_COUNT;
var dohitmove : Boolean = false;
var backing : Boolean = false;
var backinghead : ScrollBall;
var shifting : Boolean = false;
var shiftinghead : ScrollBall;
var recycled : Stack = new Stack();
var recycledSpecial : Stack = new Stack();
var recycledBonus : Stack = new Stack();
public-read var bullets : BulletBall[]= [];
public-read var powerBullets : PowerBullet[] = [];
public var currentPower = 0;
var currentHitMovingRate : Integer;
var currentHitMovingT : Integer;
public var currentbullet : BulletBall;
var bullet_stop = true;
public var generedBall = 0;
var specialeffect_counter = 0 on replace oldvalue{
};
var hitsound = Sound{fileName:Resources.ballclick_sound};
var hitsound2 = Sound{fileName:Resources.ballclick_sound_2};
var purgesound = Sound{fileName:Resources.purge_sound};
var rollingsound = Sound{fileName:Resources.rolling_sound};
var sendbulletsound = Sound{fileName:Resources.send_bullet_sound};
var doorswitchsound = Sound{fileName:Resources.switch_door_sound};
public var defaultRate = Main.currentData.INITIAL_RATE on replace oldvalue{
    applyToAll(function(ball : ScrollBall):Boolean{
        if(not ball.isInStatus(GameBall.PAUSED_STATE)){
            ball.rate = (defaultRate);
        }
        return false;
    });
};
public var generedoffset = Config.INITIAL_OFFSET;
/*
*  private functions ---------------------------------------------------------------------------------------------
*/
function rebuild(ball : ScrollBall,it : Object){
    ball.imageIndex = Util.random(6);
    ball.fromIndex = 0;
    ball.translateX = -100;
    ball.translateY = -100;
    ball.vis = false;
    ball.scaleX = 1;
    ball.scaleY = 1;
    ball.stopped = false;
    ball.clearStatus();
    if(it != null){
        delfromRunning(it as Iterator);
    }else{
        delfromRunning(ball);
    }
    return ball;
}
function effectAction(effect : Integer):Void{
    if(effect == SpecialScrollBall.SPECIAL_ACCURACY){
            return;
    }
    if(effect == SpecialScrollBall.SPECIAL_SLOW){
            return;
    }
        if(effect == SpecialScrollBall.SPECIAL_BACK){
            return;
    }
    if(effect == SpecialScrollBall.SPECIAL_BOM){
            return;
    }
}
function applyToPausedBall(action : function(ball:ScrollBall):Boolean){
    applyToRunningBy(GameBall.PAUSED_STATE,action);
}
function applyToShiftBall(action : function(ball:ScrollBall):Boolean){
    applyToRunningBy(GameBall.SHIFT_RUNNING_STATE, action);
}
function applyToBackBall(action : function(ball:ScrollBall):Boolean){
    applyToRunningBy(GameBall.BACK_RUNNING_STATE, action);
}
function applyToRunningBy(status : Integer,action : function(ball:ScrollBall):Boolean){
    applyToAll(function(ball : ScrollBall):Boolean{
        if((ball as ScrollBall).isInStatus(status)){
                if(action(ball as ScrollBall)){
                    return true;
                }
        }
        return false;
    });
}
function getHeadOfShift(){
    for(ball in runningBalls){
        if((ball as ScrollBall).isInStatus(GameBall.SHIFT_RUNNING_STATE)){
                return ball;
        }
    }
    return null;
}
function applyToAll(action : function(ball:ScrollBall):Boolean){
    for(ball in runningBalls){
            if(action(ball as ScrollBall)){
                break;
            }
    }
}
function backHitted(){
        if(not backing){
                return false;
        }
//        var backhead = getHeadOfBacking();
//        if(backhead == null){
//             return false;
//        }
        var index = runningBalls.indexOf(backinghead);
        if(index <= 0){
            return false;
        }
        var backhitBall = runningBalls.get(index - 1) as GameBall;
        if(hitted(backinghead as ScrollBall,backhitBall,Config.BACK_OFFSET)){
                playHitSound2();
                return true;
        }
        return false;
}
function getHeadOfBacking(){
    for(ball in runningBalls){
            if((ball as ScrollBall).isInStatus(GameBall.BACK_RUNNING_STATE)){
                    return ball;
            }
    }
    return null;
}
function pauseRunningBall(fromBall : ScrollBall){
    var index = runningBalls.indexOf(fromBall);
    if(index < 0 or index == runningBalls.size()){
         return;
    }
    var iter : Iterator = runningBalls.iterator();
    var counter = 0;
    var tmpball : ScrollBall;
    while(iter.hasNext()){
        tmpball = iter.next() as ScrollBall;
        if(counter >= index){
//             Logger.log("back change rate : {counter} of runningballs sizeof {balls.size()}");
             tmpball.rate = (Config.PAUSED_STOPPED_RATE);
//             pausecount++;
        }
        counter ++;
    }
}
function getHeadOfPaused(){
    for(ball in runningBalls){
            if((ball as ScrollBall).isInStatus(GameBall.PAUSED_STATE)){
                    return ball;
            }
    }
    return null;
}
function currentImageIndexs(){
    var tmp = [0,0,0,0,0,0];
    for(ball in runningBalls){
        tmp[(ball as ScrollBall).imageIndex]++;
    }
    var it = 0;
    var tmp1 : Integer[]= [];
    for(index in tmp){
        if(not(index == 0)){
            insert it into tmp1;
        }
        it++;
    }
    return tmp1;
}
function getNextIndex(ball : ScrollBall){
     var x = (ball.translateX as Float);
     var y = (ball.translateY as Float);
     var n = 0;
     var it: Iterator = (Main.ui as Game).patharray.iterator();
     //Logger.log(Resources.patharray.indexOf(x));
     var fromindex = -1;
     var newindex = 0;
     var tmpx : Float= 0;
     var tmpy : Float= 0;
     while(it.hasNext()){
        tmpx = it.next() as Float;
        tmpy = it.next() as Float;
        it.next();
        //Logger.log("check {tmpx} {tmpy}");
        if((tmpx == x) and (tmpy == y) and (fromindex == -1)){
//            Logger.log("this ball reached {n} at {x} {y}");
            fromindex = n;
        }
        if(not (fromindex == -1) and getDistance(x,y,tmpx,tmpy) >= Config.BALL_DIAMETER){
            newindex = n;
//            Logger.log("next ball is from {n} at {tmpx} {tmpy}");
            break;
        }
        n++;
     };
     return newindex;
}
/*
* play sound functions ---------------------------------------------------------------
*/
public function playHitSound(){
    hitsound.play();
}
public function playHitSound2(){
    hitsound2.play();
}
public function playPurgeSound(){
    purgesound.play();
}
public function playRollingSound(){
    rollingsound.play();
}
public function stopRollingSound(){
    rollingsound.stop();
}
public function playSendBulletSound(){
    sendbulletsound.play();
}
public function playDoorSwitchSound(){
    doorswitchsound.play();
}
/*
*   useful public functions
*/
public function specialEffectBegin(){
    specialeffect_counter = Config.SPECIALL_DUR_COUNT;
}
public function specialEffectCount(){
    if(specialeffect_counter == 0){
            return;
    }
    specialeffect_counter--;
}
public function setSpecialEffect(spec : function(x : Number,y : Number,type : Integer)){
        specialEffect = spec;
}
public function setScoreUpdator(pc : function(x : Number,y : Number,score : Integer,color : Integer),
                                ac : function(score : Integer)){
        popScore = pc;
        addScore = ac;
}
public function reGenerBall(){
        defaultRate = Main.currentData.INITIAL_RATE;
        generedBall = 0;
//        lastGenered = null;
}
public function stopGenerBall(){
        generedBall = 100000;
}
public function generBall() : ScrollBall{
       if(generedBall == 0){
               playRollingSound();
       }
       if(generedBall > Main.currentData.max_ball or sucess or ending or hitmoving){
               return null;
       }
       if(runningBalls.size() > 0){
           var lastGenered = (runningBalls as LinkedList).getFirst() as ScrollBall;
           var ox = (Main.ui as Game).patharray.get(0) as Float;
           var oy = (Main.ui as Game).patharray.get(1) as Float;
           var x = (lastGenered.translateX as Float);
           var y = (lastGenered.translateY as Float);
           if(x < 0 and y < 0){
                   return null;
           }
           var dist = getDistance(ox,oy,x,y) - (Config.BALL_DIAMETER);
           if((not (lastGenered == null)) and dist < -generedoffset){
                return null;
           }
       }
        //Logger.log("ball generating ...");
       var newBall = Model.getBallOrSpecialFromRecycled();
       newBall.restart();
       generedBall++;
       Model.addtoRunningTail(newBall);
       newBall.makeVisable();
       newBall.rate = (defaultRate);
       return  newBall;
}
public function endingRunning(){
    for(ball in runningBalls){
        (ball as ScrollBall).rate = (Config.END_RATE);
    }
}
public function ended(){
    return false;
}
public function getNextBall(ball : ScrollBall){
     var newball = getBallFromRecycled();
     var x = (ball.translateX as Float);
     var y = (ball.translateY as Float);
     var n = 0;
     var it: Iterator = (Main.ui as Game).patharray.iterator();
     //Logger.log(Resources.patharray.indexOf(x));
     var fromindex = -1;
     var newindex = 0;
     var tmpx : Float= 0;
     var tmpy : Float= 0;
     while(it.hasNext()){
        tmpx = it.next() as Float;
        tmpy = it.next() as Float;
        it.next();
        //Logger.log("check {tmpx} {tmpy}");
        if((tmpx == x) and (tmpy == y) and (fromindex == -1)){
//            Logger.log("this ball reached {n} at {x} {y}");
            fromindex = n;
        }
        if(not (fromindex == -1) and getDistance(x,y,tmpx,tmpy) >= Config.BALL_DIAMETER){
            newindex = n;
//            Logger.log("next ball is from {n} at {tmpx} {tmpy}");
            break;
        }
        n++;
     };

     newball.fromIndex = newindex;
     newball.translateX = tmpx;
     newball.translateY = tmpy;
//     newball.rate = (ball.currentRate());
//     if(ball.isInStatus(GameBall.PAUSED_STATE)){
//         pausecount++;
//     }
     return newball;
}
public function getMinDegreesBall(degreens : Number, ox : Number, oy : Number):ScrollBall{
    var rtn : ScrollBall;
    var mindeg : Number = 360;
    var mindist : Number = 10000;
    applyToAll(function(ball : ScrollBall):Boolean{
        var deg = Util.getDegrees(ox,oy, ball.translateX+Config.BALL_DIAMETER/2, ball.translateY+Config.BALL_DIAMETER/2, 100000);
        if(Math.abs(deg - degreens) < mindeg){
            mindeg = Math.abs(deg - degreens);
            rtn = ball;
        }
        return false;
    });
    if(mindeg > 5){
//            return null;
    }
    return rtn;
}
public function isInRunningQueue(ball){
    return (runningBalls as LinkedList).contains(ball);
}
public function getCurrentBullet(){
    return currentbullet;
}
public function setCurrentBullet() : Void{
    if(bullet_stop){
        return;
    }
    if(not (currentbullet == null)){
        return;
    }
    if(specialeffect_counter > 0){
        setPowerBullet(currentPower);
    }else{
        for(bullet in bullets){
                        if(bullet.state == GameBall.STOPED_STATE){
    //                        Logger.log("reuse bullet {bullet}");
                            setCurrentBullet(bullet);
                            if(runningBalls.size() <= 5){

                            }
                            var tmp = currentImageIndexs();
                            bullet.imageIndex = tmp[Util.random(sizeof tmp)] as Integer;
                            Model.getCurrentBullet().ready();
                            break;
                        }
         }
    }
}
public function setPowerBullet(type : Integer):Void{
    if(bullet_stop){
        return;
    }
    if(not (currentbullet == null)){
        currentbullet.stop();
    }
    for(bullet in powerBullets){
                    if(bullet.state == GameBall.STOPED_STATE){
//                        Logger.log("reuse bullet {bullet}");
                        bullet.powerIndex = type;
                        setCurrentBullet(bullet);
                        currentbullet.ready();
                        break;
                    }
     }
}
public function stopBulletGenor(){
    bullet_stop = true;
}
public function startBulletGenor(){
    bullet_stop = false;
    setCurrentBullet();
}
public function purgeManaully(){
    println("purge manaully and contains is {containsBall}");
    findToBePurged(false,specialEffect);
}
public function setCurrentBullet(bullet : BulletBall){
    currentbullet = bullet;
}
public function addBullet(bullet : BulletBall){
    insert bullet into bullets;
}
public function addPowerBullet(bullet : PowerBullet){
    insert bullet into powerBullets;
}
public function addtoRunningHead(ball : ScrollBall){
    if(ball == null){
//          Logger.log("will not add null to queue");
          return;
    }
    Logger.log("add {ball} to quque : {runningBalls.offer(ball)} at {(runningBalls as LinkedList).indexOf(ball)}");
}
public function addtoRunningTail(ball : ScrollBall){
    (runningBalls as LinkedList).addFirst(ball);
//    Logger.log("add {ball} to quque : at {(balls as LinkedList).indexOf(ball)}");
}
public function addtoRunningBonus(bonus : Bonus){
     runningBonus.add(bonus);
}
public function addtoRunningAt(ball : ScrollBall,fromball : GameBall){
    var index = (Model.runningBalls as LinkedList).indexOf(fromball)+1;
    (runningBalls as LinkedList).add(index,ball);
//    Logger.log("add {ball} to quque : at {(balls as LinkedList).indexOf(ball)}");
}
public function delfromRunning(ball : ScrollBall){
    runningBalls.remove(ball);
}
public function delfromRunning(iterator : Iterator){
        iterator.remove();
}
public function getRunningBallAt(index : Number){
    return (runningBalls as LinkedList).get(index) as ScrollBall;
}
public function getBallFromRecycled(){
    if(recycled.isEmpty()){
//         def ball0 = ScrollBall{patharray : (Main.ui as Game).patharray};
//         insert ball0 into (Main.ui as Game).gamecontent.content;
//         insert ball0.effectplayer into (Main.ui as Game).gamecontent.content;
//         ball0.setStatus(GameBall.DEAD_STATE);
//         ball0.vis = false;
//         Main.model.recycleBall(ball0,null);
    }
    var ball = recycled.pop() as ScrollBall;
//    Logger.log("get {ball} from recycled");
    return ball;
}
public function getSpecialBallRromRecycled(){
    if(recycledSpecial.isEmpty()){
//         def ball0 = ScrollBall{patharray : (Main.ui as Game).patharray};
//         insert ball0 into (Main.ui as Game).gamecontent.content;
//         insert ball0.effectplayer into (Main.ui as Game).gamecontent.content;
//         ball0.setStatus(GameBall.DEAD_STATE);
//         ball0.vis = false;
//         Main.model.recycleBall(ball0,null);
    }
    var ball = recycledSpecial.pop() as ScrollBall;
//    Logger.log("get {ball} from recycledSpecial");
    return ball;
}
public function getBonusFromRecycled(){
    var bonus = recycledBonus.pop() as Bonus;
    return bonus;
}
public function getBallOrSpecialFromRecycled(){
    var tmp = Util.random(100);
     var newball;
     if(tmp > (100 - Config.SPECILA_PERCENTAGE)){
         newball = getSpecialBallRromRecycled();
     }else{
         newball = getBallFromRecycled();
     }
     return newball;
}
public function sizeofRecycled(){
    return recycled.size();
}
public function sizeofRecycledSpecial(){
    return recycledSpecial.size();
}
public function sizeofRecycledBonus(){
    return recycledBonus.size();
}
public function sizeofRunning(){
    return runningBalls.size();
}
public function recycleBall(ball : ScrollBall,object : Object){
    recycled.push(rebuild((ball as ScrollBall),object));
}
public function recycleSpecial(ball : ScrollBall,object : Object){
    recycledSpecial.push(rebuild((ball as ScrollBall),object));
}
public function recycleBonus(bonus : Bonus){
    bonus.stop();
    recycledBonus.push(bonus);
}
public function isRecycledEmpty(){
    return recycled.isEmpty() and recycledSpecial.isEmpty();
}
/*
*   Hit detection functions ---------------------------------------------------------------------------------
*/
public function hitted(ball : GameBall,ball0 : GameBall){
        var bx = ball.translateX + Config.BALL_DIAMETER/2;
        var by = ball.translateY + Config.BALL_DIAMETER/2;
        var b0x = ball0.translateX + Config.BALL_DIAMETER/2;
        var b0y = ball0.translateY + Config.BALL_DIAMETER/2;
        if(Math.sqrt(Util.square(bx-b0x)+Util.square(by-b0y))-Config.BALL_DIAMETER<=0){
            return true;
        }
        return false;
}
public function hitted(ball : GameBall,ball0 : GameBall,offset : Integer){
        var bx = ball.translateX + Config.BALL_DIAMETER/2;
        var by = ball.translateY + Config.BALL_DIAMETER/2;
        var b0x = ball0.translateX + Config.BALL_DIAMETER/2;
        var b0y = ball0.translateY + Config.BALL_DIAMETER/2;
        if(Math.sqrt(Util.square(bx-b0x)+Util.square(by-b0y))-Config.BALL_DIAMETER<=offset){
            return true;
        }
        return false;
}
public function getDistance(x0 : Number,y0 : Number,x1: Number,y1: Number){
        return Math.sqrt(Util.square(x0-x1)+Util.square(y0-y1))
}
/*
*   main status management functions ----------------------------------------------------------------------------------
*/
public function findToBePurged(hitmove : Boolean ,sepcialEffect : function(x : Number,y : Number,type : Integer):Void):GameBall{
    if(containsBall == null){
            Logger.log("contains is {containsBall}");
            return null
    }
    var counter = 0;
    var sum = 1;
    var lastIndex = -1;
    var readyToBreak = false;
    var containsHitted = false;
    for(ball in Model.runningBalls){
        if(ball == containsBall){
            containsHitted = true;
        }
        if((ball as ScrollBall).imageIndex == lastIndex){
            sum++;
        }else{
            if(readyToBreak){
                break;
            }
            lastIndex = (ball as ScrollBall).imageIndex;
            sum = 1;
            containsHitted = (ball == containsBall);
            readyToBreak = false;
        }
        if(sum >= 3 and containsHitted){
            Logger.log("sum is {sum} and contains {containsHitted}");
            readyToBreak = true;
        }
        counter++;
    }
    if(sum < 3){
        return null;
    }
    if(not containsHitted){
        return null;
    }
    Logger.log("found {sum} balls to be purged");

    var temparray : ScrollBall[];
    var hitat = counter - sum -1;
    var backfrom = counter;
    var backfromBall;
    var hittedBall;
    if((hitat >= 0 and hitat < Model.sizeofRunning()) and (backfrom >= 0 and backfrom < Model.sizeofRunning())){
        backfromBall = runningBalls.get(backfrom) as ScrollBall;
        hittedBall = runningBalls.get(hitat) as ScrollBall;
    }
    var t_add = 10*sum;
    while(sum > 0){
        sum--;
        counter--;
        var pball = Model.getRunningBallAt(counter);
        if(pball instanceof SpecialScrollBall){
                sepcialEffect(pball.translateX,pball.translateY,(pball as SpecialScrollBall).SPECIAL_TYPE);

        }
        popScore(pball.translateX,pball.translateY,t_add,(pball.imageIndex));
        addScore(10);
        playPurgeSound();
        pball.ScalingAndUnvisable();
        insert pball into temparray;
    }
    for(pball in temparray){
        pball.stop();
    }
    if(hittedBall == null or backfromBall == null){
            return null;
    }
    if((hittedBall).imageIndex == (backfromBall).imageIndex){
        Model.backRunningBall(backfromBall);
    }else{
        if((not (getHeadOfPaused() == null)) or (not(backfromBall == null) and not backfromBall.isInStatus(GameBall.PAUSED_STATE))){
            Model.pauseRunningBall(backfromBall);
            if(hitmove){
                hitMovingBall(hittedBall as ScrollBall);
            }
        }
    }
    containsBall = null;
    return hittedBall;
}
public function stopShift():Void{
     if(not shifting){
             return;
     }
     var indexOfShift = runningBalls.indexOf(shiftinghead);
     //when all balls are shifting
     if(indexOfShift <=0){
        applyToShiftBall(function(ball : ScrollBall):Boolean{
            ball.rate = (Config.RUNNING_RATE);
            ball.unsetStatus(GameBall.PAUSED_STATE);
            ball.unsetStatus(GameBall.SHIFT_RUNNING_STATE);
            ball.unsetStatus(GameBall.BACK_RUNNING_STATE);
            return false;
        });
        return;
     }
     var newBall = runningBalls.get(indexOfShift-1);
//     if((newBall as ScrollBall).isInStatus(GameBall.SHIFT_RUNNING_STATE)){
//            for(ball in runningBalls){
//                if((ball as ScrollBall).isInStatus(GameBall.SHIFT_RUNNING_STATE)){
//                    (ball as ScrollBall).unsetStatus(GameBall.SHIFT_RUNNING_STATE);
//                    (ball as ScrollBall).rate = (defaultRate);
//                    //restore the rate,backrunning has a higher priority
//                    if((ball as ScrollBall).isInStatus(GameBall.PAUSED_STATE)){
//                        (ball as ScrollBall).rate = (Config.PAUSED_STOPPED_RATE);
//                    }
//                    if((ball as ScrollBall).isInStatus(GameBall.BACK_RUNNING_STATE)){
//                        (ball as ScrollBall).rate =(Config.BACK_RATE);
//                    }
//                }
//            }
//            return;
//     }
     var ox = (newBall as ScrollBall).translateX;
     var oy = (newBall as ScrollBall).translateY;
     var x = shiftinghead.translateX;
     var y = shiftinghead.translateY;
     //shiftting balls have reached the position.
     if(getDistance(ox,oy,x,y) + Config.SHIFT_OFFSET > Config.BALL_DIAMETER){
            for(ball in runningBalls){
                if((ball as ScrollBall).isInStatus(GameBall.SHIFT_RUNNING_STATE)){
                    (ball as ScrollBall).unsetStatus(GameBall.SHIFT_RUNNING_STATE);
                    (ball as ScrollBall).rate = (defaultRate);
                    //restore the rate,backrunning has a higher priority
                    if((ball as ScrollBall).isInStatus(GameBall.PAUSED_STATE)){
                        (ball as ScrollBall).rate = (Config.PAUSED_STOPPED_RATE);
                    }
                    if((ball as ScrollBall).isInStatus(GameBall.BACK_RUNNING_STATE)){
                        (ball as ScrollBall).rate =(Config.BACK_RATE);
                    }
                }
            }
     }
}
public function stopBack():Void{
    if(not backHitted()){
           return;
    }
    for(ball in runningBalls){
         if((ball as ScrollBall).isInStatus(GameBall.BACK_RUNNING_STATE)){
            (ball as ScrollBall).unsetStatus(GameBall.BACK_RUNNING_STATE);
            (ball as ScrollBall).rate = (defaultRate);
            //restore rate,shiftrunning has higher priority
            if((ball as ScrollBall).isInStatus(GameBall.PAUSED_STATE)){
                (ball as ScrollBall).rate = (Config.PAUSED_STOPPED_RATE);
            }
            if((ball as ScrollBall).isInStatus(GameBall.SHIFT_RUNNING_STATE)){
                (ball as ScrollBall).rate = (Config.SHIFT_RATE);
            }
         }
    }
    containsBall = backinghead as ScrollBall;
    var hittedBall = Model.findToBePurged(true,specialEffect);
    if(hittedBall != null){
//        hitMovingBall(hittedBall as ScrollBall);
//        setDefaultRate(Config.PAUSED_STOPPED_RATE);
//        specialeffect_counter = 50;
//        specialEffectBegin();
    }else{
        hitMovingBall(null);
//        setDefaultRate(Config.PAUSED_STOPPED_RATE);
//        specialeffect_counter = 25;
//        specialEffectBegin();
    }
}
public function stopHitMove():Void{
    if(not hitmoving){
            return;
    }
    if(hitmovecheckcount != 0){
            hitmovecheckcount--;
            return;
    }
    println("hitmove rat at {Config.HIT_MOVE_RATE + Config.HIT_MOVE_G*currentHitMovingT}");
    hitmovecheckcount = Config.HIT_MOVE_CHECK_COUNT;
    Collections.reverse(runningBalls);
    var lastball : ScrollBall;
    for(ball in runningBalls){
         //join to hitmove
         if(not (ball as ScrollBall).isInStatus(GameBall.HIT_MOVING_STATE) and
                    lastball != null and
                    lastball.isInStatus(GameBall.HIT_MOVING_STATE) and
                    hitted(lastball as ScrollBall,ball as ScrollBall)){
                    (ball as ScrollBall).setStatus(GameBall.HIT_MOVING_STATE);
                    (ball as ScrollBall).rate = lastball.rate;
                    continue;
         }
         if((ball as ScrollBall).isInStatus(GameBall.HIT_MOVING_STATE)){
            if(hitmoveneedstop){
                (ball as ScrollBall).unsetStatus(GameBall.HIT_MOVING_STATE);
                if((ball as ScrollBall).isInStatus(GameBall.PAUSED_STATE)){
                        (ball as ScrollBall).rate = Config.PAUSED_STOPPED_RATE
                }else{
                    (ball as ScrollBall).rate = Config.RUNNING_RATE;
                };
                continue;
            };
            (ball as ScrollBall).rate = Config.HIT_MOVE_RATE + Config.HIT_MOVE_G*currentHitMovingT;
         }
         lastball = ball as ScrollBall;
    }
    Collections.reverse(runningBalls);
    currentHitMovingT++;
}
public function dectectHitandMove(){
        //clear variables to be set
        hitmoving = false;
        pauseing = false;
        shifting = false;
        hitmoveneedstop = false;
        backing = false;
        shiftinghead = null;
        backinghead = null;
        pointedball = null;
        var allPaused = true;
        var detect = true;
        if(runningbullets.isEmpty()){
                detect = false;
        }
//        var bullet : BulletBall = runningbullets.peek() as BulletBall;
        var it : ListIterator  = runningBalls.listIterator();
        var lastball : ScrollBall;
        var ball : ScrollBall;
        var shorter : Double = 10000;
        while(it.hasNext()){
                ball = it.next() as ScrollBall;
                //check and remove the ball at a wrong position
                if(lastball != null and
                   not ball.isInStatus(GameBall.SHIFT_RUNNING_STATE) and
                   lastball.overredBall(ball)){
                        println("error position! -> lastball at {lastball.svgCount()} and ball at {ball.svgCount()}");
                        ball.stop(it);
                        continue;
                }
                //check if all ball are paused
                if(allPaused and not ball.isInStatus(GameBall.PAUSED_STATE)){
                        allPaused = false;
                }
                //find the currently pointed ball
                if(curx > ball.translateX and curx < ball.translateX + Config.BALL_DIAMETER){
                    if((cury - ball.translateY) < shorter){
                        shorter = cury - ball.translateY;
                        pointedball = ball;
                    }
                }
                //stop paused ball
                if(lastball != null and
                    ball.isInStatus(GameBall.PAUSED_STATE) and
                    not ball.isInStatus(GameBall.SHIFT_RUNNING_STATE) and
                    hitted(lastball,ball)){
                        if(not lastball.isInStatus(GameBall.PAUSED_STATE)){
                              ball.unsetStatus(GameBall.PAUSED_STATE);  
                        }
                        ball.rate = lastball.rate;
                }
                //check if there is a pausing ball
//                if(not pauseing and ball.isInStatus(GameBall.PAUSED_STATE)){
//                        pauseing = true;
//                }
                //get head of shift balls
                if(shiftinghead == null and ball.isInStatus(GameBall.SHIFT_RUNNING_STATE)){
                        shifting = true;
                        shiftinghead = ball;
                };
                //get head of backing balls
                if(backinghead == null and ball.isInStatus(GameBall.BACK_RUNNING_STATE)){
                        backing = true;
                        backinghead = ball;
                };
                //check if there are balls which is hit moving
                if(not hitmoving and ball.isInStatus(GameBall.HIT_MOVING_STATE)){
                        hitmoving = true;
                        if(ball.rate >= 0){
                                hitmoveneedstop = true;
                        }
                };
                //move running balls
                (((ball as ScrollBall).anim1)as Schedulable).scheduledUpdate(it);
                (((ball as ScrollBall).animball)as Schedulable).scheduledUpdate(it);
                //detect if bullet hitted
                var rit = runningbullets.listIterator();
                var bullet;
                while(detect and rit.hasNext()){
                    bullet = rit.next() as BulletBall;
                    if (detect and Model.hitted(bullet,(ball as ScrollBall))) {
                         if(bullet instanceof PowerBullet){
                            //TODO : another sound
                             bullet.hitmove(ball as ScrollBall,function(oldBall : ScrollBall):Void{
                                popScore(oldBall.translateX,oldBall.translateY,10,(oldBall.imageIndex));
                                addScore(10);
                                oldBall.stop(it);
                                //check if need backrunning
                                var preball : ScrollBall;
                                var nextball : ScrollBall;
                                if(it.hasPrevious() and it.hasNext()){
                                    preball = it.previous() as ScrollBall;
                                    it.next();
                                    nextball = it.next() as ScrollBall;
                                    //restore
                                    it.previous();
                                }
                                if(preball.imageIndex == nextball.imageIndex){
                                    Main.model.backRunningBall(nextball);
                                }else{
                                    Main.model.pauseRunningBall(nextball);
                                }
                                
                             });
                         }else{
                             bullet.pause();
                             playHitSound();
                             bullet.hitmove(ball as ScrollBall,function(newBall : ScrollBall){
                                it.add(newBall);
                             });
                         }
                         rit.remove();
                         break;
                     }
                }
                 lastball = ball;
        }
        if(allPaused){
                for(tball in runningBalls){
                        (tball as ScrollBall).rate = defaultRate;
                }
        }
        //let others move quickly to catch the paused ball
//        if(pauseing){
//                for(pball in runningBalls){
//                        if(not (pball as ScrollBall).isInStatus(GameBall.PAUSED_STATE)){
//                            (pball as ScrollBall).rate = Config.CATCH_RATE;
//                        }
//                }
//        }
}
public function shiftFrom(ball : GameBall){
    var index = (Model.runningBalls as LinkedList).indexOf(ball);
    var iter : Iterator = runningBalls.iterator();
    var counter = 0;
    var tmpball : ScrollBall;
    var shift = false;
    if(not(ball == runningBalls.getLast())){
            shift = hitted(ball, runningBalls.get(index+1) as ScrollBall,Config.BALL_DIAMETER) and not ((ball as ScrollBall).sameStatusWith((runningBalls.get(index+1) as ScrollBall)));
    }
    var tmparray = [];
    var lastball : ScrollBall;
    while(iter.hasNext()){
        tmpball = iter.next() as ScrollBall;
        if(counter > index){
//             //if there is a break between two stopped balls
             if(lastball != null and tmpball.isInStatus(GameBall.PAUSED_STATE) and not hitted(tmpball,lastball)){
//                     pauseinghead = tmpball;
                     break;
             }
             if(shift or tmpball.sameStatusWith(ball as ScrollBall)){
                insert tmpball into tmparray;
                lastball = tmpball;
             }
        }
        counter ++;
    }
    for(aball in tmparray){
        (aball as ScrollBall).rate = (Config.SHIFT_RATE);
    }
    shifting = false;
}
public function hitMovingBall(fromBall : ScrollBall){
    var index;
    Collections.reverse(runningBalls);
    if(fromBall == null){
        index = 0;
    }else{
        index = runningBalls.indexOf(fromBall);
    }
    if(index <0 or index == runningBalls.size()){
         println("fromball not found");
         return;
    }
    println("hit move start from {index}");
    var iter : Iterator = runningBalls.iterator();
    var counter = 0;
    var tmpball : ScrollBall;
    var tmparray = [];
    var lastball : ScrollBall;
    while(iter.hasNext()){
        tmpball = iter.next() as ScrollBall;
        if(counter >= index){
            if(lastball != null and not hitted(tmpball, lastball,5)){
                    break;
            };
             tmpball.setStatus(GameBall.HIT_MOVING_STATE);
             tmpball.rate = Config.HIT_MOVE_RATE;
             currentHitMovingRate = Config.HIT_MOVE_RATE;
             currentHitMovingT = 0;
             lastball = tmpball;
             println("set ball at {counter} to {Config.HIT_MOVE_RATE}");
        }
        counter ++;
    }
    Collections.reverse(runningBalls);
}
public function backRunningBall(fromBall : ScrollBall){
    var index = runningBalls.indexOf(fromBall);
    if(index < 0 or index == runningBalls.size()){
         return;
    }
    var iter : Iterator = runningBalls.iterator();
    var counter = 0;
    var tmpball : ScrollBall;
    var tmparray = [];
    while(iter.hasNext()){
        tmpball = iter.next() as ScrollBall;
        if(counter >= index and tmpball.sameStatusWith(fromBall)){
//             Logger.log("back change rate : {counter} of runningballs sizeof {balls.size()}");
             insert tmpball into tmparray;
        }
        counter ++;
    }
    for(ball in tmparray){
        (ball as ScrollBall).rate = (Config.BACK_RATE);
    }
    backing = false;
}
public function restoreAllRunning():Void{
    stopRollingSound();
    applyToAll(function(ball : ScrollBall):Boolean{
         if(ball.isInStatus(GameBall.PAUSED_STATE)){
                 return false;
         };
         if(ball.isInStatus(GameBall.SHIFT_RUNNING_STATE)){
                 return false;
         };
         if(ball.isInStatus(GameBall.BACK_RUNNING_STATE)){
                 return false;
         };
        (ball as ScrollBall).rate = (defaultRate);
        return false;
    });
}
public function detectAndRemoveBonus(ex : Number, ey : Number):Void{
    var it : ListIterator  = runningBonus.listIterator();
    var bonus;
    var bx;
    var by;
    while(it.hasNext()){
        bonus = it.next() as Bonus;
        bx = bonus.translateX + Config.BONUS_DIAMETER/2;
        by = bonus.translateY + Config.BONUS_DIAMETER/2;
        if(Math.sqrt(Util.square(ex-bx)+Util.square(ey-by))<(Config.BONUS_DIAMETER/2 + Config.EMITTER_DIAMETER/2)){
             println("{Math.sqrt(Util.square(ex-bx)+Util.square(ey-by))}<{(Config.BONUS_DIAMETER/2 + Config.EMITTER_DIAMETER/2)}");
             it.remove();
             bonus.eatted();
             return;
        }
        else if(bonus.hasOutOfWindow()){
                it.remove();
                recycleBonus(bonus);
                return;
        };
        (bonus.transiton as Schedulable).scheduledUpdate(null);
    }
}
}
