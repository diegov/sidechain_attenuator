declare name "sidechain_attenuator";
declare description "Side-chain attenuator.";
declare license "GPLv3";
declare copyright "(c) 2023: Diego Veralli";

import("stdfaust.lib");

bottom = -70;

volume_slider = hslider("[unit:dB] Volume", 0, bottom, 5, 1) : si.smoo;
threshold = hslider("[unit:dB] Threshold", -20, bottom, 0, 1) : si.smoo;
sidechain_level = hbargraph("[unit:dB] Sidechain Level", bottom,0);
att_factor = hslider("[unit:dB] Attenuation", -10, bottom, 0, 1) : si.smoo;

process(sigl, sigr, chainl, chainr) = sigl * gain * volume, attach(sigr * gain * volume, level)
with {
  volume = volume_slider : ba.db2linear;
  amp = (chainl + chainr) / 2.0 : an.amp_follower_ar(0.075, 1.25);
  amp_db = (amp : ba.linear2db);
  trigger = amp_db > threshold;
  level = (amp_db : sidechain_level);
  att_env = en.adsr(0.1, 0.05, 1, 0.75, trigger);
  gain = 1.0 - (att_env * (1.0 - ba.db2linear(att_factor)));
};
