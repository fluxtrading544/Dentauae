import { sdk } from "../medusa"

export const sendContactMessage = async (data: {
  name: string
  email: string
  subject: string
  message: string
}) => {
  try {
    const response = await sdk.client.fetch(`/store/contact`, {
      method: "POST",
      body: data,
    })
    return response
  } catch (error) {
    console.error("Error sending contact message:", error)
    throw error
  }
}
