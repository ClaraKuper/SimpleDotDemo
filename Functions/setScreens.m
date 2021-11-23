% Set up screens
function setScreens

  global settings scr visual

  AssertOpenGL;

  % in case a test version is running on a different screen with
  % worse syncing properties
  if ~ settings.SYNCTEST
      Screen('Preference','ConserveVRAM',16384);                           % specification on M1
      Screen('Preference', 'SkipSyncTests', 1);                            % skip sync test
  
  end

  % Define some parameters for the screen in cabin 8
  
  if (settings.DEVICE == 'v')
      scr.subDist = 530;          % subject distance (mm)
      scr.refRate = 120;          % refresh rate (Hz)    
      scr.xres    = 1920;         % x resolution (px)
      scr.yres    = 1080;         % y resolution (px)
      scr.width   = 518.0;

      % width  of screen (mm) 
      scr.height  = 292.0;         % height of screen (mm)
      scr.colDept = 8;             % color depth per channel
      scr.nLums   = 2^scr.colDept; % number of possible luminance values
  
      % Define some parameters for your home screen
  elseif (settings.DEVICE == 'h')
      scr.subDist = 450;          % subject distance (mm)
      scr.refRate = 60;           % refresh rate (Hz)    
      scr.xres    = 1440;         % x resolution (px)
      scr.yres    = 900;          % y resolution (px)
      scr.width   = 290.0;        % width  of screen (mm) 
      scr.height  = 180.0;         % height of screen (mm)
      scr.colDept = 8;             % color depth per channel
      scr.nLums   = 2^scr.colDept; % number of possible luminance values
  end

  % If there are multiple displays guess that one without the menu bar is the
  % best choice.  Dislay 0 has the menu bar.
  scr.allScreens = Screen('Screens');
  scr.expScreen  = min(scr.allScreens);

  % Assert correct screen resolution and color depth values
  res = Screen('Resolution', scr.expScreen);
  if settings.DEVICE == 'v'
      if scr.xres ~= res.width || scr.yres ~= res.height
          ListenChar(1);
          error('Screen resolution value is set incorrectly.\nIt should be: %d by %d', res.width, res.height);    
      elseif res.pixelSize ~= scr.colDept * 3
          ListenChar(1);
          error('Color depth per channel is set incorrectly.\nIt should be: %d', res.pixelSize/3);
      end
  end

  
  % Open datapixx and init PsychImaging
  if settings.DEVICE == 'v'
    Datapixx('Open');                                                       % Opens the Datapixx
  end
  
  PsychImaging('PrepareConfiguration');

  
  visual.white = WhiteIndex(scr.expScreen);
  visual.black = BlackIndex(scr.expScreen);
  visual.bgcolor = visual.white * [0.5, 0.5, 0.5];
  
  
  % Open windows
  [visual.window, visual.windowRect] = PsychImaging('OpenWindow', scr.expScreen, visual.bgcolor);  
  [visual.xCenter, visual.yCenter] = RectCenter(visual.windowRect);
  
  Screen('BlendFunction', visual.window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  
  % set some parameters from known screen properties
  ref = Screen('GetFlipInterval', visual.window);
  scr.hz = 1/ref;
  visual.hz = scr.hz;
  
  visual.ppd = dva2pix(1,scr);

  visual.winWidth = visual.windowRect(3) - visual.windowRect(1);
  visual.winHeight = visual.windowRect(4) - visual.windowRect(2);
  
  end
