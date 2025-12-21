#!/usr/bin/env node

import puppeteer from "puppeteer-core";

const code = process.argv.slice(2).join(" ");
if (!code) {
  console.log("Usage: eval.js 'code'");
  console.log("\nExamples:");
  console.log('  eval.js "document.title"');
  console.log("  eval.js \"document.querySelectorAll('a').length\"");
  process.exit(1);
}

const b = await puppeteer.connect({
  browserURL: "http://localhost:9222",
  defaultViewport: null,
});

const p = (await b.pages()).at(-1);

if (!p) {
  console.error("✗ No active tab found");
  process.exit(1);
}

let result;

try {
  result = await p.evaluate((c) => {
    const AsyncFunction = (async () => {}).constructor;
    return new AsyncFunction(`return (${c})`)();
  }, code);
} catch (e) {
  console.log("Failed to evaluate expression");
  console.log(`  Expression: ${code}`);
  console.log(e);
  process.exit(1);
}

if (Array.isArray(result)) {
  for (let i = 0; i < result.length; i++) {
    if (i > 0) console.log("");
    for (const [key, value] of Object.entries(result[i])) {
      console.log(`${key}: ${value}`);
    }
  }
} else if (typeof result === "object" && result !== null) {
  for (const [key, value] of Object.entries(result)) {
    console.log(`${key}: ${value}`);
  }
} else {
  console.log(result);
}

await b.disconnect();
