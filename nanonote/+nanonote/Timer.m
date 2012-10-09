classdef Timer < rtw.connectivity.Timer
	methods
		
		function this = Timer
			
			% Configure data type returned by timer reads
			this.setTimerDataType('uint32');
			
			% What profileTimerRead() function returns
			ticksPerSecond = 1e6;
			this.setTicksPerSecond(ticksPerSecond);
			
			% The timer counts upwards
			this.setCountDirection('up');
			
			% Configure source files required to access the timer
			headerFile = fullfile(getpref('nanonote','TargetRoot'),...
				'profile','nanonote_timer.h');
			
			timerSourceFile = fullfile(getpref('nanonote','TargetRoot'),...
				'profile','nanonote_timer.c');
			
			this.setSourceFile(timerSourceFile);
			this.setHeaderFile(headerFile);
			
			% Configure the expression used to read the timer
			readTimerExpression = 'profileTimerRead()';
			this.setReadTimerExpression(readTimerExpression);
			
		end
	end
end
