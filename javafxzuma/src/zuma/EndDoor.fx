/*
 * EndDoor.fx
 *
 * Created on Jan 29, 2010, 3:58:11 PM
 */

package zuma;

import javafx.scene.CustomNode;

import javafx.scene.Node;
import javafx.scene.image.ImageView;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

/**
 * @author javatest
 */

public class EndDoor extends CustomNode{
public-read var opened = false;
var index : Integer = 0;
def imageview = ImageView {
        fitWidth : Config.ENDDOOR_DIAMETER;
        fitHeight : Config.ENDDOOR_DIAMETER;
        image: bind Resources.endDoorImage[index];
        cache : false
        opacity : bind opacity
};
var timer = Timeline {
        repeatCount: 3
        keyFrames : [
            KeyFrame {
                time: bind 0.2s
                action: function () {
                        index++;
                }
            }
        ]
};
override public function create(): Node {
        imageview;
}
public function open(){
    if(opened){
            return;
    }
    Main.model.playDoorSwitchSound();
    index = 0;
    timer.playFromStart();
    opened = true;
}
public function close(){
    if(not opened){
           return;
    }
    Main.model.playDoorSwitchSound();
    index = 0;
    opened = false;
}
}
