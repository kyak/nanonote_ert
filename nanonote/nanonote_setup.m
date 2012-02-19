function nanonote_setup()

curpath = pwd;
tgtpath = curpath(1:end-length('\nanonote'));
addpath(fullfile(tgtpath, 'nanonote'));
addpath(fullfile(tgtpath, 'demos'));
savepath;
disp('Ben NanoNote Target Path Setup Complete.');
addpref('nanonote','TOOLCHAIN_PREFIX','/home/user/build/openwrt-xburst/staging_dir/toolchain-mipsel_gcc-4.5-linaro_uClibc-0.9.32/bin/mipsel-openwrt-linux-');
addpref('nanonote','HOSTNAME','ben');