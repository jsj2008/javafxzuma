/*
 * Bonus.fx
 *
 * Created on Mar 10, 2010, 3:06:04 PM
 */

package zuma;

import javafx.scene.CustomNode;

import javafx.scene.Node;

import javafx.scene.image.ImageView;

import zuma.components.ParabolaTransition;

import javafx.scene.image.Image;

import javafx.scene.Group;

import javafx.animation.transition.FadeTransition;
import javafx.animation.transition.ParallelTransition;
import javafx.animation.transition.ScaleTransition;

/**
 * @author javatest
 */

public class Bonus extends CustomNode{
public var image : Image;
public var startx : Number;
public var starty : Number;
public var group : Group;
init{
    insert this into group.content;
}
def specialimageview = ImageView {
        image: bind image
        cache : true
        opacity : bind opacity
};
public-read var transiton = ParabolaTransition{
            node : this
            vy : 10
            maxx : Config.WINDOW_WIDTH - Config.BONUS_DIAMETER;
            minx : 0
            borderx: bind startx
            bordery: bind starty
            g : 0.2
            p : 1
        };
var specialparTransition = ParallelTransition {
        node: this
        content: [
            FadeTransition { duration: 0.8s fromValue:0.0  toValue: 1.0
                },
            ScaleTransition { duration: 1s fromX : 1 fromY : 1 byX: 4.5 byY: 4.5
                },
        ]
        action : function(){
                scaleX = 1;
                scaleY = 1;
                Main.model.recycleBonus(this);
        }
}
override public function create(): Node {
        specialimageview;
}
public function start(){
    opacity = 1.0;
    transiton.start();
}
public function stop(){
    opacity = 0;
    transiton.stop();
}
public function eatted(){
    println("bonus eatted at {translateX} {translateY}");
    stop();
//    opacity = 1.0;
    Main.model.recycleBonus(this);
//    specialparTransition.playFromStart();
}
public function hasOutOfWindow():Boolean{
    if(translateY > Config.WINDOW_HEIGHT - 22 or translateX > Config.WINDOW_WIDTH){
        return true;
    }
    return false;
}
}
