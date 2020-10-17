// SuperCollider Examples

// ###################################
// :SCNvimStart start server
// Ctrl + e
// Don't forget to boot

// ###################################

//boot server
s.boot;


// Examples


(
var number;
number = 3.cubed;
number = number + number;
number = number + 1;
)

x = {SinOsc.ar}.play;
x.free;

y = {SinOsc.ar};
z= y.play;
z.free;

x = {SinOsc.ar(700)}.play;
x.free;
////////////////////////////////////////////////

// SC as system for sound synthesis and sound processing
NetAddr.langPort;
NetAddr.localAddr
// patching synth moduls by writing synth defs:
(
n = NetAddr.new("127.0.0.1", 57210);    // create the NetAddr
// create the OSCFunc
o = OSCFunc({ arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln; }, '/goodbye', n);
o.free;
)
(
SynthDef("mod", {
	var sig, resfreq;
	sig = SinOsc.ar(440);
	Out.ar(0, sig);
}).add;
)


(
SynthDef(\sines, {arg out = 0, release_dur, gate =1, amp = 0.2;
	var sines, env;
	env = EnvGen.kr(Env.asr(0.01, amp, release_dur), gate, doneAction:2);
	sines = SinOsc.ar(852, 0, 2.2)+SinOsc.ar(1633, 0, 2.2);
	Out.ar(out, sines * env);
}).add
)

(

t = Task({{
	var a;
	a =  Synth.new(\sines, [\release_dur, 5, \out, 0, \amp, 0.2, \gate, 1]);
	1.wait;
	a.set(\gate, 0);
	1.wait;
}.loop});

t.play;

)

OSCFunc.trace(true); // Turn posting on
OSCFunc.trace(false); // Turn posting off


// --------- SC: a powerful expressive DSP language:

(
30.do { arg i;
	{ Pan2.ar(
		SinOsc.ar(exprand(100.0, 3000.0) * LFNoise2.kr(rrand(0.1, 0.2)).range(0.95, 1.1), 0,
		LFNoise2.kr(rrand(0.3, 0.7)).range(0,0.5) ** 4),
		1.0.rand2)
	}.play
}
)
{
	({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 14)
	* 400 + 500, 0.03, 0.003)}!2)
	+ ({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 20)
	* 800 + 1000, 0.03, 0.005)}!2)
	* 4
}.play;
// plot ecnvelopes
a = Env.perc(0.05, 1, 1, -4);
b = a.delay(2);
a.test.plot;
b.test.plot;

a = Env([0.5, 1, 0], [1, 1]).plot;
a.delay(1).plot;

// examples asStream function
(
{
	e = Env.sine.asStream;
	5.do({
		e.next.postln;
		0.25.wait;
	})}.fork
)
