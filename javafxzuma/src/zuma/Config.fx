/*
 * Config.fx
 *
 * Created on Jan 22, 2010, 11:18:31 AM
 */

package zuma;

/**
 * @author perkin tang
 */

public def EMITTER_RANGE = 500;
public def EMITTER_DIAMETER = 50;
public def ENDDOOR_DIAMETER = 100;
public def WINDOW_HEIGHT = 361;
public def WINDOW_WIDTH = 480;
public def SCROLL_START_X = 342.85715;
public def SCROLL_START_Y = 463.79074;
public def BALL_DIAMETER = 20;
public def BALL_PURGE_RATIO : Double = 3;
public def BONUS_DIAMETER = 30;
public def PRE_CREATE_BALL = 80;
public def PRE_CREATE_BALL_SPECIAL = 20;
public def PRE_CREATE_BULLET = 20;
public def PRE_CREATE_SPEAR = 10;
public def PRE_CREATE_BONUS = 10;
public def PATH_WIDTH = 1;
public def BULLET_DURIATION = 1s;
public def BULLET_HIT_DURIATION = 0.1s;
public def DETECTOR_FREQUENCY = 0.001s;
public def DEBUG = false;
public def SPECILA_PERCENTAGE = 20;
public def SPECIALL_DUR_COUNT = 5000;
//-------------------ball move rate config  ----------------------
public def MOVE_ROLL_FREQUENCY = 0.02s;
public def END_RATE : Integer = 10; //0.003s
public def BACK_RATE : Integer= -20; // 0.003s
public def SHIFT_RATE : Integer = 20; //0.006s
public def HIT_MOVE_G : Integer = 1;
public def HIT_MOVE_RATE : Integer = -5;
public def HIT_MOVE_CHECK_COUNT = 100;
public def RUNNING_RATE = 1;
public def CATCH_RATE = 2;
public def PAUSED_STOPPED_RATE = 0;
//-----------------------------------------------------------------

public def SPECIAL_ACC_RATE = 3;
public def SPECIAL_SLOW_RATE = 0;
public def SPECIAL_BACK_RATE = -5;

public def INITIAL_OFFSET = 0;
public def NORMAL_OFFSET = 0;
public def SHIFT_OFFSET = 0;
public def BACK_OFFSET = 0;
public def PAUSE_OFFSET = 0;
