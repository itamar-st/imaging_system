function vr = stopSound(vr)
url = 'http://localhost:3000/stopSounds';
try
    options = weboptions('RequestMethod', 'get');
    webread(url, options);
    
    disp('GET request sent successfully.');

catch ME
    disp(['Error: ' ME.message]);
end

end

