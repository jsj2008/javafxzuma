/*
 * ParallT.fx
 *
 * Created on Jan 26, 2010, 10:53:25 AM
 */

package zuma.test;

import javafx.animation.transition.FadeTransition;
import javafx.animation.transition.ParallelTransition;
import javafx.animation.transition.RotateTransition;
import javafx.animation.transition.ScaleTransition;
import javafx.animation.transition.TranslateTransition;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;

import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 * @author javatest
 */
var node = Rectangle {
        x: 100 y: 40
        height: 100 width:  100
        arcHeight: 50 arcWidth: 50
        fill: Color.VIOLET
    }

    var parTransition = ParallelTransition {
        node: node
        content: [
            FadeTransition { duration: 0.8s fromValue: 1.0 toValue: 0
                },
            ScaleTransition { duration: 1s node: node byX: 1.5 byY: 1.5
                },
        ]
    }
    parTransition.play();
Stage {
    title: "Application title"
    width: 500
    height: 500
    scene: Scene {
        content: [node
        ]
    }
}
 class ParallT {

}
