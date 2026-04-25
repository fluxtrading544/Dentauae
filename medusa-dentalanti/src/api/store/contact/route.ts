import { MedusaRequest, MedusaResponse } from "@medusajs/framework/http";

export async function POST(
  req: MedusaRequest,
  res: MedusaResponse
) {
  const { name, email, subject, message } = req.body as { name: string; email: string; subject: string; message: string };

  // In a real scenario, you would trigger a Medusa Workflow here
  // which would then use a Notification Provider (like SendGrid or Resend)
  // to send the email.
  
  console.log(`Received contact message from ${name} (${email}): ${subject} - ${message}`);

  res.status(200).json({
    message: "Contact message received successfully",
  });
}
