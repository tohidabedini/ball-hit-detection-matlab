recObj =audiorecorder(48000,8,1);
disp('Start');

fcuts = [11000 11100  23800 23900];

mags = [0 1 0];
devs = [0.01 0.05 0.01];

while(true)
	recordblocking(recObj,.2);
	y=getaudiodata(recObj);

	[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,48000);
	hh = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');

	filteredSignal = filter(hh,1,y);

	s=sum(abs(filteredSignal(:)));
	plot(filteredSignal);

	if(s>35)
		disp("Hit!!!!");
		disp(s);
	end
    
end