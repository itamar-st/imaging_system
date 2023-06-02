const net = require('net');
const wav = require('node-wav');
const fs = require('fs');
const Speaker = require('speaker');
let speaker = new Speaker();
// Read the WAV audio file

// Function 1
function function1() {
    console.log('Function 1 activated');

    // Add your function1 logic here
    const audioData = fs.readFileSync('sine.wav');
    const audio = wav.decode(audioData);
    // Create a Speaker instance
    speaker = new Speaker({
        channels: audio.channelData.length, // Number of audio channels
        sampleRate: audio.sampleRate, // Audio sample rate
        bitDepth: audio.bitDepth // Bit depth of the audio samples
    });

    // Prepare the audio data for playback
    const audioBuffer = Buffer.from(audioData);

    // Pipe the audio data to the speaker
    speaker.end(audioBuffer);

}

// Function 2
function function2() {
    console.log('Function 2 activated');
    // Add your function1 logic here
    const audioData = fs.readFileSync('jet.wav');
    const audio = wav.decode(audioData);
    // Create a Speaker instance
    speaker = new Speaker({
        channels: audio.channelData.length, // Number of audio channels
        sampleRate: audio.sampleRate, // Audio sample rate
        bitDepth: audio.bitDepth // Bit depth of the audio samples
    });

    // Prepare the audio data for playback
    const audioBuffer = Buffer.from(audioData);

    // Pipe the audio data to the speaker
    speaker.end(audioBuffer);

}
function stopPlayback() {
    // Stop playing the audio buffer
    speaker.end();
}

// Create a TCP server
const server = net.createServer((socket) => {
    console.log('Client connected');

    // Event handler for data received from the client
    socket.on('data', (data) => {
        const receivedData = data.toString().trim();
        console.log('Received data:', receivedData);

        // Check the received content and activate function1 if it matches
        if (receivedData === 'function1') {
            stopPlayback();
            function1();
        }
        if (receivedData === 'function2') {
            stopPlayback();
            function2();
        }
    });

    // Event handler for client disconnection
    socket.on('end', () => {
        console.log('Client disconnected');
    });
});

// Start the server on port 3000
server.listen(3000, () => {
    console.log('Server listening on port 3000');
});
