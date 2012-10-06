function nanonote_download(modelName,makertwObj)

disp(['### Downloading ', modelName, ' to Nanonote...']);

%assignin('base','makertwObj',makertwObj);
%TODO: parse the PROGRAM_FILE_EXT from target_tools.mk
if (ischar(makertwObj)) %String 'PIL'
	outfile = modelName;
else
	outfile = fullfile(makertwObj.BuildDirectory, [modelName, '.out']);
end

setenv('NANONOTE_EXE',outfile);
%TODO: pass args from PIL Launcher...
%setenv('NANONOTE_ARGS',this.ArgString);
setenv('NANONOTE_ARGS','');
setenv('NANONOTE_HOSTNAME',getpref('nanonote','HOSTNAME'));
!scp $NANONOTE_EXE $NANONOTE_HOSTNAME:/root

makertwArgs = makertwObj.BuildInfo.BuildArgs;
externalMode = 0;
for i=1:length(makertwArgs)
	if strcmp(makertwArgs(i).DisplayLabel,'EXT_MODE')
		externalMode = str2double(makertwArgs(i).Value);
	end
end
if externalMode
	setenv('NANONOTE_ARGS','-w'); %wait for Simulink to connect in external mode
	disp('Setting up external mode on Nanonote..');
end
%need to catch pid below to stop it later..
disp('Starting executable on Nanonote..');
!ssh -f $NANONOTE_HOSTNAME /root/`basename $NANONOTE_EXE` $NANONOTE_ARGS