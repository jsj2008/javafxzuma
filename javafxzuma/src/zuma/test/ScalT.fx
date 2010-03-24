/*
 * ScalT.fx
 *
 * Created on Jan 26, 2010, 10:42:19 AM
 */

package zuma.test;

import javafx.animation.transition.ScaleTransition;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;

import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 * @author perkin tang
 */
    var node = Rectangle {
        x: 100 y: 40
        height: 100 width:  100
        arcHeight: 50 arcWidth: 50
        fill: Color.VIOLET
    }

    var scaleTransition = ScaleTransition {
        duration: 0.4s node: node
        byX: 1.5 byY: 1.5
        repeatCount:2 autoReverse: true
    }
    scaleTransition.play();
Stage {
    title: "Application title"
    width: 500
    height: 500
    scene: Scene {
        content: [node
        ]
    }
}
 class ScalT {

}
