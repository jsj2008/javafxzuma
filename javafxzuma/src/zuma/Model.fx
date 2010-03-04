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

import zuma.GameBall;

import zuma.util.Util;
import zuma.SpecialScrollBall;


import zuma.components.Schedulable;
import java.util.ListIterator;

import javafx.animation.Timeline;


public var initial_rate = Config.INITIAL_RATE;
public var lastGenered : ScrollBall = null;
public var containsBall : ScrollBall = null;
public-read var runningBalls : LinkedList = new LinkedList();
public var runningbullets : LinkedList =  new LinkedList();
//purge special ball listener
public-read var specialEffect : function(x : Number,y : Number,type : Integer);
//score changed listener
public-read var popScore : function(x : Number,y : Number,score : Integer,color : Integer);
public-read var addScore : function(score : Integer);
public-read var ending = false;
public var detectThread : Timeline;
var backcount = 0;
var shiftcount = 0;
var pausecount = 0;
var recycled : Stack = new Stack();
var recycledSpecial : Stack = new Stack();
var bullets : BulletBall[]= [];
public var currentbullet : BulletBall;
var bullet_stop = true;
var generedBall = 0;
var specialeffect_counter = 0 on replace {
    if(specialeffect_counter == 0){
        //restore defauterate
        setDefaultRate(Config.RUNNING_RATE);
        println("special effect ended");
    }
};
var hitsound = Sound{fileName:Resources.ballclick_sound};
var hitsound2 = Sound{fileName:Resources.ballclick_sound_2};
var purgesound = Sound{fileName:Resources.purge_sound};
var rollingsound = Sound{fileName:Resources.rolling_sound};
var sendbulletsound = Sound{fileName:Resources.send_bullet_sound};
var doorswitchsound = Sound{fileName:Resources.switch_door_sound};
public-read var defaultRate = initial_rate on replace oldvalue{
    applyToAll(function(ball : ScrollBall):Boolean{
//        if(defaultRate == Config.SPECIAL_BACK_RATE){
//            if(ball.isInStatus(GameBall.PAUSED_STATE)){
//                    ball.setRate(defaultRate);
//                    ball.setStatus(GameBall.BACK_RUNNING_STATE);
//            }
//            return false;
//        }
        if(ball.rate == oldvalue){
            ball.rate = (defaultRate);
        }
        return false;
    });
};
public var generedoffset = Config.INITIAL_OFFSET;
/*
*  private functions ---------------------------------------------------------------------------------------------
*/
function rebuild(ball : ScrollBall){
    ball.imageIndex = Util.random(6);
    ball.fromIndex = 0;
    ball.translateX = -100;
    ball.translateY = -100;
    ball.vis = false;
    ball.scaleX = 1;
    ball.scaleY = 1;
    ball.stopped = false;
    ball.clearStatus();
    delfromRunning(ball);
    return ball;
}
function effectAction(effect : Integer):Void{
    if(effect == SpecialScrollBall.SPECIAL_ACCURACY){
            setDefaultRate(Config.SPECIAL_ACC_RATE);
            return;
    }
    if(effect == SpecialScrollBall.SPECIAL_SLOW){
            setDefaultRate(Config.SPECIAL_SLOW_RATE);
            return;
    }
        if(effect == SpecialScrollBall.SPECIAL_BACK){
            setDefaultRate(Config.SPECIAL_ACC_RATE);
            return;
    }
    if(effect == SpecialScrollBall.SPECIAL_BOM){
            setDefaultRate(Config.SPECIAL_SLOW_RATE);
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
        if(backcount == 0){
                return false;
        }
        var backhead = getHeadOfBacking();
        if(backhead == null){
             return false;
        }
        var index = runningBalls.indexOf(backhead);
        if(index <= 0){
            return false;
        }
        var backhitBall = runningBalls.get(index - 1) as GameBall;
        if(hitted(backhead as ScrollBall,backhitBall,Config.BACK_OFFSET)){
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
             pausecount++;
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
     var it: Iterator = Resources.patharray.iterator();
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
    specialeffect_counter = 200;
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
public function generBall() : ScrollBall{
       if(generedBall == 0){
               playRollingSound();
       }
       if(generedBall > Config.MAX_BALL_NUM){
               return null;
       }
       var ox = Resources.patharray.get(0) as Float;
       var oy = Resources.patharray.get(1) as Float;
       var x = (lastGenered.translateX as Float);
       var y = (lastGenered.translateY as Float);
       if(x < 0 and y < 0){
               return null;
       }
       var dist = getDistance(ox,oy,x,y) - (Config.BALL_DIAMETER);
       if((not (lastGenered == null)) and dist < -generedoffset){
            return null;
       }
//       Logger.log("ball generating ...");
       if(Model.isRecycledEmpty()){
         lastGenered = ScrollBall{};
         lastGenered.start();
       }else{
//         Logger.log("reuse ball");
         lastGenered = Model.getBallOrSpecialFromRecycled();
         lastGenered.restart();
       }
       generedBall++;
       Model.addtoRunningTail(lastGenered);
       lastGenered.makeVisable();
       lastGenered.rate = (defaultRate);
       return  lastGenered;
}
public function endingRunning(){
//    if(ending){
//        return;
//    }
    ending = true;
//    for(ball in runningBalls){
//        (ball as ScrollBall).rate = (Config.END_RATE);
//    }
}
public function ended(){
    if(sizeofRunning() == 0){
            ending = false;
            return true;
    }
    return false;
}
public function getNextBall(ball : ScrollBall){
     var newball = getBallFromRecycled();
     var x = (ball.translateX as Float);
     var y = (ball.translateY as Float);
     var n = 0;
     var it: Iterator = Resources.patharray.iterator();
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
     return newball;
}
public function getMinDegreesBall(degreens : Number):ScrollBall{
    var rtn : ScrollBall;
    var mindeg : Number = 360;
    applyToAll(function(ball : ScrollBall):Boolean{
        var deg = Util.getDegrees(Config.EMITTER_X,Config.EMITTER_Y, ball.translateX+Config.BALL_DIAMETER/2, ball.translateY+Config.BALL_DIAMETER/2, 100000);
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
    for(bullet in Model.getBullets()){
                    if(bullet.state == GameBall.STOPED_STATE){
//                        Logger.log("reuse bullet {bullet}");
                        Model.setCurrentBullet(bullet);
                        if(runningBalls.size() <= 5){
                                
                        }
                        var tmp = currentImageIndexs();
                        bullet.imageIndex = tmp[Util.random(sizeof tmp)] as Integer;
                        Model.getCurrentBullet().ready();
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
    Model.findToBePurged(specialEffect);
}
public function setCurrentBullet(bullet : BulletBall){
    currentbullet = bullet;
}
public function addBullet(bullet : BulletBall){
    insert bullet into bullets;
}
public function getBullets(){
    return bullets;
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
public function addtoRunningAt(ball : ScrollBall,fromball : GameBall){
    var index = (Model.runningBalls as LinkedList).indexOf(fromball)+1;
    (runningBalls as LinkedList).add(index,ball);
//    Logger.log("add {ball} to quque : at {(balls as LinkedList).indexOf(ball)}");
}
public function delfromRunning(ball : ScrollBall){
    runningBalls.remove(ball);
}
public function getRunningBallAt(index : Number){
    return (runningBalls as LinkedList).get(index) as ScrollBall;
}
public function getBallFromRecycled(){
    var ball = recycled.pop() as ScrollBall;
//    Logger.log("get {ball} from recycled");
    return ball;
}
public function getSpecialBallRromRecycled(){
    var ball = recycledSpecial.pop() as ScrollBall;
//    Logger.log("get {ball} from recycledSpecial");
    return ball;
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
public function sizeofRunning(){
    return runningBalls.size();
}
public function recycleBall(ball : ScrollBall){
    recycled.push(rebuild((ball as ScrollBall)));
}
public function recycleSpecial(ball : ScrollBall){
    recycledSpecial.push(rebuild((ball as ScrollBall)));
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
public function findToBePurged(sepcialEffect : function(x : Number,y : Number,type : Integer):Void):Boolean{
    if(containsBall == null){
            Logger.log("contains is {containsBall}");
            return false
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
        return false;
    }
    if(not containsHitted){
        return false;
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
//                effectAction((pball as SpecialScrollBall).effectIndex);
                specialEffectBegin();

        }
        popScore(pball.translateX,pball.translateY,t_add,(pball.imageIndex));
        addScore(10);
        playPurgeSound();
        pball.ScalingAndUnvisable();
        pball.rate = (Config.END_RATE);
        insert pball into temparray;
    }
    for(pball in temparray){
        pball.stop();
    }
    if(hittedBall == null or backfromBall == null){
            return true;
    }
    if((hittedBall).imageIndex == (backfromBall).imageIndex){
        Model.backRunningBall(backfromBall);
    }else{
        if((not (getHeadOfPaused() == null)) or (not(backfromBall == null) and not backfromBall.isInStatus(GameBall.PAUSED_STATE))){
            Model.pauseRunningBall(backfromBall);
        }
    }
    containsBall = null;
    return true
}
public function stopShift():Void{
     if(shiftcount == 0){
             return;
     }
     var shifthead : ScrollBall= getHeadOfShift() as ScrollBall;
     if(shifthead == null){
          return;
     }
     var reached = Resources.patharray.indexOf(shifthead.translateX)/3;
     var indexOfShift = runningBalls.indexOf(shifthead);
     //when all balls are shifting,stop.
     if(indexOfShift <=0){
        applyToAll(function(ball : ScrollBall):Boolean{
            ball.rate = (Config.RUNNING_RATE);
            ball.unsetStatus(GameBall.PAUSED_STATE);
            ball.unsetStatus(GameBall.SHIFT_RUNNING_STATE);
            ball.unsetStatus(GameBall.BACK_RUNNING_STATE);
            return false;
        });
        return;
     }
     var newBall = runningBalls.get(indexOfShift-1);
     var ox = (newBall as ScrollBall).translateX;
     var oy = (newBall as ScrollBall).translateY;
     var x = shifthead.translateX;
     var y = shifthead.translateY;
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
         shiftcount--;
     }
}
public function stopPause():Void{
    if(pausecount == 0){
        return;
    }
    var running;
    for(ball in runningBalls){
        if((ball as ScrollBall).isInStatus(GameBall.PAUSED_STATE)){
                break;
        }
        running = ball;
    }
    var firsthitted = true;
    applyToPausedBall(function(paused : ScrollBall):Boolean{
        if(running == null){
                return true;
        }
        if(paused.isInStatus(GameBall.SHIFT_RUNNING_STATE)){
                paused.rate = (Config.SHIFT_RATE);
                paused.unsetStatus(GameBall.PAUSED_STATE);
                pausecount--;
                return false;
        }
        if(paused.isInStatus(GameBall.BACK_RUNNING_STATE)){
                paused.rate = (Config.BACK_RATE);
                paused.unsetStatus(GameBall.PAUSED_STATE);
                pausecount--;
                return false;
        }
        if(not Model.hitted(running as ScrollBall,paused,Config.PAUSE_OFFSET)){
                if((running as ScrollBall).overredBall(paused)){
                        println("paused ball status error !, will be stopped!");
                        (paused as ScrollBall).stop();
                        pausecount--;
                }
                return true;
        }
        if(firsthitted){
            playHitSound2();
            firsthitted = false;
        }
        paused.rate = ((running as ScrollBall).rate);
        pausecount--;
        paused.unsetStatus(GameBall.PAUSED_STATE);
    });
}
public function stopBack():Void{
    if(not backHitted()){
           return;
    }
    var hittedball = getHeadOfBacking();
    if(hittedball == null){
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
    containsBall = hittedball as ScrollBall;
    if(Model.findToBePurged(specialEffect)){
//        setDefaultRate(Config.PAUSED_STOPPED_RATE);
//        specialeffect_counter = 50;
//        specialEffectBegin();
    }else{
//        setDefaultRate(Config.PAUSED_STOPPED_RATE);
//        specialeffect_counter = 25;
//        specialEffectBegin();
    }
    backcount--;
}
public function dectectHitandMove(){
        var detect = true;
        if(runningbullets.isEmpty()){
                detect = false;
        }
        var bullet : BulletBall = runningbullets.peek() as BulletBall;
        var it : ListIterator  = runningBalls.listIterator();
        var ball : ScrollBall;
        while(it.hasNext()){
                ball = it.next() as ScrollBall;
                (((ball as ScrollBall).anim1)as Schedulable).scheduledUpdate();
                (((ball as ScrollBall).animball)as Schedulable).scheduledUpdate();
                if (detect and Model.hitted(bullet,(ball as ScrollBall))) {
                     bullet.pause();
                     playHitSound();
                     var newBall = bullet.hitmove(ball as ScrollBall,function(newBall : ScrollBall){
                        it.add(newBall);
                     });
                     runningbullets.poll();
                     detect = false;
                 }
        }
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
    while(iter.hasNext()){
        tmpball = iter.next() as ScrollBall;
        if(counter > index){//TODO : how to identify if there is a break between two stopped balls?
             if(shift or tmpball.sameStatusWith(ball as ScrollBall)){
                insert tmpball into tmparray;
             }
        }
        counter ++;
    }
    for(aball in tmparray){
        (aball as ScrollBall).rate = (Config.SHIFT_RATE);
    }
    shiftcount++;
}
//public function restoreRateWhenAllPaused(){
//      var count = 0;
//      applyToPausedBall(function(ball : ScrollBall):Boolean{
//              count++;
//              return false;
//      });
//      //TODO : what if there is a break between two paused sequeus
//      if((runningBalls.size()) == count){
//           applyToAll(function(ball : ScrollBall):Boolean{
//                ball.setRate(defaultRate);
//                ball.unsetStatus(GameBall.PAUSED_STATE);
//                ball.unsetStatus(GameBall.SHIFT_RUNNING_STATE);
//                ball.unsetStatus(GameBall.BACK_RUNNING_STATE);
//                return false;
//           });
//      }
//
//}
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
    backcount++;
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
public function setDefaultRate(rate : Integer){
    println("default rate set to {rate}");
    defaultRate = rate;
}
public class Model {

}
