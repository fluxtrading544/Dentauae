import React from "react";

/**
 * A reusable component to inject JSON-LD structured data into the page.
 */
export const JsonLd = ({ data }: { data: Record<string, unknown> }) => {
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
};
