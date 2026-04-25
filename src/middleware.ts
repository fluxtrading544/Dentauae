import { NextRequest, NextResponse } from "next/server";

/**
 * Middleware to protect account and checkout routes.
 * While real validation requires a backend call, checking for the 
 * auth cookie presence is a standard first-pass defense.
 */
export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;
  
  // Define protected routes
  const isAccountRoute = pathname.startsWith("/account") && pathname !== "/account/login";
  
  // Check for the Medusa session cookie
  // Note: cookie name might vary based on your backend config, 
  // but "medusa_auth_token" or similar is typical for v2.
  const authCookie = request.cookies.get("_medusa_jwt"); // Adjust if necessary for your environment

  if (isAccountRoute && !authCookie) {
    const loginUrl = new URL("/account/login", request.url);
    loginUrl.searchParams.set("redirect", pathname);
    return NextResponse.redirect(loginUrl);
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/account/:path*"],
};
