// Entry program for bring-the-humans-03 (Node 22, standard library only).
// The entry is the TikTok video itself: this program only hands its address
// to the grader by copying VIDEO.json from the repository root to /output.
// The video's views on TikTok are the score; nothing this program writes
// about the video is scored.
//
// Run locally:
//   mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts

import { copyFileSync, mkdirSync } from 'node:fs';
import { join } from 'node:path';

const BOT_DIR = process.env.MAKEFUN_BOT_DIR ?? '/bot';
const OUTPUT_DIR = process.env.MAKEFUN_OUTPUT_DIR ?? '/output';

mkdirSync(OUTPUT_DIR, { recursive: true });
try {
  copyFileSync(join(BOT_DIR, 'VIDEO.json'), join(OUTPUT_DIR, 'VIDEO.json'));
} catch (err) {
  console.error(`could not copy VIDEO.json from ${BOT_DIR}: ${(err as Error).message}`);
  process.exit(1);
}
