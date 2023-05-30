% Create a TCP/IP client object
client = tcpip('localhost', 3000);
client.Timeout = 10; % Set a timeout value (in seconds)

% Connect to the server
fopen(client);

% Send data to the server
requestData = 'function1';
fwrite(client, requestData);

% Close the connection
fclose(client);
