/*
 * BulletBallTest.fx
 *
 * Created on 2010-1-26, 20:28:50
 */

package zuma.test;

import zuma.BulletBall;

import javafx.scene.Scene;
import javafx.stage.Stage;

import zuma.ScrollBall;

import javafx.scene.shape.Circle;

/**
 * @author perkin tang
 */
def ball = BulletBall{vis : true};
def sball = ScrollBall{translateX : 100,translateY : 100};
var cy  = Circle {
                centerX: 100  centerY: 100
                translateX : 100
                translateY : 100
                radius: 20
}
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [ball,sball,cy
        ]
    }
}
println("cy : x {cy.translateX},y {cy.translateX}");
println("cy : laybounds x {cy.layoutBounds.minX}, y {cy.layoutBounds.minY}");
println("ball : x {ball.translateX},y {ball.translateX}");
println("ball : laybounds x {ball.layoutBounds.minX}, y {ball.layoutBounds.minY} ");
class BulletBallTest {

}
