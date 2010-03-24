/*
 * SpearBullet.fx
 *
 * Created on Mar 15, 2010, 1:46:17 PM
 */

package zuma;

import zuma.components.HorizontalImagePlayer;

import javafx.scene.Node;

/**
 * @author perkin tang
 */

public class PowerBullet extends BulletBall{
public var powerIndex = 0;
protected var bullet = HorizontalImagePlayer{
        startFrom: 0
        image : bind Resources.powerbulletarray[powerIndex];
        cy_w: Config.BALL_DIAMETER
        cy_h: Config.BALL_DIAMETER
        dur : 0.1s
        };
override public function create(): Node {
        bullet.start();
        bullet
}
override public function hitmove(ball : ScrollBall,action : function(newBall : ScrollBall):Void) : ScrollBall{
        stop();
        ball.ScalingAndUnvisable();
        action(ball);
        return null;
}
}
