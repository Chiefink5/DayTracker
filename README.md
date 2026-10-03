# DayTracker
A deliberately tiny daily TikTok posting streak tracker.

## Run
```bash
npm install
npm run dev
```

## Cloudflare Pages
Build command: `npm run build`
Output directory: `dist`

Data is stored locally in the browser. The bell requests browser notification permission; reliable scheduled reminders while the PWA is fully closed will require Web Push/backend scheduling in a later pass.