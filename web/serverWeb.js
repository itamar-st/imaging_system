const puppeteer = require('puppeteer');

(async () => {
    try {
        // Launch a headless browser
        const browser = await puppeteer.launch({headless: false});

        // Open a new page
        const page = await browser.newPage();

        // Navigate to the web page
        await page.goto('C:\\Users\\Duser\\Desktop\\server\\web\\index.html');

        // Click on the "Play Sound 1" button
        await page.click('button[onclick="playSound1()"]');

        // Wait for 2 seconds
        await page.waitForTimeout(2000);

        // Click on the "Play Sound 2" button
        await page.click('button[onclick="playSound2()"]');

        // Wait for 2 seconds
        await page.waitForTimeout(2000);

        // Click on the "Stop" button
        await page.click('button[onclick="stopSounds()"]');

        // Close the browser
        await browser.close();
    } catch (error) {
        console.error('Error:', error);
    }
})();
