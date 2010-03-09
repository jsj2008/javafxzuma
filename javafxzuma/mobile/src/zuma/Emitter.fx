/*
 * Emitter.fx
 *
 * Created on Feb 22, 2010, 11:55:31 AM
 */

package zuma;

import javafx.scene.CustomNode;

import javafx.scene.Node;
import javafx.scene.image.ImageView;

import javafx.animation.Interpolator;
import javafx.animation.transition.TranslateTransition;

import zuma.util.Util;

/**
 * @author javatest
 */

public class Emitter extends CustomNode{
public var degrees : Double= 90;
public var dx : Float = 0;
public var dy : Float = 0;
public var tx : Number = 0;
public var ty : Number  = 0;
public def move = TranslateTransition {
        rate: 1
        autoReverse : true;
        byX: bind Util.getCoordx1(tx,ty,dx,dy,15)-tx as Float
        byY: bind Util.getCoordy1(tx,ty,dx,dy,15)-ty as Float
        node: this
        interpolator: Interpolator.LINEAR
        duration: 0.1s
        repeatCount:1
        action : function(){
            moveback.playFromStart();
        }
};
public def moveback = TranslateTransition {
        rate: 1
        autoReverse : true;
        byX: bind -(Util.getCoordx1(tx,ty,dx,dy,15)-tx) as Float
        byY: bind -(Util.getCoordy1(tx,ty,dx,dy,15)-ty) as Float
        node: this
        interpolator: Interpolator.LINEAR
        duration: 0.1s
        repeatCount:1
        action : function(){
            Main.model.setCurrentBullet();
        }
};
def emitter = ImageView {
        smooth: true
        fitHeight : Config.EMITTER_DIAMETER
        fitWidth : Config.EMITTER_DIAMETER
        image: Resources.emitterImage
        rotate: bind degrees
        visible : true;
};
override public function create(): Node {
        emitter;
}
public function hitmove(){
    if(not move.running and not moveback.running){
        move.playFromStart();
    }
}
}
