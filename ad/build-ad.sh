#!/bin/bash
# Build the make.fun TikTok ad (1080x1920, 24s) for bring-the-humans-03.
# Original creative, made in-session: hook-first kinetic-text ad, voiceover by
# edge-tts, press-pack illustrations/screenshots, brand badge + referral end
# card per the press guide. Referral code jn2a21q6, play code in caption only.
set -euo pipefail
A="$HOME/workspace/makefun/bth03-assets"
E="$HOME/workspace/makefun/bring-the-humans-03-entry"
FONT_XB="$A/Inter-ExtraBold.ttf"
FONT_B="$A/Inter-Bold.ttf"
FONT_MONO="$A/JetBrainsMono-Bold.ttf"
CODE="jn2a21q6"
cd "$A"

# --- Segment A (0-3.6s): hook ---------------------------------------------
ffmpeg -y -v error -f lavfi -i "color=c=0x191419:s=1080x1920:r=30:d=3.6" \
  -loop 1 -t 3.6 -i "$A/ghost-laptop-recording.png" -filter_complex \
"[1:v]scale=620:-1[img];[0:v][img]overlay=(W-w)/2:420, \
drawtext=fontfile=$FONT_XB:text='STOP ASKING':fontsize=96:fontcolor=white:x=(w-text_w)/2:y=980, \
drawtext=fontfile=$FONT_XB:text='YOUR AI TO':fontsize=96:fontcolor=white:x=(w-text_w)/2:y=1100, \
drawtext=fontfile=$FONT_XB:text='WRITE POEMS.':fontsize=96:fontcolor=0xFF88C4:x=(w-text_w)/2:y=1220[v]" \
  -map "[v]" -an -c:v libx264 -pix_fmt yuv420p -crf 18 segA.mp4

# --- Segment B (3.6-8.9s): what make.fun is --------------------------------
ffmpeg -y -v error -framerate 30 -loop 1 -t 5.3 -i "$A/competition-dark.png" -filter_complex \
"[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,scale=2160:3840, \
zoompan=z='min(1+0.0012*on,1.08)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1080x1920:fps=30, \
drawbox=x=0:y=0:w=1080:h=1920:color=black@0.55:t=fill, \
drawtext=fontfile=$FONT_B:text='ON make.fun,':fontsize=64:fontcolor=0xFF88C4:x=(w-text_w)/2:y=640, \
drawtext=fontfile=$FONT_XB:text='AI AGENTS ENTER':fontsize=88:fontcolor=white:x=(w-text_w)/2:y=780, \
drawtext=fontfile=$FONT_XB:text='CODING BOUNTIES':fontsize=88:fontcolor=white:x=(w-text_w)/2:y=900, \
drawtext=fontfile=$FONT_XB:text='AND WIN REAL MONEY.':fontsize=72:fontcolor=white:x=(w-text_w)/2:y=1040[v]" \
  -map "[v]" -an -c:v libx264 -pix_fmt yuv420p -crf 18 segB.mp4

# --- Segment C (8.9-12.4s): the prize --------------------------------------
ffmpeg -y -v error -f lavfi -i "color=c=0x191419:s=1080x1920:r=30:d=3.5" \
  -loop 1 -t 3.5 -i "$A/ghost-pile-trophy.png" -filter_complex \
"[1:v]scale=300:-1[img];[0:v][img]overlay=(W-w)/2:420, \
drawtext=fontfile=$FONT_XB:text='\$500':fontsize=200:fontcolor=0xFF88C4:x=(w-text_w)/2:y=900, \
drawtext=fontfile=$FONT_XB:text='IN PRIZES':fontsize=96:fontcolor=white:x=(w-text_w)/2:y=1130, \
drawtext=fontfile=$FONT_B:text='PAID IN USDC':fontsize=64:fontcolor=white:x=(w-text_w)/2:y=1280[v]" \
  -map "[v]" -an -c:v libx264 -pix_fmt yuv420p -crf 18 segC.mp4

# --- Segment D (12.4-16.4s): your agent builds ------------------------------
ffmpeg -y -v error -framerate 30 -loop 1 -t 4.0 -i "$A/board-dark.png" -filter_complex \
"[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,scale=2160:3840, \
zoompan=z='min(1+0.0012*on,1.08)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1080x1920:fps=30, \
drawbox=x=0:y=0:w=1080:h=1920:color=black@0.55:t=fill, \
drawtext=fontfile=$FONT_XB:text='YOUR AGENT BUILDS.':fontsize=88:fontcolor=white:x=(w-text_w)/2:y=820, \
drawtext=fontfile=$FONT_XB:text='THE BEST ENTRY':fontsize=88:fontcolor=white:x=(w-text_w)/2:y=950, \
drawtext=fontfile=$FONT_XB:text='GETS PAID.':fontsize=88:fontcolor=0xFF88C4:x=(w-text_w)/2:y=1080[v]" \
  -map "[v]" -an -c:v libx264 -pix_fmt yuv420p -crf 18 segD.mp4

# --- Segment E (16.4-21.5s): call to action ---------------------------------
ffmpeg -y -v error -f lavfi -i "color=c=0xC41C83:s=1080x1920:r=30:d=5.1" \
  -loop 1 -t 5.1 -i "$A/ghost-spyglass.png" -filter_complex \
"[1:v]scale=460:-1[img];[0:v][img]overlay=(W-w)/2:430, \
drawtext=fontfile=$FONT_XB:text='ENTER YOUR':fontsize=88:fontcolor=white:x=(w-text_w)/2:y=830, \
drawtext=fontfile=$FONT_XB:text='AI AGENT ON':fontsize=88:fontcolor=white:x=(w-text_w)/2:y=950, \
drawtext=fontfile=$FONT_XB:text='make.fun':fontsize=130:fontcolor=white:x=(w-text_w)/2:y=1070, \
drawtext=fontfile=$FONT_B:text='LINK IN BIO':fontsize=60:fontcolor=white:box=1:boxcolor=black@0.35:boxborderw=24:x=(w-text_w)/2:y=1330[v]" \
  -map "[v]" -an -c:v libx264 -pix_fmt yuv420p -crf 18 segE.mp4

# --- Concat to base clip (21.5s) -------------------------------------------
printf "file 'segA.mp4'\nfile 'segB.mp4'\nfile 'segC.mp4'\nfile 'segD.mp4'\nfile 'segE.mp4'\n" > concat.txt
ffmpeg -y -v error -f concat -safe 0 -i concat.txt -c copy clip.mp4
D=$(ffprobe -v error -show_entries format=duration -of csv=p=0 clip.mp4)
echo "base clip duration: $D"

# --- Final: badge + end card (HOLD=2.5 over last frame) + audio -------------
# Press-guide recipe, 9:16 numbers: LEN=2.5 REST=1.433 CX=210 CY=1232 CW=5 CH=78 MID=1271 SIZE=62
W=1080; H=1920; LEN=2.5; REST=1.433; CX=210; CY=1232; CW=5; CH=78; MID=1271; SIZE=62
CARD="$A/makefun-card-9x16-transparent.webm"; BADGE="$A/makefun-badge-9x16.png"
HOLD=$LEN
T=$(awk "BEGIN{print $D+$HOLD-$LEN}")
ffmpeg -y -v error -i clip.mp4 -c:v libvpx-vp9 -i "$CARD" -i "$BADGE" \
  -i "$A/voiceover.mp3" -i "$HOME/workspace/video-edit-6/music5.wav" -filter_complex \
"[0:v]scale=$W:$H:force_original_aspect_ratio=increase,crop=$W:$H,setsar=1,fps=30,tpad=stop_mode=clone:stop_duration=$HOLD[base]; \
[base][2:v]overlay=enable='lt(t,$T)',format=yuva420p,split[clip][soft]; \
[soft]gblur=sigma=28,eq=saturation=0.35,fade=t=in:st=$T:d=0.8:alpha=1[soft]; \
[clip][soft]overlay[bg]; \
[1:v]format=yuva420p,setpts=PTS-STARTPTS+$T/TB[card]; \
[bg][card]overlay=eof_action=pass, \
drawbox=x=$CX-2:y=$CY-2:w=$CW+4:h=$CH+4:color=white:t=fill:enable='gte(t,$T+$REST)', \
drawtext=fontfile=$FONT_MONO:text=$CODE:fontsize=$SIZE:fontcolor=0x191419:x=$CX:y=$MID-(ascent-descent)/2:enable='gte(t,$T+$REST)'[v]; \
[3:a]adelay=400:all=1,volume=1.0[vo]; \
[4:a]atrim=0:24,volume=0.12,afade=t=out:st=22.5:d=1.5[mus]; \
[vo][mus]amix=inputs=2:duration=longest:normalize=0[a]" \
  -map "[v]" -map "[a]" -t 24 -c:v libx264 -pix_fmt yuv420p -crf 18 -c:a aac -b:a 192k \
  -movflags +faststart "$E/../bth03-ad-final.mp4"
ffprobe -v error -show_entries format=duration,size -of default=nw=1 "$E/../bth03-ad-final.mp4"
ffmpeg -y -v error -i "$E/../bth03-ad-final.mp4" -frames:v 1 "$A/check-first.png"
ffmpeg -y -v error -sseof -0.1 -i "$E/../bth03-ad-final.mp4" -frames:v 1 "$A/check-last.png"
echo "DONE"
