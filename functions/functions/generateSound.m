function vr = generateSound(vr,freq)
url = strcat('http://localhost:3000/playSound',int2str(freq));
%url = 'http://localhost:3000/playSound1600';
try
    options = weboptions('RequestMethod', 'get');
    webread(url, options);
    
    disp('GET request sent successfully from generateSound.');

catch ME
    disp(['Error: ' ME.message]);
end

end
