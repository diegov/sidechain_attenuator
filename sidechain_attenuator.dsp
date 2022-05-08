declare name "sidechain_attenuator";
declare description "Side-chain attenuator.";
declare license "MIT";
declare copyright "(c) 2022: Diego Veralli";

import("stdfaust.lib");

volume_slider = hslider("[unit:dB] Volume", 0, -70, 5, 1) : si.smoo;
threshold = hslider("[unit:dB] Threshold", -20, -70, 0, 1) : si.smoo;
att_factor = hslider("[unit:dB] Attenuation", -10, -70, 0, 1) : si.smoo;

process(sigl, sigr, chainl, chainr) = sigl * gain * volume, sigr * gain * volume
with {
  volume = volume_slider : ba.db2linear;
  amp = (chainl + chainr) / 2.0 : an.amp_follower_ar(0.075, 1.25);
  trigger = (amp : ba.linear2db) > threshold;
  att_env = en.adsr(0.1, 0.05, 1, 0.75, trigger);
  gain = 1.0 - (att_env * (1.0 - ba.db2linear(att_factor)));
};
