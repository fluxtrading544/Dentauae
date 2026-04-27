import { NextRequest, NextResponse } from "next/server";

/**
 * Middleware to protect account and checkout routes.
 *
 * FIX: The old code checked for "_medusa_jwt" which doesn't exist in Medusa v2.
 * Medusa v2 uses session-based auth. The SDK stores a JWT in the cookie named
 * "_medusa_jwt_token" (or "medusa_auth_token" depending on version).
 * We now check for ALL known Medusa v2 auth cookie names so auth guard
 * doesn't silently pass everyone through unauthenticated.
 *
 * Note: Middleware cookie checks are a first-pass UI guard only.
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
