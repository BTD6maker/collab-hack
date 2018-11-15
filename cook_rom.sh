rm collab_hack.smc
rm -R Levels/
mkdir Levels

# free up space in fresh ROM
cp yi.smc collab_hack.smc
cd graphics
winpty ./ycompress.exe 1 120200 ../collab_hack.smc cleangfx-cleaned.bin
cd ../asm
./asar.exe free_space.asm ../collab_hack.smc
./asar.exe prevent_freespace.asm ../collab_hack.smc

# patch roms and extract levels
cd ../complete_ipss
sh all_levels.sh

# insert into rom
cd ..
./LevelTool.exe -i collab_hack.smc

# apply all ASM
cd asm
./asar.exe level.asm ../collab_hack.smc
./asar.exe revert_FFs.asm ../collab_hack.smc

# non-freespace
./asar.exe entrance_data.asm ../collab_hack.smc
./asar.exe better_midrings.asm ../collab_hack.smc

# cook BPS
cd ..
complete_ipss/flips.exe --create yi.smc collab_hack.smc collab_hack.bps
