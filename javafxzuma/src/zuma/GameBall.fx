/*
 * GameBall.fx
 *
 * Created on Jan 29, 2010, 10:04:01 AM
 */

package zuma;

import javafx.scene.CustomNode;



/**
 * @author javatest
 */
public def RUNNING_STATE = 0;
public def PAUSED_STATE = 1;
public def STOPED_STATE = 2;
public def BACKGROUND_STATE = 3;
public def DEAD_STATE = 4;
public def BACK_RUNNING_STATE = 5;
public def SHIFT_RUNNING_STATE = 6;
  public abstract class GameBall extends CustomNode{
//protected public-read var state = STOPED_STATE;
}
