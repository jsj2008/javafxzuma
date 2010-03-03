/*
 * Config.fx
 *
 * Created on Jan 22, 2010, 11:18:31 AM
 */

package zuma;

/**
 * @author javatest
 */

public def EMITTER_X = 320;
public def EMITTER_Y = 320;
public def END_DOOR_X = 430;
public def END_DOOR_Y = 500;
public def EMITTER_RANGE = 1500;
public def EMITTER_DIAMETER = 100;
public def ENDDOOR_DIAMETER = 100;
public def WINDOW_HEIGHT = 600;
public def WINDOW_WIDTH = 600;
public def SCROLL_START_X = 342.85715;
public def SCROLL_START_Y = 463.79074;
public def BALL_DIAMETER = 30;
public def PRE_CREATE_BALL = 70;
public def PRE_CREATE_BALL_SPECIAL = 20;
public def PRE_CREATE_BULLET = 20;
public def PATH_WIDTH = 1;
public def BULLET_DURIATION = 3s;
public def BULLET_HIT_DURIATION = 0.25s;
public def PATH_DATA_FILE = "/zuma/svg/cyclemap1";
public def DETECTOR_FREQUENCY = 0.001s;
public def DEBUG = false;
public def SPECILA_PERCENTAGE = 10;
public def MAX_BALL_NUM = 40;

//-------------------ball move rate config  ----------------------
public def MOVE_FREQUENCY = 0.03s;
public def END_RATE : Integer = 10; //0.003s
public def BACK_RATE : Integer= -10; // 0.003s
public def SHIFT_RATE : Integer = 5; //0.006s
public def RUNNING_RATE = 1;
public def INITIAL_RATE = 10;
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
