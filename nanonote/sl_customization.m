function sl_customization(cm)
% SL_CUSTOMIZATION for Nanonote PIL connectivity config

cm.registerTargetInfo(@loc_createTcpipConfig);
% First build the mex file:
% cd (matlabroot)
% mex rtw/ext_mode/common/ext_comm.c ...
% rtw/ext_mode/common/ext_convert.c ...
% rtw/ext_mode/common/rtiostream_interface.c ...
% rtw/c/src/rtiostream/rtiostreamtcpip/rtiostream_tcpip.c ...
% -Irtw/c/src -Iextern/include -Irtw/c/src/rtiostream/utils ...
% -Irtw/c/src/ext_mode/common -Irtw/ext_mode/common ...
% -Irtw/ext_mode/common/include -DSL_EXT_SO -ldl ...
% -output toolbox/rtw/rtw/ext_comm  -lut -lmwrtiostreamutils ...
% -DEXTMODE_TCPIP_TRANSPORT
cm.ExtModeTransports.add('nanonote.tlc', 'TCP/IP', 'ext_comm', 'Level1');

% local function
function config = loc_createTcpipConfig

config = rtw.connectivity.ConfigRegistry;
config.ConfigName = 'Nanonote connectivity config using TCP/IP';
config.ConfigClass = 'nanonote.ConnectivityConfig';

% matching nanonote target file
config.SystemTargetFile = {'nanonote.tlc'};

% match nanonote template makefile
config.TemplateMakefile = {'nanonote.tmf'};

% match any hardware implementation
config.TargetHWDeviceType = {};