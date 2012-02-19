classdef ConnectivityConfig < rtw.connectivity.Config
%CONNECTIVITYCONFIG is Nanonote PIL configuration class

    methods
        % Constructor
        function this = ConnectivityConfig(componentArgs)
            
            % An executable framework specifies additional source files and
            % libraries required for building the PIL executable
            targetApplicationFramework = ...
                nanonote.TargetApplicationFramework(componentArgs);
            
            % Filename extension for executable on the target system (e.g.
            % '.exe' for Windows or '' for Unix
            if ispc
                exeExtension = '.exe';
            else
                exeExtension = '.out';
            end
            
            % Create an instance of MakefileBuilder; this works in
            % conjunction with your template makefile to build the PIL
            % executable
            builder = rtw.connectivity.MakefileBuilder(componentArgs, ...
                targetApplicationFramework, ...
                exeExtension);
            
            % Launcher
            launcher = nanonote.Launcher(componentArgs, builder);
            
            % File extension for shared libraries (e.g. .dll on Windows)
            sharedLibExt=system_dependent('GetSharedLibExt'); 

            % Evaluate name of the rtIOStream shared library
            if ispc
                prefix = '';
            else
                prefix='libmw';
            end
            rtiostreamLib = [prefix 'rtiostreamtcpip' sharedLibExt];
            
            hostCommunicator = rtw.connectivity.RtIOStreamHostCommunicator(...
                componentArgs, ...
                launcher, ...
                rtiostreamLib);
            
            % For some targets it may be necessary to set a timeout value
            % for initial setup of the communications channel. For example,
            % the target processor may take a few seconds before it is
            % ready to open its side of the communications channel. If a
            % non-zero timeout value is set then the communicator will
            % repeatedly try to open the communications channel until the
            % timeout value is reached.
            hostCommunicator.setInitCommsTimeout(0); 
            
            % Configure a timeout period for reading of data by the host 
            % from the target. If no data is received with the specified 
            % period an error will be thrown.
            timeoutReadDataSecs = 60;
            hostCommunicator.setTimeoutRecvSecs(timeoutReadDataSecs);
            
            % INSERT YOUR CODE HERE TO CUSTOMIZE THE CONNECTIVITY 
            % CONFIGURATION FOR YOUR TARGET. ALTERNATIVELY UNCOMMENT THE 
            % FOLLOWING LINES TO IMPLEMENT A HOST-BASED EXAMPLE. TO 
            % UNCOMMENT LINES IN THE MATLAB EDITOR, SELECT THE LINES AND
            % ENTER CTRL-T.
            
            % Specify a fixed TCP/IP port number (for both host and
            % target)                                                
            portNumStr = '17725';  % cubed root of pi   

            % Specify additional arguments when starting the           %UNCOMMENT
            % executable (this configures the target-side of the       %UNCOMMENT
            % communications channel)                                  %UNCOMMENT
            launcher.setArgString(['-port ' portNumStr ' -blocking 1'])%UNCOMMENT

            % Custom arguments that will be passed to the              
            % rtIOStreamOpen function in the rtIOStream shared        
            % library (this configures the host-side of the           
            % communications channel)                                  
            rtIOStreamOpenArgs = {...                                  
                '-hostname', getpref('nanonote','HOSTNAME'), ...                         
                '-client', '1', ...                                    
                '-blocking', '1', ...                                  
                '-port',portNumStr,...                                 
                };                                                     
                      
            hostCommunicator.setOpenRtIOStreamArgList(...          
                rtIOStreamOpenArgs); 

            
            % call super class constructor to register components
            this@rtw.connectivity.Config(componentArgs,...
                                         builder,...
                                         launcher,...
                                         hostCommunicator);
            
            % Optionally, you can register a hardware-specific timer. Registering a timer
            % enables the code execution profiling feature. In this example
            % implementation, we use a timer for the host platform.
            timer = rtw.pil.HostTimer;
            this.setTimer(timer);
            
        end
    end
end

