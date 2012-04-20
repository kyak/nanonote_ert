function nanonote_setup()

curpath = pwd;
tgtpath = curpath(1:end-length('\nanonote'));
addpath(fullfile(tgtpath, 'nanonote'));
addpath(fullfile(tgtpath, 'demos'));
savepath;
disp('Ben NanoNote Target Path Setup Complete.');
%TODO check if pref already exists
addpref('nanonote','TOOLCHAIN_PREFIX','/home/user/build/openwrt-xburst/staging_dir/toolchain-mipsel_gcc-4.6-linaro_uClibc-0.9.33/bin/mipsel-openwrt-linux-');
addpref('nanonote','STAGING_DIR','/home/user/build/openwrt-xburst/staging_dir/toolchain-mipsel_gcc-4.6-linaro_uClibc-0.9.33');
addpref('nanonote','HOSTNAME','ben');