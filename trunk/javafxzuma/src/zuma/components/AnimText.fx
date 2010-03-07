/*
 * AnimText.fx
 *
 * Created on Feb 24, 2010, 12:08:43 PM
 */

package zuma.components;

import javafx.scene.CustomNode;

import javafx.scene.Node;
import javafx.scene.text.Font;
import javafx.scene.text.Text;

import javafx.animation.transition.ScaleTransition;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

import javafx.animation.transition.FadeTransition;

import javafx.scene.paint.Color;


/**
 * @author javatest
 */

public class AnimText  extends CustomNode {
var color_index = 0;
public var font : Font = Font { size: 20 };
var colors : Color[] = [Color.BLUE,
                        Color.GREEN,
                        Color.PURPLE,
                        Color.RED,
                        Color.WHITE,
                        Color.YELLOW];
var t : Object = 0;
var value : Integer = 0;
var v1 : Integer = 0;
var text = Text {
    font: bind font
    content: bind t.toString()
    fill: bind colors[color_index]
}
def scaleTransition = ScaleTransition {
        duration: 0.1s node: this
        byX: 1.1 byY: 1.1
        repeatCount:2
        autoReverse: true
}
def upanim = Timeline {
        repeatCount: 80
        keyFrames : [
            KeyFrame {
                time: 0.01s
                action: function () {
                        translateY = translateY - 1;
                }
            }
        ]
}
def addanim = Timeline {
        repeatCount: 100
        keyFrames : [
            KeyFrame {
                time: 0.05s
                action: function () {
                        if(t != value){
                            t =(t as Integer)+1;
                        }
                }
            }
        ]
}
def fade = FadeTransition { node : this duration: 0.8s fromValue: 1.0 toValue: 0}
override public function create(): Node {
       text
}
public function setScaleText(text,index:Integer){
    visible = true;
    t = text;
    color_index = index;
    scaleTransition.playFromStart();
}
public function setUpText(text,index:Integer){
    if(upanim.running and fade.running){
        return;
    }
    visible = true;
    t = text;
    color_index = index;
    upanim.playFromStart();
    fade.playFromStart();
}
public function addText(num : Integer){
    value = (v1 as Integer) + num;
    v1 = value;
    visible = true;
    addanim.playFromStart();
    scaleTransition.playFromStart();
}
}
