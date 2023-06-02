% Define the server's IP address and port
serverIP = '127.0.0.1';  % Replace with the actual server IP address
serverPort = 3000;       % Replace with the actual server port

% Create a TCP/IP client object
tcpClient = tcpip(serverIP, serverPort);

% Connect to the server
fprintf('Connecting to the server...\n');
fopen(tcpClient);
fprintf('Connected to the server.\n');

% Send data to the server
dataToSend = 'function1';
fprintf('Sending data: %s\n', dataToSend);
fwrite(tcpClient, dataToSend);

% Close the connection
%fclose(tcpClient);
%delete(tcpClient);
%clear tcpClient;
%fprintf('Connection closed.\n');
