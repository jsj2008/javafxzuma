/*
 * ExplodedBall.fx
 *
 * Created on Mar 11, 2010, 2:48:34 PM
 */

package zuma;

import javafx.scene.Group;

/**
 * @author javatest
 */

public class ExplodedBall {
public var x : Number;
public var y : Number;
public var group : Group;
var pars = [
BallParcitle{startx:bind x,starty:bind y,vx : 4/2,vy : 0},
BallParcitle{startx:bind x,starty:bind y,vx : 2.8/2/2,vy : 2.8/2/2},
BallParcitle{startx:bind x,starty:bind y,vx : 0,vy : 4/2},
BallParcitle{startx:bind x,starty:bind y,vx : -2.8/2,vy : 2.8/2},
BallParcitle{startx:bind x,starty:bind y,vx : -4/2/2,vy : 0},
BallParcitle{startx:bind x,starty:bind y,vx : -2.8/2/2,vy : -2.8/2/2},
BallParcitle{startx:bind x,starty:bind y,vx : 0,vy : -4/2/2/2},
BallParcitle{startx:bind x,starty:bind y,vx : 2.8/2,vy : -2.8/2}];
public function start(){
    for(par in pars){
        insert par into group.content;
        par.start();
    }
}
public function stop(){
    for(par in pars){
        delete par from group.content;
        par.stop();
    }
}

}
