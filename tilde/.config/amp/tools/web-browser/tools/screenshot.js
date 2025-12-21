#!/usr/bin/env node

import { tmpdir } from "node:os";
import { join } from "node:path";
import puppeteer from "puppeteer-core";

const b = await puppeteer.connect({
  browserURL: "http://localhost:9222",
  defaultViewport: null,
});

const p = (await b.pages()).at(-1);

if (!p) {
  console.error("✗ No active tab found");
  process.exit(1);
}

const timestamp = new Date().toISOString().replace(/[:.]/g, "-");
const filename = `screenshot-${timestamp}.png`;
const filepath = join(tmpdir(), filename);

await p.screenshot({ path: filepath });

console.log(filepath);

await b.disconnect();
