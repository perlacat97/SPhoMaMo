%% Estrazione caratteristiche esperimento

close all
clear

angles = {
    '135sx' '1316'
    '90sx'  '1252'
    '45sx'  '1312'
    '0'     '1245'
    '45dx'  '1310'
    '90dx'  '1256'
    '135dx' '1306'
    '180'   '1302'
    };

pairs = {
    '01-ORTF SCHOEPS'
    '02-ORTF CM4'
    '03-XY90 CM4'
    '04-XY180 CM4'
    '05-AB 50cm OM1'
    };

cols = length(angles);
rows = length(pairs);

%% Acquisizione campioni
X_t = cell(rows, cols);
for row=1:rows
    for col=1:cols
        X_t{row, col} = gpuArray(audioread(sprintf("../audio/%1$s/%3$s-220201_%2$s.wav", angles{col, :}, pairs{row})));
    end
end

%% Ampiezze
figure(1);
for row=1:rows
    for col=1:cols
        subplot(rows, cols, (row-1)*cols+col);
        plot(hist(X_t{row, col}, 300));
        %axis([0 300 0 1.3e4]);
    end
end
label_things(rows, cols, pairs, angles);

%% Spettri
figure(2);
for row=1:rows
    for col=1:cols
        X = fft(X_t{row, col}, 2048);
        X = X(1:1024);
        subplot(rows, cols, (row-1)*cols+col);
        plot(20*log10(abs(X)));
    end
end
label_things(rows, cols, pairs, angles);

%% Sonogrammi
figure(3);
% rows = 1;
% cols = 5;
for row=1:rows
    for col=1:cols
        subplot(rows, cols, (row-1)*cols+col);
        [S, F, T] = stft(X_t{row, col}(:, 1)-X_t{row, col}(:, 2),96000,'Window',kaiser(256,5),'OverlapLength',220,'FFTLength',2048);
        image(F(length(F)/2:end), T, uint8(20*log10(abs(S(length(F)/2:end, :)))/144*128+128));
        colormap gray
    end
end
label_things(rows, cols, pairs, angles);


%% Definizioni
function label_things(rows, cols, pairs, angles)
ax = [];
for row=1:rows
    subplot(rows, cols, (row-1)*cols+1);
    ylabel(pairs{row});
    for col=1:cols
        ax_ = subplot(rows, cols, (row-1)*cols+col);
        ax = [ ax ax_ ];
        if col>1
            set(ax_, 'Ytick', []);
        end
        if row<rows
            set(ax_, 'XTick', []);
        end
    end
    linkaxes(ax, 'xy');
end
for col=1:cols
    subplot(rows, cols, col);
    title(angles{col});
    subplot(rows, cols, (rows-1)*cols+col);
end
end