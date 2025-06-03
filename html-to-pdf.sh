#!/bin/bash

# Puppeteer yüklü mü kontrol et
if ! npm list puppeteer >/dev/null 2>&1; then
  echo "Puppeteer bulunamadı, yükleniyor..."
  npm install puppeteer
fi

for file in *.html; do
  if [ -f "$file" ]; then
    filename="${file%.*}"
    echo "Converting $file to ${filename}.pdf ..."
    node -e "
      const puppeteer = require('puppeteer');
      (async () => {
        const browser = await puppeteer.launch();
        const page = await browser.newPage();
        await page.goto('file://' + process.cwd() + '/$file', { waitUntil: 'networkidle0' });
        await page.pdf({ path: '${filename}.pdf', format: 'A4', printBackground: true });
        await browser.close();
        console.log('Created ${filename}.pdf');
      })();
    "
  fi
done
