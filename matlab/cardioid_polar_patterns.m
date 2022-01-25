%% Dynamic view of cardioid mics mixes
close all

%% Plot
plot_(.5);

%%
uif = uifigure(1);
b = uislider(uif,...
    'Value', .5,...
    'Limits', [0 1],...
    'ValueChangingFcn', @(sld, evt) update_plot(evt));


function update_plot(sld)
plot_(sld.Value);
end

function plot_(p)
func = @(x)(p+(1-p)*cos(x-pi/4));
x = 0:.01:2*pi;
y = func(x);

figure(1);
f1 = subplot(1, 2, 1);
plot(f1, x, y);
axis([0 2*pi -1.2 1.2]);

f2 = subplot(1, 2, 2, polaraxes);
polarplot(f2, x(y>0), y(y>0));
hold on
polarplot(f2, x(y<0), -y(y<0));
f2.ThetaZeroLocation = 'top';
axis([0 360 0 1.2])
end