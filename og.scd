


//boot server
s.boot;

// ########################

(
var number;
number = 3.cubed;
number = number + number;
number = number + 1;
)

// ########################
x = {MiBraids.ar}.play;
x = {SinOsc.ar}.play;
x.free;
y = {SinOsc.ar(880)}.play;
y.free;


// ########################

(
y = {SinOsc.ar};
z= y.play;
)
// ########################

i = {SinOsc.ar(1000)}.play;

// ########################

(
j.free;
i.free;
y.free;
z.free;
)
