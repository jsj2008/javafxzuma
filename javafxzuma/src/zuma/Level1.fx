/*
 * Level1.fx
 *
 * Created on Mar 4, 2010, 3:06:17 PM
 */

package zuma;

/**
 * @author javatest
 */

public class Level1 extends Level{
override public function ready():Void{
    while (sizeof Main.model.getBullets() < Config.PRE_CREATE_BULLET){
         def ball0 = BulletBall{group : Main.game.group};
         Main.model.addBullet(ball0);
    }
    while (Main.model.sizeofRecycled() < Config.PRE_CREATE_BALL){
         def ball0 = ScrollBall{};
         insert ball0 into Main.game.group.content;
         insert ball0.effectplayer into Main.game.group.content;
         ball0.setStatus(GameBall.DEAD_STATE);
         ball0.vis = false;
         Main.model.recycleBall(ball0);
    }
    while(Main.model.sizeofRecycledSpecial() < Config.PRE_CREATE_BALL_SPECIAL){
         def ball0 = SpecialScrollBall{};
         insert ball0 into Main.game.group.content;
         ball0.setStatus(GameBall.DEAD_STATE);
         ball0.vis = false;
         Main.model.recycleSpecial(ball0);
    }
    for(bullet in Main.model.getBullets()){
            bullet.rate = 1;
    }
}
}
