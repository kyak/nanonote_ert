function nanonote_make_rtw_hook(hookMethod,modelName,~,~,~,~)

  switch hookMethod
   case 'error'
    % Called if an error occurs anywhere during the build.  If no error occurs
    % during the build, then this hook will not be called.  Valid arguments
    % at this stage are hookMethod and modelName. This enables cleaning up
    % any static or global data used by this hook file.
    disp(['### Real-Time Workshop build procedure for model: ''' modelName...
          ''' aborted due to an error.']);
      
   case 'entry'
    % Called at start of code generation process (before anything happens.)
    % Valid arguments at this stage are hookMethod, modelName, and buildArgs.
    nanonote_entry(modelName);
    
   case 'before_tlc'
    % Called just prior to invoking TLC Compiler (actual code generation.)
    % Valid arguments at this stage are hookMethod, modelName, and
    % buildArgs
    
   case 'after_tlc'
    % Called just after to invoking TLC Compiler (actual code generation.)
    % Valid arguments at this stage are hookMethod, modelName, and
    % buildArgs

   case {'before_make','before_makefilebuilder_make'}
    % Called after code generation is complete, and just prior to kicking
    % off make process (assuming code generation only is not selected.)  All
    % arguments are valid at this stage.
    nanonote_prefs_makefile;

   case 'after_make'
    % Called after make process is complete. All arguments are valid at 
    % this stage.
    
   case 'exit'
    % Called at the end of the RTW build process.  All arguments are valid
    % at this stage.
    
    disp(['### Successful completion of Real-Time Workshop build ',...
          'procedure for model: ', modelName]);
      
  end

function nanonote_entry(modelName)

disp(['### Starting Ben NanoNote build procedure for ', ...
      'model: ',modelName]);

TOOLCHAIN_PREFIX = getpref('nanonote','TOOLCHAIN_PREFIX');
HOSTNAME = getpref('nanonote','HOSTNAME');

% Display current settings in build log
disp('###')
disp('### Ben NanoNote environment settings:')
disp('###')
fprintf('###     TOOLCHAIN_PREFIX:       %s\n', TOOLCHAIN_PREFIX)
fprintf('###     HOSTNAME:       %s\n', HOSTNAME)
disp('###')

function nanonote_prefs_makefile

TOOLCHAIN_PREFIX = getpref('nanonote','TOOLCHAIN_PREFIX');
HOSTNAME = getpref('nanonote','HOSTNAME');

% Write out the makefile
makefileName = 'nanonote_prefs.mk';
fid = fopen(makefileName,'w');
fwrite(fid, sprintf('%s\n\n', '# Ben NanoNote build preferences'));
fwrite(fid, sprintf('TOOLCHAIN_PREFIX=%s\n', TOOLCHAIN_PREFIX));
fwrite(fid, sprintf('HOSTNAME=%s\n', HOSTNAME));
fclose(fid);