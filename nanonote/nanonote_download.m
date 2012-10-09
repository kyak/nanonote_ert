function nanonote_download(modelName,makertwObj)

disp(['### Downloading ', modelName, ' to Nanonote...']);

%assignin('base','makertwObj',makertwObj);
%TODO: parse the PROGRAM_FILE_EXT from target_tools.mk
if (ischar(makertwObj)) %String 'PIL'
	outfile = modelName;
	externalMode = 0;
else
	outfile = fullfile(makertwObj.BuildDirectory, [modelName, '.out']);
	
	makertwArgs = makertwObj.BuildInfo.BuildArgs;
	
	for i=1:length(makertwArgs)
		if strcmp(makertwArgs(i).DisplayLabel,'EXT_MODE')
			externalMode = str2double(makertwArgs(i).Value);
		end
	end
end

setenv('NANONOTE_EXE',outfile);
%TODO: pass args from PIL Launcher...
%setenv('NANONOTE_ARGS',this.ArgString);
setenv('NANONOTE_ARGS','');
setenv('NANONOTE_HOSTNAME',getpref('nanonote','HOSTNAME'));

if externalMode
	disp('### Setting up external mode on Nanonote..');
	setenv('NANONOTE_ARGS','-w'); %wait for Simulink to connect in external mode
	%disp('Killing previous external mode executables on Nanonote..');
	!ssh $NANONOTE_HOSTNAME killall `basename $NANONOTE_EXE`
end

!scp $NANONOTE_EXE $NANONOTE_HOSTNAME:/root

%need to catch pid below to stop it later..
disp('### Starting executable on Nanonote..');
!ssh -f $NANONOTE_HOSTNAME /root/`basename $NANONOTE_EXE` $NANONOTE_ARGS