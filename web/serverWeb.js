


const express = require('express');
const puppeteer = require('puppeteer');

const app = express();

let page; // Declare the 'page' variable

(async () => {
    try {
        // Launch a headless browser
        const browser = await puppeteer.launch({ headless: false });

        // Open a new page
        page = await browser.newPage();

        // Navigate to the web page
        const path = require('path');
        const filePath = path.join(__dirname, 'index.html');
        await page.goto(`file://${filePath}`);
        //await page.goto('C:\\Users\\user\\Desktop\\imaging_system\\ViRMEn 2016-02-12\\sound_server\\index.html');

        console.log('Server is ready');
    } catch (error) {
        console.error('Error:', error);
        process.exit(1); // Terminate the process if an error occurs
    }
})();

app.get('/playSound1000', async (req, res) => {
    await page.evaluate(() => {
        playSound(0);;
    });
    res.sendStatus(200);
});

app.get('/playSound1200', async (req, res) => {
    await page.evaluate(() => {
        playSound(1);
    });
    res.sendStatus(200);
});
//app.get('/playSound2', async (req, res) => {
  //  await page.click('button[onclick="playSound2()"]')
   // res.sendStatus(200);
//});

app.get('/playSound1400', async (req, res) => {
    await page.evaluate(() => {
        playSound(2);
    });
    res.sendStatus(200);
});
app.get('/playSound1600', async (req, res) => {
    await page.evaluate(() => {
        playSound(3);
    });
    res.sendStatus(200);
});
app.get('/playSound1800', async (req, res) => {
    await page.evaluate(() => {
        playSound(4);
    });
    res.sendStatus(200);
});
app.get('/playSound2000', async (req, res) => {
    await page.evaluate(() => {
        playSound(5);
    });
    res.sendStatus(200);
});
app.get('/playSound2200', async (req, res) => {
    await page.evaluate(() => {
        playSound(6);
    });
    res.sendStatus(200);
});
app.get('/playSound2400', async (req, res) => {
    await page.evaluate(() => {
        playSound(7);
    });
    res.sendStatus(200);
});
app.get('/playSound2600', async (req, res) => {
    await page.evaluate(() => {
        playSound(8);
    });
    res.sendStatus(200);
});
app.get('/playSound2800', async (req, res) => {
    await page.evaluate(() => {
        playSound(9);
    });
    res.sendStatus(200);
});
app.get('/playSound3000', async (req, res) => {
    await page.evaluate(() => {
        playSound(10);
    });
    res.sendStatus(200);
});
app.get('/playSound3200', async (req, res) => {
    await page.evaluate(() => {
        playSound(11);
    });
    res.sendStatus(200);
});

app.get('/playSound3400', async (req, res) => {
    await page.evaluate(() => {
        playSound(12);
    });
    res.sendStatus(200);
});

app.get('/playSound5000', async (req, res) => {
    await page.evaluate(() => {
        playSound(13);
    });
    res.sendStatus(200);
});

app.get('/stopSounds', async (req, res) => {
    await page.evaluate(() => {
        stopSounds();
    });
    res.sendStatus(200);
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
