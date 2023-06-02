function [] = untitled()
url = 'http://localhost:3000/playSound1';  % URL of the server

try
    options = weboptions('RequestMethod', 'get');
    webread(url, options);
    
    disp('GET request sent successfully.');

catch ME
    disp(['Error: ' ME.message]);
end

end

