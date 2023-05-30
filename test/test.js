const net = require('net');
const wav = require('node-wav');
const fs = require('fs');
const Speaker = require('speaker');

// Create a TCP server
const server = net.createServer((socket) => {
    console.log('Client connected');

    // Define the active speaker variable
    let activeSpeaker = null;

    // Handle data received from the client
    socket.on('data', async (data) => {
        const requestData = data.toString().trim();
        console.log('Data received from client:', requestData);
        try {
            if (requestData === 'function1') {
                stopCurrentPlayback(); // Stop the current playback before starting a new one
                await function1();
            } else if (requestData === 'function2') {
                stopCurrentPlayback(); // Stop the current playback before starting a new one
                await function2();
            } else {
                console.log('Unknown route:', requestData);
                socket.write('Unknown route');
            }
        } catch (error) {
            console.error('Error:', error);
            socket.write('Error occurred');
        }
    });

    // Handle client disconnection
    socket.on('end', () => {
        console.log('Client disconnected');
        stopCurrentPlayback();
    });

    // Stop the current playback
    function stopCurrentPlayback() {
        if (activeSpeaker) {
            activeSpeaker.end();
            activeSpeaker = null;
        }
    }

    // Define function1
    async function function1() {
        console.log('Function 1 activated');
        const audioData = fs.readFileSync('sine.wav');
        const audio = wav.decode(audioData);

        // Create a Speaker instance
        const speaker = new Speaker({
            channels: audio.channelData.length,
            sampleRate: audio.sampleRate,
            bitDepth: audio.bitDepth,
        });

        // Prepare the audio data for playback
        const audioBuffer = Buffer.from(audioData);

        // Set the active speaker
        activeSpeaker = speaker;

        // Pipe the audio data to the speaker
        await new Promise((resolve, reject) => {
            speaker.write(audioBuffer, (error) => {
                if (error) {
                    reject(error);
                } else {
                    resolve();
                }
            });
        });

        speaker.close(); // Close the speaker after playback
        activeSpeaker = null;
    }

    // Define function2
    async function function2() {
        console.log('Function 2 activated');
        const audioData = fs.readFileSync('jet.wav');
        const audio = wav.decode(audioData);

        // Create a Speaker instance
        const speaker = new Speaker({
            channels: audio.channelData.length,
            sampleRate: audio.sampleRate,
            bitDepth: audio.bitDepth,
        });

        // Prepare the audio data for playback
        const audioBuffer = Buffer.from(audioData);

        // Set the active speaker
        activeSpeaker = speaker;

        // Pipe the audio data to the speaker
        await new Promise((resolve, reject) => {
            speaker.write(audioBuffer, (error) => {
                if (error) {
                    reject(error);
                } else {
                    resolve();
                }
            });
        });

        speaker.close(); // Close the speaker after playback
        activeSpeaker = null;
    }
});

// Start the server
server.listen(3000, () => {
    console.log('Server is listening on port 3000');
});
