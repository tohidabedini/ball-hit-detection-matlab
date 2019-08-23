recObj =audiorecorder(48000,8,1);
disp('Start');

fcuts = [9900 10000  20000 20200];
mags = [0 1 0];
devs = [0.01 0.05 0.01];

sum_past_past = 100;
sum_past = 100;
sum_present = 100 ;

num=0;

while(true)
	recordblocking(recObj,.3);
	y=getaudiodata(recObj);


	[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,48000);
	hh = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');

	filteredSignal = filter(hh,1,y);

	sum_past_past = sum_past;
	sum_past = sum_present;
	sum_present=sum(abs(filteredSignal(:)));
	%plot(filteredSignal);
	if(sum_past > 1.5 * sum_present && sum_past > sum_past_past && sum_past > 30)

		disp("Hit!!!!");
		disp(num);
		num=num+1;

	end
 
end