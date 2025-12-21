#!/usr/bin/env node

import puppeteer from "puppeteer-core";

const url = process.argv[2];
const newTab = process.argv[3] === "--new";

if (!url) {
  console.log("Usage: nav.js <url> [--new]");
  console.log("\nExamples:");
  console.log("  nav.js https://example.com       # Navigate current tab");
  console.log("  nav.js https://example.com --new # Open in new tab");
  process.exit(1);
}

const b = await puppeteer.connect({
  browserURL: "http://localhost:9222",
  defaultViewport: null,
});

if (newTab) {
  const p = await b.newPage();
  await p.goto(url, { waitUntil: "domcontentloaded" });
  console.log("✓ Opened:", url);
} else {
  const p = (await b.pages()).at(-1);
  await p.goto(url, { waitUntil: "domcontentloaded" });
  console.log("✓ Navigated to:", url);
}

await b.disconnect();
