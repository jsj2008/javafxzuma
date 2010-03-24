/*
 * FadeBall.fx
 *
 * Created on Jan 28, 2010, 12:07:33 PM
 */

package zuma.components;

import javafx.animation.Timeline;
import javafx.animation.transition.FadeTransition;
import javafx.scene.Node;
import javafx.scene.image.ImageView;

/**
 * @author perkin tang
 */

public class FadeBall extends Ball,Schedulable{
public var ball_deameter : Float= 10;
public-read var paused = false;
public var fade = true;
def imageview = ImageView {
        smooth : bind smooth
        translateX : 0
        translateY : 0
        image: bind image
        cache : false;
};
var fadeTransition = FadeTransition {
        duration: 0.5s
        node: bind imageview
        fromValue: 0.5
        toValue: 1.0
        repeatCount:Timeline.INDEFINITE
        autoReverse: true
}
override public function create(): Node {
        imageview;
}
override public function start(){
        paused = false;
        if(fade){
            fadeTransition.playFromStart();
        }
}
override public function pause(){
        paused = true;
        if(fade){
            fadeTransition.pause();
        }
}
override public function resume(){
        paused = false;
        if(fade){
            fadeTransition.play();
        }
}
override public function update(object : Object):Void{}
}
