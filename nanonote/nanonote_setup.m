function nanonote_setup()

curpath = pwd;
tgtpath = curpath(1:end-length('\nanonote'));
addpath(fullfile(tgtpath, 'nanonote'));
addpath(fullfile(tgtpath, 'demos'));
savepath;
disp('Ben NanoNote Target Path Setup Complete.');
if ispref('nanonote')
	rmpref('nanonote');
end
addpref('nanonote','TOOLCHAIN_PREFIX','/home/user/build/OpenWrt-Toolchain-xburst-for-mipsel-gcc-4.6-linaro_uClibc-0.9.33.2/toolchain-mipsel_gcc-4.6-linaro_uClibc-0.9.33.2/bin/mipsel-openwrt-linux-');
addpref('nanonote','STAGING_DIR','/home/user/build/OpenWrt-Toolchain-xburst-for-mipsel-gcc-4.6-linaro_uClibc-0.9.33.2/toolchain-mipsel_gcc-4.6-linaro_uClibc-0.9.33.2');
addpref('nanonote','HOSTNAME','ben');
addpref('nanonote','TargetRoot',curpath);

% External mode support
cd (matlabroot)
mex rtw/ext_mode/common/ext_comm.c ...
rtw/ext_mode/common/ext_convert.c ...
rtw/ext_mode/common/rtiostream_interface.c ...
rtw/c/src/rtiostream/rtiostreamtcpip/rtiostream_tcpip.c ...
-Irtw/c/src -Iextern/include -Irtw/c/src/rtiostream/utils ...
-Irtw/c/src/ext_mode/common -Irtw/ext_mode/common ...
-Irtw/ext_mode/common/include -DSL_EXT_SO -ldl ...
-output toolbox/rtw/rtw/ext_comm  -lut -lmwrtiostreamutils ...
-DEXTMODE_TCPIP_TRANSPORT
cd(curpath);