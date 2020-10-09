// SuperCollider Examples

//boot server
s.boot;

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
}).play;
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
