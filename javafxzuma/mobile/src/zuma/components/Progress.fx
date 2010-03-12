/*
 * Progress.fx
 *
 * Created on Mar 8, 2010, 2:45:12 PM
 */

package zuma.components;

import javafx.scene.CustomNode;

import javafx.scene.Node;

import javafx.scene.image.ImageView;

import javafx.scene.image.Image;

import javafx.scene.Group;

import javafx.scene.shape.Rectangle;

/**
 * @author javatest
 */

public class Progress extends CustomNode{
public var progressImage : Image;
public var fillImage : Image;
public var max : Integer;
public var current : Integer = 0 on replace {
    if(current > max){
            current = max;
    }
    if(current < 0){
            current = 0;
    }
};
var cy = Rectangle {
    width: bind fillImage.width/max*current   height: fillImage.height
}
def progress = ImageView {
        translateX : 0
        translateY : 0
        image: bind progressImage
        cache : true
        opacity : bind opacity
};
def fill = ImageView {
        translateX : progressImage.width/2 - fillImage.width/2
        translateY : (progressImage.height/2 - fillImage.height/2)+2
        image: bind fillImage
        clip : bind cy
        cache : false
        opacity : bind opacity
};
var group : Group = Group{
    content : [progress,fill]
};
override public function create(): Node {
       group;
}
public function isCompleted():Boolean{
    return current == max;
}
}
