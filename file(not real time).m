
recObj = dsp.AudioFileReader('1.mp3','SamplesPerFrame',4800);
disp('Start');
m = 1;
while ~isDone(recObj)
	y= recObj();
	y = y(:,1);

	fcuts = [9900 10000  20000 20200];
	mags = [0 1 0];
	devs = [0.01 0.05 0.01];

	[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,48000);
	hh = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');

	filteredSignal = filter(hh,1,y);


	s=sum(abs(filteredSignal(:)));

	plot(filteredSignal);

	if(s>6)
		disp("Hit!!!!");
		disp(m*0.1);
	end
		m= m+1;
end

