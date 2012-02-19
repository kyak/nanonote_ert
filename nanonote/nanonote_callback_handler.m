function nanonote_callback_handler(hDlg, hSrc)

% Setup the hardware configuration
slConfigUISetVal(hDlg, hSrc, 'ProdHWDeviceType', 'Generic->32-bit Embedded Processor');
        
% Set the target language to C and disable modification
slConfigUISetVal(hDlg, hSrc, 'TargetLang', 'C');
slConfigUISetEnabled(hDlg, hSrc, 'TargetLang', 0);

% Use our own ert_main.c
slConfigUISetVal(hDlg, hSrc, 'ERTCustomFileTemplate', 'nanonote_srmain.tlc');
slConfigUISetVal(hDlg, hSrc, 'GenerateSampleERTMain', 'off');

% Nanonote is Little Endian
slConfigUISetVal(hDlg, hSrc, 'ProdEndianess', 'LittleEndian');

% The target is model reference compliant
slConfigUISetVal(hDlg, hSrc, 'ModelReferenceCompliant', 'on');
slConfigUISetEnabled(hDlg, hSrc, 'ModelReferenceCompliant', false);