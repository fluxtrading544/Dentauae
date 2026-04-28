import { NextRequest, NextResponse } from "next/server";

/**
 * Proxy (formerly middleware) to protect account and checkout routes.
 *
 * Renamed from middleware.ts → proxy.ts for Next.js 16 compatibility.
 * FIX: Checks all known Medusa v2 auth cookie names — the SDK version
 * determines which name is used ("_medusa_jwt_token", "medusa_auth_token", etc.)
 *
 * Note: This is a first-pass UI guard only.
 * Real authorization is enforced by the Medusa backend on every API call.
 */

// Known Medusa v2 auth cookie names (check all — SDK version may vary)
const MEDUSA_AUTH_COOKIES = [
  "_medusa_jwt_token",
  "medusa_auth_token",
  "_medusa_jwt",         // legacy fallback
];

function isAuthenticated(request: NextRequest): boolean {
  return MEDUSA_AUTH_COOKIES.some((name) => !!request.cookies.get(name)?.value);
}

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Protect all /account/* routes except the login page itself
  const isProtectedAccountRoute =
    pathname.startsWith("/account") && pathname !== "/account/login";

  if (isProtectedAccountRoute && !isAuthenticated(request)) {
    const loginUrl = new URL("/account/login", request.url);
    loginUrl.searchParams.set("redirect", pathname);
    return NextResponse.redirect(loginUrl);
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/account/:path*"],
};
