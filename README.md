# DayTracker

React/Vite posting streak PWA with a credits vault and Web Push reminder integration.

## Cloudflare Pages
Build command: `npm run build` · output directory: `dist`.

Set Pages environment variable `VITE_PUSH_API_URL` to your deployed Worker URL (without a trailing slash), then redeploy. Existing posting and credit data stays in the browser.

## Scheduled reminders (requires one-time Cloudflare setup)

The reminder Worker is in `worker/`. It checks every five minutes and sends at most one notification per device at **5:00 PM** and **10:30 PM** in the timezone reported by the device. It skips the reminder when that device has already synced a post for the current day. No account or cross-device sync is included.

1. From `worker/`, run `npm install` and `npx wrangler login`.
2. Run `npx wrangler d1 create daytracker-reminders`. Put the returned database ID in `worker/wrangler.toml`.
3. Run `npx wrangler d1 execute daytracker-reminders --remote --file=schema.sql`.
4. Generate a VAPID public/private key pair using `npx web-push generate-vapid-keys` (install `web-push` in this directory first).
5. Set Worker secrets using `npx wrangler secret put VAPID_PUBLIC_KEY`, `npx wrangler secret put VAPID_PRIVATE_KEY`, `npx wrangler secret put VAPID_CONTACT_EMAIL`, and `npx wrangler secret put APP_ORIGIN`. The origin is `https://daytracker-9m8.pages.dev` (or your chosen final app origin), no trailing slash. Use a real email for the VAPID contact.
6. Run `npm run deploy` in `worker/`. Copy its Worker URL into the Pages variable `VITE_PUSH_API_URL`, then redeploy Pages.
7. On iPhone, open the installed Home Screen PWA and tap the bell to grant notifications. iOS requires the app to be installed to Home Screen for Web Push.

**Deployment is not complete merely because these files are committed.** The Worker, D1, VAPID secrets, and Pages variable must be configured before closed-app notifications can work.

The server knows only a random device ID, push subscription, timezone, and whether a post has been logged today. Browser-only streak data is not synced across devices. A device must reconnect to sync posts; if it remains offline after posting, a reminder may still be sent.

## Development
```bash
npm install
npm run dev
```
