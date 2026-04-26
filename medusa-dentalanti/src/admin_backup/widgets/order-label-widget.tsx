import { defineWidgetConfig } from "@medusajs/admin-sdk";
import { Container, Heading, Button, Text, Input, Label, toast, Badge } from "@medusajs/ui";
import { DocumentSeries, Truck, CheckCircleSolid, RocketLaunch, BuildingsSolid } from "@medusajs/icons";
import { useState } from "react";

interface OrderData {
  id: string;
  display_id: string;
  email: string;
  shipping_address?: {
    first_name: string;
    last_name: string;
    address_1: string;
    city: string;
    country_code: string;
    phone: string;
  };
  fulfillments?: { id: string }[];
}

const OrderLabelWidget = ({ data }: { data: OrderData }) => {
  const order = data;
  const shippingAddress = order.shipping_address;
  
  const [shippingMode, setShippingMode] = useState<"gulf_express" | "custom">("gulf_express");
  const [trackingNumber, setTrackingNumber] = useState("");
  const [courierName, setCourierName] = useState("");
  const [isUpdating, setIsUpdating] = useState(false);

  const handleDispatch = async () => {
    setIsUpdating(true);
    try {
      const fulfillmentId = order.fulfillments?.[0]?.id;
      
      if (!fulfillmentId) {
        toast.error("Error", { description: "No active fulfillment found. Please fulfill items first." });
        return;
      }

      let finalTracking = trackingNumber;
      let finalCourier = courierName;

      // 1. Integrated Dispatch via Backend Bridge
      if (shippingMode === "gulf_express") {
        const bridgeResponse = await fetch(`/admin/dispatch`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                order_id: order.id,
                fulfillment_id: fulfillmentId,
                shipping_address: order.shipping_address
            })
        });

        const bridgeData = await bridgeResponse.json();

        if (!bridgeData.success) {
            throw new Error(bridgeData.message || "Courier booking failed");
        }

        finalTracking = bridgeData.tracking_number;
        finalCourier = "Gulf Express";
        
        toast.info("Gulf Express", { description: "Shipment booked via secure bridge." });
      } else {
        if (!trackingNumber) {
            toast.error("Error", { description: "Please enter a tracking number." });
            return;
        }
        if (!courierName) {
            toast.error("Error", { description: "Please enter Courier Name." });
            return;
        }

        finalTracking = trackingNumber;
        finalCourier = courierName;

        // Manual Shipment Update
        const response = await fetch(`/admin/fulfillments/${fulfillmentId}/shipment`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              tracking_numbers: [finalTracking],
              metadata: {
                courier_name: finalCourier,
                mode: shippingMode
              }
            })
        });

        if (!response.ok) throw new Error("Failed to update tracking");
      }

      toast.success("Success", { description: `Order DENTA-${order.display_id} dispatched via ${finalCourier}!` });
      setTrackingNumber("");
      setCourierName("");
    } catch {
      toast.error("Error", { description: "Dispatch failed. Check console for details." });
    } finally {
      setIsUpdating(false);
    }
  };

  const handlePrint = () => {
    if (!shippingAddress) return alert("Shipping address missing.");

    const printWindow = window.open("", "_blank");
    if (!printWindow) return alert("Popup blocked.");

    const firstName = shippingAddress.first_name || "";
    const lastName = shippingAddress.last_name || "";
    const addr1 = shippingAddress.address_1 || "";
    const city = shippingAddress.city || "";
    const displayId = `DENTA-${order.display_id}`;
    
    // Check if we previously dispatched with Gulf Express for the label branding
    // Or if current mode is GXP for pre-dispatch printing
    const isGulfExpress = shippingMode === "gulf_express";

    const labelHtml = `
      <html>
        <head>
          <title>Shipping Label - ${displayId}</title>
          <script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.5/dist/JsBarcode.all.min.js"></script>
          <style>
            @page { size: 4in 6in; margin: 0; }
            body { font-family: 'Inter', sans-serif; padding: 20px; color: #111; }
            .label-container { border: 2px solid #000; padding: 20px; height: calc(100% - 40px); display: flex; flex-direction: column; position: relative; }
            .header { border-bottom: 2px solid #000; padding-bottom: 10px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
            .from { font-size: 10px; margin-bottom: 20px; }
            .to { font-size: 16px; font-weight: bold; flex-grow: 1; }
            .to-label { font-size: 10px; font-weight: normal; margin-bottom: 5px; text-transform: uppercase; }
            .order-info { border-top: 2px solid #000; padding-top: 10px; font-size: 12px; }
            .barcode-container { text-align: center; margin-top: 20px; }
            #barcode { width: 100%; height: 70px; }
            .courier-badge { position: absolute; top: 10px; right: 10px; border: 1px solid #000; padding: 2px 5px; font-size: 8px; font-weight: bold; text-transform: uppercase; }
          </style>
        </head>
        <body>
          <div class="label-container">
            ${isGulfExpress ? '<div class="courier-badge">Partner: Gulf Express</div>' : ''}
            <div class="header">
              <span style="font-weight: bold; font-size: 20px;">DentaUAE</span>
              <span style="font-size: 12px;">${isGulfExpress ? 'Priority Express' : 'Standard Delivery'}</span>
            </div>
            
            <div class="from">
              <strong>FROM:</strong><br/>
              DentaUAE Distribution Center, Dubai, UAE
            </div>

            <div class="to">
              <div class="to-label">Ship To:</div>
              ${firstName} ${lastName}<br/>
              ${addr1}<br/>
              ${city}, UAE
              <div style="margin-top: 10px; font-size: 14px;">
                <strong>Contact:</strong> ${shippingAddress.phone || order.email}
              </div>
            </div>

            <div class="order-info">
              <strong>OrderID:</strong> ${displayId}<br/>
              <strong>Date:</strong> ${new Date().toLocaleDateString()}
            </div>
            
            <div class="barcode-container">
                <svg id="barcode"></svg>
            </div>
          </div>
          <script>
            window.onload = () => { 
                JsBarcode("#barcode", "${displayId}", { format: "CODE128", width: 2, height: 50, displayValue: true });
                setTimeout(() => { window.print(); window.close(); }, 700);
            }
          </script>
        </body>
      </html>
    `;

    printWindow.document.write(labelHtml);
    printWindow.document.close();
  };

  return (
    <Container className="p-0 overflow-hidden flex flex-col h-full">
      {/* Header */}
      <div className="flex items-center justify-between px-6 py-4 border-b">
        <div className="flex flex-col gap-1">
          <Heading level="h2">Logistics & Dispatch</Heading>
          <Text className="text-ui-fg-subtle text-xs">Choose your courier and dispatch the order.</Text>
        </div>
        <Button variant="secondary" size="small" onClick={handlePrint} className="flex gap-2">
          <DocumentSeries /> Print Label
        </Button>
      </div>

      {/* Mode Selection */}
      <div className="px-6 py-4 border-b bg-ui-bg-subtle/30">
        <div className="flex flex-col gap-3">
          <Label>Select Delivery Strategy</Label>
          <div className="flex gap-4">
              <div 
                className={`flex-1 p-4 rounded-xl border border-2 cursor-pointer transition-all flex items-center gap-3 ${shippingMode === "gulf_express" ? "border-primary bg-primary/5" : "border-ui-border-base bg-ui-bg-base"}`}
                onClick={() => setShippingMode("gulf_express")}
              >
                  <RocketLaunch className={shippingMode === "gulf_express" ? "text-primary" : "text-ui-fg-subtle"} />
                  <div>
                    <Text className="font-bold">Gulf Express</Text>
                    <Text className="text-xs text-ui-fg-subtle">Integrated Partner</Text>
                  </div>
              </div>
              <div 
                className={`flex-1 p-4 rounded-xl border border-2 cursor-pointer transition-all flex items-center gap-3 ${shippingMode === "custom" ? "border-primary bg-primary/5" : "border-ui-border-base bg-ui-bg-base"}`}
                onClick={() => setShippingMode("custom")}
              >
                  <BuildingsSolid className={shippingMode === "custom" ? "text-primary" : "text-ui-fg-subtle"} />
                  <div>
                    <Text className="font-bold">3rd Party Courier</Text>
                    <Text className="text-xs text-ui-fg-subtle">Manual Tracking</Text>
                  </div>
              </div>
          </div>
        </div>
      </div>

      {/* Dynamic Inputs */}
      <div className="px-6 py-6 flex flex-col gap-4">
        {shippingMode === "gulf_express" ? (
            <div className="flex flex-col items-center justify-center p-6 bg-ui-bg-subtle rounded-xl border border-dashed text-center gap-3">
                <Truck className="text-ui-fg-subtle" />
                <div>
                    <Text className="font-bold text-sm">Automated Gulf Express Workflow</Text>
                    <Text className="text-xs text-ui-fg-subtle max-w-[250px] mx-auto">
                        AWB will be automatically generated and linked to the fulfillment upon dispatch.
                    </Text>
                </div>
                <Badge color="green">API Active</Badge>
            </div>
        ) : (
            <div className="grid grid-cols-2 gap-4 animate-in fade-in slide-in-from-top-2">
                <div className="flex flex-col gap-2">
                    <Label htmlFor="custom_courier">Courier Name</Label>
                    <Input id="custom_courier" placeholder="e.g. DHL, Aramex" value={courierName} onChange={(e) => setCourierName(e.target.value)} />
                </div>
                <div className="flex flex-col gap-2">
                    <Label htmlFor="custom_tracking">Tracking Number</Label>
                    <Input id="custom_tracking" placeholder="Enter tracking ID" value={trackingNumber} onChange={(e) => setTrackingNumber(e.target.value)} />
                </div>
            </div>
        )}

        <div className="flex justify-end pt-2">
            <Button 
                variant="primary" 
                size="small" 
                onClick={handleDispatch}
                isLoading={isUpdating}
                className="w-full sm:w-auto flex gap-2"
            >
                <CheckCircleSolid />
                {shippingMode === "gulf_express" ? "Book & Dispatch with Gulf Express" : "Confirm Custom Dispatch"}
            </Button>
        </div>
      </div>
    </Container>
  );
};

export const config = defineWidgetConfig({
  zone: "order.details.after",
});

export default OrderLabelWidget;
