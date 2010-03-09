/*
 * ImagePlayer.fx
 *
 * Created on Mar 5, 2010, 9:55:46 AM
 */

package zuma.components;

import javafx.scene.image.ImageView;

import javafx.scene.shape.Rectangle;

import javafx.scene.image.Image;

import javafx.scene.CustomNode;

import javafx.scene.Node;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

/**
 * @author javatest
 */
public class HorizontalImagePlayer extends CustomNode{
public var smooth = false;
public var cy_w : Number;
public var cy_h : Number;
public var image : Image;
public var rate : Integer = 1;
var ajust = false;
var cy  = Rectangle {
    x : 0
    y : 0
    width: bind cy_w  height: cy_h
}
var imx : Number = 0;
var cyx : Number = 0;
def ratio = bind image.width / image.height;
var framesN = cy_h*ratio/cy_w;
def imageview = ImageView {
        smooth : bind smooth
        fitWidth : bind cy_h*ratio
        fitHeight : bind cy_h
        translateX : 0
        translateY : 0
        image: bind image
        clip : cy
        cache : false
        opacity : bind opacity
};
override public function create(): Node {
       imageview
}
public function update():Void{
    if(rate == 0){
            return;
    }
    if(ajust){
        if(rate < 0){
            imageview.translateX = - cy_h*ratio + cy_w;
            cy.x = cy_h*ratio - cy_w;
        }else{
            imageview.translateX = 0;
            cy.x = 0;
        }
        ajust = false;
        return;
    }
    imx = imageview.translateX-cy_w*rate;
    cyx = cy.x+cy_w*rate;
    if(imx < -cy_h*ratio + cy_w
        or imx > cy_w or cyx < cy_w or cyx > cy_h*ratio - cy_w){
        ajust  = true;
    }else{
        imageview.translateX=imx;
        cy.x=cyx;
    }
}
var timer = Timeline {
        repeatCount: Timeline.INDEFINITE;
        keyFrames : [
            KeyFrame {
                time: 0.03s
                action: update
                }
        ]
};
public function start(){
    timer.play();
}
}
