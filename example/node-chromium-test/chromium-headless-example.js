const puppeteer = require('puppeteer');


async function sleep(time) {
    return new Promise(function (resolve, reject) {
        setTimeout(function () {
            // 返回 ‘ok’
            resolve('ok');
        }, time * 1000);
    })
}

const extensions_dir="";
(async () => {
    const browser = await puppeteer.launch(
        {
            headless: true,
            devtools: false,
            executablePath: __dirname+'/../chrome-linux/chrome' ,
            args: [
                '--use-gl=egl',
                '--no-sandbox',
                '--disable-dev-shm-usage',
                '--start-maximized',
                `--load-extension=${extensions_dir}`,
                '--enable-remote-extensions',
                '--enable-extensions',
            ],
            ignoreDefaultArgs: [
                '--enable-automation',
                '--mute-audio',
                '--disable-extensions',
            ],
            timeout: 15000,
            dumpio: true
        }
    );
    const page = await browser.newPage();
    await page.setJavaScriptEnabled(true);
    await page.setViewport({width: 1920, height: 1080});
    await page.goto('https://www.baidu.com');
    await page.screenshot({ path: 'example.png' });
    //await sleep(100000);
    await browser.close();
})();