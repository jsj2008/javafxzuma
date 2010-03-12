/*
 * Config.fx
 *
 * Created on Jan 22, 2010, 11:18:31 AM
 */

package zuma;

/**
 * @author javatest
 */

public def EMITTER_RANGE = 500;
public def EMITTER_DIAMETER = 40;
public def WINDOW_HEIGHT = 240;
public def WINDOW_WIDTH = 320;
public def BALL_DIAMETER = 16;
public def PURGE_BALL_DIAMETER = 24;
public def PRE_CREATE_BALL = 60;
public def PRE_CREATE_BALL_SPECIAL = 20;
public def PRE_CREATE_BULLET = 20;
public def PATH_WIDTH = 1;
public def BULLET_DURIATION = 1s;
public def BULLET_HIT_DURIATION = 0.05s;
public def DETECTOR_FREQUENCY = 0.002s;
public def DEBUG = false;
public def SPECILA_PERCENTAGE = 10;

//-------------------ball move rate config  ----------------------
public def MOVE_ROLL_FREQUENCY = 0.04s;
public def END_RATE : Integer = 10;
public def BACK_RATE : Integer= -10;
public def SHIFT_RATE : Integer = 20;
public def RUNNING_RATE = 1;
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
