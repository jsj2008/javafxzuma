/*
 * FadeT.fx
 *
 * Created on Jan 26, 2010, 10:52:14 AM
 */

package zuma.test;

import javafx.animation.transition.FadeTransition;
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

    var fadeTransition = FadeTransition {
        duration: 3s node: node
        fromValue: 1.0 toValue: 0.3
        repeatCount:4 autoReverse: true
    }
    fadeTransition.play();
Stage {
    title: "Application title"
    width: 500
    height: 500
    scene: Scene {
        content: [node
        ]
    }
}
 class FadeT {

}
