//const puppeteer = require('puppeteer');

//(async () => {
  //  try {
        // Launch a headless browser
   //     const browser = await puppeteer.launch({headless: false});

        // Open a new page
  //      const page = await browser.newPage();

        // Navigate to the web page
    //    await page.goto('C:\\Users\\Duser\\Desktop\\server\\web\\index.html');

        // Click on the "Play Sound 1" button
      //  await page.click('button[onclick="playSound1()"]');

        // Wait for 2 seconds
       // await page.waitForTimeout(2000);

        // Click on the "Play Sound 2" button
       // await page.click('button[onclick="playSound2()"]');

        // Wait for 2 seconds
        //await page.waitForTimeout(2000);

        // Click on the "Stop" button
        //await page.click('button[onclick="stopSounds()"]');

        // Close the browser
        //await browser.close();
    //} catch (error) {
      //  console.error('Error:', error);
    //}
//})();


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
        await page.goto('C:\\Users\\Duser\\Desktop\\server\\web\\index.html');

        console.log('Server is ready');
    } catch (error) {
        console.error('Error:', error);
        process.exit(1); // Terminate the process if an error occurs
    }
})();

app.get('/playSound1', async (req, res) => {
    await page.evaluate(() => {
        playSound1();
    });
    res.sendStatus(200);
});

app.get('/playSound2', async (req, res) => {
    await page.evaluate(() => {
        playSound2();
    });
    res.sendStatus(200);
});
//app.get('/playSound2', async (req, res) => {
  //  await page.click('button[onclick="playSound2()"]')
   // res.sendStatus(200);
//});

app.get('/stopSounds', async (req, res) => {
    await page.evaluate(() => {
        stopSounds();
    });
    res.sendStatus(200);
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
