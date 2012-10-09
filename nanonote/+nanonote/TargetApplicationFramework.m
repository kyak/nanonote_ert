classdef TargetApplicationFramework < rtw.pil.RtIOStreamApplicationFramework
%TARGETAPPLICATIONFRAMEWORK is Nanonote application framework for PIL
  
    methods
        % constructor
        function this = TargetApplicationFramework(componentArgs)
            error(nargchk(1, 1, nargin, 'struct'));
            % call super class constructor
            this@rtw.pil.RtIOStreamApplicationFramework(componentArgs);
            
            % INSERT YOUR CODE HERE TO CUSTOMIZE THE CONNECTIVITY
            % CONFIGURATION FOR YOUR TARGET

            % To build the PIL application you must specify a main.c file.       %UNCOMMENT
            % The following PIL main.c files are provided and can be             %UNCOMMENT
            % added to the application framework via the "addPILMain"            %UNCOMMENT    
            % method:                                                            %UNCOMMENT
            %                                                                    %UNCOMMENT
            % 1) A main.c adapted for on-target PIL and suitable                 %UNCOMMENT
            %    for most PIL implementations. Select by specifying              %UNCOMMENT
            %    'target' argument to "addPILMain" method.                       %UNCOMMENT
            %                                                                    %UNCOMMENT
            % 2) A main.c adapted for host-based PIL such as the                 %UNCOMMENT
            %    "mypil" host example. Select by specifying 'host'               %UNCOMMENT
            %    argument to "addPILMain" method.                                %UNCOMMENT
            this.addPILMain('target');                                             %UNCOMMENT
                                                                                 %UNCOMMENT
            % Additional source and library files to include in the build        %UNCOMMENT
            % must be added to the BuildInfo property                            %UNCOMMENT
                                                                                 %UNCOMMENT
            % Get the BuildInfo object to update                                 %UNCOMMENT
            buildInfo = this.getBuildInfo;                                       %UNCOMMENT
                                                                                 %UNCOMMENT
            % Add device driver files to implement the target-side of the        %UNCOMMENT
            % host-target rtIOStream communications channel                      %UNCOMMENT
            buildInfo.addSourceFiles([matlabroot,...
				'/rtw/c/src/rtiostream/rtiostreamtcpip/rtiostream_tcpip.c']);
                                                                                 %UNCOMMENT          
        end
    end
end
