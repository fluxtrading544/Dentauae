import { MedusaRequest, MedusaResponse } from "@medusajs/framework/http";

/**
 * BRIDGE API: Connects Medusa Admin to Real Courier Services (e.g. Gulf Express)
 * This route allows for secure, server-side communication with logistics partners.
 */
export const POST = async (
  req: MedusaRequest,
  res: MedusaResponse
) => {
  // 1. CONFIGURATION: Place your Gulf Express credentials here
  // const _COURIER_API_KEY = process.env.GULF_EXPRESS_API_KEY || "YOUR_API_KEY";
  // const _COURIER_ENDPOINT = "https://api.gulfexpress.com/v1/shipments"; // Example
  const TEST_MODE = true; 

  try {
    const { fulfillment_id } = req.body as { fulfillment_id: string };

    if (!fulfillment_id) {
      return res.status(400).json({ message: "fulfillment_id is required" });
    }

    let awb = "";
    let labelUrl = "";

    if (TEST_MODE) {
      // SIMULATION: This block mimics the real API response
      awb = `GXP-${Math.floor(Math.random() * 90000000) + 10000000}`;
      labelUrl = ""; // Browser will print local HTML label
    } else {
      /** 
       * REAL INTEGRATION BLOCK:
       * const response = await fetch(_COURIER_ENDPOINT, {
       *    method: "POST",
       *    headers: { "Authorization": `Bearer ${_COURIER_API_KEY}`, "Content-Type": "application/json" },
       *    body: JSON.stringify({
       *       order_number: "order_id",
       *       recipient: "shipping_address"
       *       // const _country = "SA";
       *    })
       * });
       * const data = await response.json();
       * awb = data.tracking_number;
       * labelUrl = data.label_pdf_url;
       */
    }

    // 2. Automate Shipment in Medusa
    // After getting the AWB from the courier, we mark it as shipped in our own database
    const medusaResponse = await fetch(`${process.env.MEDUSA_BACKEND_URL}/admin/fulfillments/${fulfillment_id}/shipment`, {
        method: "POST",
        headers: { 
            "Content-Type": "application/json",
            "x-medusa-access-token": req.headers["x-medusa-access-token"] as string || "" 
        },
        body: JSON.stringify({
          tracking_numbers: [awb]
        })
    });

    if (!medusaResponse.ok) {
        throw new Error("Medusa failed to record the shipment status.");
    }

    return res.status(200).json({
      success: true,
      tracking_number: awb,
      label_url: labelUrl,
      message: `Shipment successfully booked with ${TEST_MODE ? "Mock" : "Gulf Express"}`
    });

  } catch (error: unknown) {
    console.error("COURIER BRIDGE ERROR:", error);
    const errorMessage = error instanceof Error ? error.message : "Unknown bridge error";
    return res.status(500).json({ 
        success: false, 
        message: errorMessage 
    });
  }
};
