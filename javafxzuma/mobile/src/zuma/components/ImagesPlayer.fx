/*
 * ImagesPlayer.fx
 *
 * Created on Mar 1, 2010, 2:34:02 PM
 */

package zuma.components;

import javafx.scene.image.ImageView;

import javafx.scene.image.Image;

import javafx.animation.Timeline;

import javafx.animation.KeyFrame;

import javafx.scene.CustomNode;

import javafx.scene.Node;

import javafx.util.Math;

/**
 * @author javatest
 */

public class ImagesPlayer extends CustomNode{
public var images : Image[];
public var width : Number = 30;
public var height : Number = 30;
public-read var paused = false;
var ajust = false;
var index = 0;
var max = bind sizeof(images);
public var repeatCount = Timeline.INDEFINITE;
public var rate = 0;
def imageview = ImageView {
        fitWidth : bind width
        fitHeight : bind height
        translateX : 0
        translateY : 0
        image: bind images[index]
        cache : false
        opacity : bind opacity
};
var timer = Timeline {
        repeatCount: repeatCount
        keyFrames : [
            KeyFrame {
                time: 0.05s
                action: update
                }
        ]
};
public function update():Void{
    if(index >= max){
        index = 0;
    }
    index++;
}
public function play(){
    if(rate == 0){
        rate = 1;
    }
    timer.playFromStart();
}
public function pause(){
    rate = 0;
    timer.pause();
}
public function stop(){
    rate = 0;
    timer.stop();
}
override public function create(): Node {
       imageview
}
}
