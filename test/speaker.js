const wav = require('node-wav');
const fs = require('fs');
const Speaker = require('speaker');

// Read the WAV audio file
const audioData = fs.readFileSync('sine.wav');
const audio = wav.decode(audioData);

// Create a Speaker instance
const speaker = new Speaker({
    channels: audio.channelData.length, // Number of audio channels
    sampleRate: audio.sampleRate, // Audio sample rate
    bitDepth: audio.bitDepth // Bit depth of the audio samples
});

// Prepare the audio data for playback
const audioBuffer = Buffer.from(audioData);

// Pipe the audio data to the speaker
speaker.end(audioBuffer);
